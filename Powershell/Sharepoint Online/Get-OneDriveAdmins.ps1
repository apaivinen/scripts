<#
.SYNOPSIS
    Get a report of unwanted onedrive admins

.DESCRIPTION

    IMPORTANT: 
        Admin user needs to be personal site administrator for each user to be able to check other administrators.
        This script will automatically add user specified in $AdminAccount to users personal site as an admin.
        After checking for other admins is done $AdminAccount is removed from users personal site.

    Update following config variables:
    $AdminURL
    $AdminAccount

    The script logic:
        1. Get all personal sites (onedrives)
        2. Check if $AdminAccount is users onedrive admin. Adds $AdminAccount to users onedrive admin
        3. Check for other admins, excluding onedrive owner and $AdminAccount
        4. If other admins are found a new line will be added to log.csv
        5. Removes $AdminAccount from users onedrive admin list

.INPUTS
    None

.OUTPUTS
    Log file stored in .\log.csv
    Log contains onedrive URL and User email if addional admins are found
    Log file is using ; (semicolon) as a separator

.NOTES
    Version: 			1.0
    Author: 			Anssi Päivinen
    Creation Date: 		17.3.2023
    Purpose/Change: 	Initial script development

.EXAMPLE
    .\Get-OneDriveAdmins.ps1

#>

#Config Variables
$AdminURL = "https://tenant-admin.sharepoint.com/" # This needs to be a sharepoint admin url
$AdminAccount = "user@tenant.onmicrosoft.com" # This requires a user account with Sharepoint Administrator role

connect-sposervice -Url $AdminURL

$PersonalSites = Get-SPOSite -IncludePersonalSite $true -Filter { Url -like "-my.sharepoint.com/personal/" }

foreach ($site in $PersonalSites) {
    write-host "Checking onedrive: " $site.url
    try{
        $checkadmin = Get-SPOUser -Site $Site.Url | Where {$_.IsSiteAdmin -eq $true -and $_.LoginName -eq $AdminAccount}
        $setAdmin = $false;

        #Add Temp Site Admin
        if($checkadmin.Count -eq 0){
            Write-host "Add Temp Admin:"$Site.URL -ForegroundColor Gray
            Set-SPOUser -Site $Site -LoginName $AdminAccount -IsSiteCollectionAdmin $True | Out-Null            
            $setAdmin = $true
        }
    }catch{
        #Write-Host "Error:" $_.Exception.Message
        if($_.Exception.Message -like "Access is denied*"){
            Write-host "Add Temp Admin:"$Site.URL -ForegroundColor Gray
            Set-SPOUser -Site $Site -LoginName $AdminAccount -IsSiteCollectionAdmin $True | Out-Null            
            $setAdmin = $true
        }
    }
 
    #Get Personal site Administrators excluding personal site owner and $AdminAccount
    $SiteAdmins = Get-SPOUser -Site $Site.Url | Where {$_.IsSiteAdmin -eq $true -and $_.LoginName -ne $AdminAccount -and $_.LoginName -ne $Site.Owner}

    #Check if there's more than one admin
    if($SiteAdmins.Count -gt 0){
 
        #Iterate through each admin
        Foreach($Admin in $SiteAdmins)
        {
            Write-host "Found other Admin:"$Admin.LoginName -ForegroundColor Magenta
            $AddToFile = $Site.Url+";"+$Admin.LoginName
            Add-Content -Path .\log.csv -Value $AddToFile
            
        }
    }

    #Remove Temp Site Administrator if added
    if($setAdmin -eq $true){        
        Write-host "Remove Temp Admin:"$Site.URL -ForegroundColor Gray    
        Set-SPOUser -site $Site -LoginName $AdminAccount -IsSiteCollectionAdmin $False | Out-Null
        #Remove-SPOUser -Site $Site -LoginName $AdminAccount
    }
}


<#
.SYNOPSIS
    Bulk set Microsoft Teams team to private

.DESCRIPTION
    Bulk set Microsoft Teams team from public to private according to CSV-file

.INPUTS
    CSV file which needs to be defined in line 43 for variable $csv

.NOTES
    Version: 			1.0
    Author: 			Anssi Päivinen
    Creation Date: 		13.10.2023
    Purpose/Change: 	Initial script development

    REQUIREMENTS:
    - Sharepoint Administrator Role
    - PnP.Powershell module
     - install-module pnp.powershell -Scope CurrentUser -AllowClobber -Force
     - Import-Module Pnp.powershell

     Required columns in CSV file
     - Group ID
        - Contains M365 Group ID
     - Privateksi?
        - Contains TRUE for teams which needs to be privated

    MODIFY VARIABLES:
        - $SiteURL in line
        - $CSV in line
.EXAMPLE
    .\set-teamsprivate.ps1

#>

#Connect to SPO Admin
$SiteURL = "https://TENANTNAME-admin.sharepoint.com"
Connect-PnPOnline -Url $SiteURL -DeviceLogin

#import CSV file
$csv = Import-Csv -Delimiter ";" -Path "D:\FILE-PATH-HERE.csv"

#Loop through data
foreach($row in $csv){
    if($row.'Privateksi?' -eq "TRUE"){

         #Change the Group from Private to Public
        Set-PnPMicrosoft365Group -Identity $row.'Group ID' -IsPrivate:$True

    }#If privateksi -eq TRUE
}#foreach
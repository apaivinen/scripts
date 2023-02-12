<#
.SYNOPSIS
    Remove unique subweb permissions

.DESCRIPTION
    Remove all unique subweb permission from site collection

    This script requires pnp.powershell module

.PARAMETER SiteCollectionUrl
    url of the site collection

.NOTES
    Version: 			1.0
    Author: 			Anssi Päivinen
    Creation Date: 		30.3.2022
    Purpose/Change: 	Initial script development

.EXAMPLE
    .\Set-SiteCollectionPermissions.ps1 -SiteCollectionUrl https://TENANTNAME.sharepoint.com/sites/SITECOLLECTION

#>

[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $SiteCollectionUrl
)

Connect-PnPOnline -Url $SiteCollectionUrl -interactive

$Allwebs = Get-PnPsubweb -Recurse

foreach ($web in $Allwebs) {
    write-host "Processing web: " -NoNewline
    write-host $web.Title -ForegroundColor Green

    write-host "connecting to: "$web.url

    Connect-PnPOnline -Url $web.url -interactive
    $webinfo = Get-PnPweb -Includes HasUniqueRoleAssignments, RoleAssignments

    if ($webinfo.HasUniqueRoleAssignments -eq $true) {

        write-host "This site have unique permissions. Removing unique permissions." -ForegroundColor red
        $webinfo.ResetRoleInheritance()
        Invoke-PnPQuery
    }#if unique role assigments eq true
}#foreach AllWebs

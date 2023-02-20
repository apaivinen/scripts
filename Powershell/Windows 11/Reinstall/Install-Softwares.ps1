<#
.SYNOPSIS
          Installs my default softwares through winget to windows 11

.DESCRIPTION
          Installs my default softwares through winget to windows 11

          Softare list is defined in $apps variable in begin block

          Modify execution policy
          Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser

          Run script as user (not admin) so for example spotify can be installed.

          Quickstart:
                    1. Check and modify $app variable in begin block
                    2. Open powershell as users
                    3. Modify execution policy (if not modified)
                    4. Run the script

          The script could be much simplier but I wanted to train powershell scripting skills

          Script itself is simple.
          Begin block contains:
                    - Function which controls installing from winget / msstore source.
                    - apps list (variable)
          Process block contains:
                    - Loop through softwares
                    - Checks if software exists in repositories (sources)
                    - Function call to install the software
          End block contains:
                    - Variable cleanup

.INPUTS
          None

.OUTPUTS
          Install softwares specified in $apps to windows 11

.NOTES
          Version:            1.1
          Author:             Anssi Päivinen
          Creation Date:      18.2.2023
          Modified Date:      19.2.2023
          Purpose/Change:     Modified $apps and added helps

.EXAMPLE
          .\Install-Softwares.ps1

#>


begin {
          <#
          Begin contains Functions & Configs
          #>

          function Install-Software {
                    <#
          .SYNOPSIS
                    Installs software through winget

          .DESCRIPTION
                    Installs software through winget

          .PARAMETER id
                    Type: String
                    Needs to be valid software ID from winget

          .PARAMETER name
                    Type: String
                    Name of the application. If app source is from winget this value doesn't matter.
                    If source is from MSStore then this should be accurate name of the application due to winget not finding corrrect app via ID...

          .PARAMETER source
                    Type: String
                    Valid values winget or msstore
                    If more sources are used then don't forget to update IF-condition to include sources.
          .INPUTS
                    None

          .OUTPUTS
                    Software by specified ID/Name is installed

          .NOTES
                    Version: 		1.0
                    Author: 		Anssi Päivinen
                    Creation Date: 	18.2.2023
                    Purpose/Change: 	Initial script development

          .EXAMPLE
                    Install-Software -id "Git.Git" -name "Git" -source "winget"
                    Install-Software -id "9N2T6F9F5ZDN" -name "Nightingale" -source "msstore"

          #>
                    [CmdletBinding()]
                    param (
                              [Parameter(Mandatory = $true)][string] $id,
                              [Parameter(Mandatory = $true)][string] $name,
                              [Parameter(Mandatory = $true)][string] $source
                    )

                    write-host "Installing app: " -ForegroundColor green -NoNewline
                    write-host $name -NoNewline
                    write-host " From source: " -ForegroundColor Green -NoNewline
                    write-host $source
                    if ($source -eq "winget") {
                              #write-host "winget"
                              winget install --exact --silent --accept-package-agreements --accept-source-agreements --id $id --source $source --no-upgrade --disable-interactivity
                    }# winget
                    if ($source -eq "msstore") {
                              #write-host "msstore"
                              winget install --silent --accept-package-agreements --accept-source-agreements --name $name --source $source --no-upgrade --disable-interactivity
                    }# msstore
          }# End of function Install-Softwares

          $apps = @(
                    @{name = "7zip"; id = "7zip.7zip"; source = "winget" },
                    @{name = "Affinity Designer 2"; id = "9N2D0P16C80H"; source = "msstore" },
                    @{name = "Affinity Photo 2"; id = "9P8DVF1XW02V"; source = "msstore" },
                    @{name = "Balena Etcher"; id = "Balena.Etcher"; source = "winget" },
                    @{name = "Bitwarden desktop client"; id = "Bitwarden.Bitwarden"; source = "winget" },
                    @{name = "Brave browser"; id = "Brave.Brave"; source = "winget" },
                    @{name = "Discord"; id = "Discord.Discord"; source = "winget" },
                    @{name = "Facebook Messenger"; id = "Facebook.Messenger"; source = "winget" },
                    @{name = "Flameshot"; id = "Flameshot.Flameshot"; source = "winget" },
                    @{name = "Git"; id = "Git.Git"; source = "winget" },
                    @{name = "Google Chrome"; id = "Google.Chrome"; source = "winget" },
                    @{name = "MakeMKV"; id = "GuinpinSoft.MakeMKV"; source = "winget" },
                    @{name = "Logitech GHub"; id = "Logitech.GHUB"; source = "winget" },
                    @{name = "Microsoft Edge"; id = "Microsoft.Edge"; source = "winget" },
                    @{name = "Microsot Power Automate Desktop"; id = "Microsoft.PowerAutomateDesktop"; source = "winget" },
                    @{name = "Microsoft PowerToys"; id = "Microsoft.PowerToys"; source = "winget" },
                    @{name = "Microsoft Autoruns"; id = "Microsoft.Sysinternals.Autoruns"; source = "winget" },
                    @{name = "Microsoft Process Explorer"; id = "Microsoft.Sysinternals.ProcessExplorer"; source = "winget" },
                    @{name = "Microsoft Process Monitor"; id = "Microsoft.Sysinternals.ProcessMonitor"; source = "winget" },
                    @{name = "Microsoft VisualStudio Code"; id = "Microsoft.VisualStudioCode"; source = "winget" },
                    @{name = "Microsoft Terminal"; id = "Microsoft.WindowsTerminal"; source = "winget" },
                    @{name = "Microsoft Powershell 7+"; id = "Microsoft.PowerShell"; source = "winget" },
                    @{name = "Min browser"; id = "Min.Min"; source = "winget" },
                    @{name = "Minecraft Launcher"; id = "Mojang.MinecraftLauncher"; source = "winget" },
                    @{name = "Firefox"; id = "Mozilla.Firefox"; source = "winget" },
                    @{name = "Netflix"; id = "9WZDNCRFJ3TJ"; source = "msstore" },
                    @{name = "ScreenToGif"; id = "NickeManarin.ScreenToGif"; source = "winget" },
                    @{name = "Nightingale"; id = "9N2T6F9F5ZDN"; source = "msstore" },
                    @{name = "NZXT CAM"; id = "NZXT.CAM"; source = "winget" },
                    @{name = "Obsidian"; id = "Obsidian.Obsidian"; source = "winget" },
                    @{name = "OBS"; id = "OBSProject.OBSStudio"; source = "winget" },
                    @{name = "Plex"; id = "Plex.Plex"; source = "winget" },
                    @{name = "Microsoft Remote Desktop"; id = "9WZDNCRFJ3PS "; source = "msstore" },
                    @{name = "Spotify"; id = "Spotify.Spotify"; source = "winget" },
                    @{name = "Steam"; id = "Valve.Steam"; source = "winget" },
                    @{name = "Steelseries"; id = "SteelSeries.GG"; source = "winget" },
                    @{name = "Telegram"; id = "Telegram.TelegramDesktop"; source = "winget" },
                    @{name = "VeraCrypt"; id = "IDRIX.VeraCrypt"; source = "winget" },
                    @{name = "VLC"; id = "VideoLAN.VLC"; source = "winget" },
                    @{name = "WhatsApp"; id = "WhatsApp.WhatsApp"; source = "winget" },
                    @{name = "WireShark"; id = "WiresharkFoundation.Wireshark"; source = "winget" }
                    @{name = "Oh My Posh"; id = "JanDeDobbeleer.OhMyPosh"; source = "winget" }
          ) # End of $apps

          #Progessbar configs
          $AppCount = $apps.count + 1
          $i = 0
}# Begin

process {
          <#
                    Process contains the logic
          #>
          foreach ($app in $apps) {
                    #Progress bar configuration
                    $i++
                    [int]$percentDone = $i * 100 / $AppCount
                    [string]$statusMessage = "" + $percentDone + "% Complete"
                    Write-Progress -Activity "Processing apps ($i / $AppCount)" -Status "$statusMessage" -PercentComplete $percentDone

                    #Verify existence of app by searching it first

                    #Separate command for winget query
                    if ($app.source -eq "winget") {
                              $SearchApp = winget search --exact --query $app.id --source $app.source
                    }

                    #Separate command for MS Store query
                    if ($app.source -eq "msstore") {
                              $SearchApp = winget search --query $app.name --source $app.source
                    }
          
                    $AppId = "*" + $app.id + "*"
                    if ($SearchApp -like $AppId) {

                              #If app exists in source call custom function for installation
                              Install-Software -id $app.id -name $app.name -source $app.source

                    }# If app is found from repositories
                    else {
                              Write-Host "Could not find " -ForegroundColor Red -NoNewline
                              write-host $app.name "("$app.id")" -NoNewline
                              write-host " package from " -ForegroundColor Red -NoNewline
                              write-host $app.source -NoNewline
                              write-host " source" -ForegroundColor Red
                    }# If app is not found
          }# Foreach apps
}# Process
end {
          <#
                    End contains cleanup
          #>
          Clear-Variable -Name apps -Force
          Clear-Variable -Name AppCount -Force
          Clear-Variable -Name i -Force
}# end

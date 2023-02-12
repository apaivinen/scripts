<#
This current profile works with Powershell versions 5.2 and 7.2.2
#>

#import modules
Import-Module -Name Terminal-Icons
import-module oh-my-posh
import-module psreadline


#configs
oh-my-posh --init --shell pwsh --config 'F:\git\powershell\profile\oh-my-posh-profile.json' | invoke-expression

Set-PSReadLineOption -PredictionSource History
set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -Colors @{"InlinePrediction"="#478390"}
Set-PSReadLineOption -HistoryNoDuplicates

cd c:\
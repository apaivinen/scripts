# Run as admin powershell

# Connected User Experiences and Telemetry

write-host "Stopping & Disabling Connected User Experiences and Telemetry (DiagTrack)"
Stop-Service -Name DiagTrack
Set-Service -Name DiagTrack -StartupType Disabled

# Print Spooler
write-host "Stopping & Disabling Print Spooler (Spooler)"
Stop-Service -Name Spooler
Set-Service -Name Spooler -StartupType Disabled

# Windows Insider Service
write-host "Stopping & Disabling Windows Insider Service (wisvc)"
Set-Service -Name wisvc -StartupType Disabled -Status Stopped

# Downloaded Maps Manager
write-host "Stopping & Disabling Downloaded Maps Managery (MapsBroker)"
Set-Service -Name MapsBroker -StartupType Disabled -Status Stopped
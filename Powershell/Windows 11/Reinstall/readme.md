# Windows 11 post re-installation scripts

I wanted to make my windows installation easier so I created couple of scripts to make automated app installations etc.

- `Disable-service.ps1` contains just a few completely useless services for me which I wanted to disable.
- `Install-Softwares.ps1` contains a script which I used to install softwares through winget. The script is a bit over the top since I wanted to train powershell skills with it. There's also `Install-Softwares-simplified.ps1` which is the same script but much more robust and easier to read for showcase purposes. 
- `Remove-DefaultSoftwares.ps1` contains just a simple command list for removing useless softwares for me. 
office
teams
chocolatey
steinberg ur22
VMware Workstation --> Vnet0 auf NAT

# VSCode Extensions
- PowerShell

# evergreen
    Set-ExecutionPolicy bypass -Force
    Install-Module -Name evergreen -Force
    Import-Module evergreen
    $EvergreenTMPFolder = "c:\tmp"

## devicetrust client

    $AppName = "devicetrust"
    $App = Get-EvergreenApp -Name $AppName | where-object{$_.Type -eq "Client"} | sort Version -Descending | Select-Object -first 1 
    $App | Save-EvergreenApp -Path $EvergreenTMPFolder
    $InstallApp = Get-ChildItem $EvergreenTMPFolder -Recurse | Where-Object{$_.Name -match "dtclient"}
    Start-Process $InstallApp.FullName -ArgumentList "/quiet /passive"

## AVD Remote Desktop

    $AppName = "MicrosoftWVDRemoteDesktop"
    $App = Get-EvergreenApp -Name $AppName | Where-Object{$_.Channel -eq "Public"} | Where-Object{$_.Architecture -eq "x64"} | sort Version -Descending | Select-Object -first 1 
    $App | Save-EvergreenApp -Path $EvergreenTMPFolder
    $InstallApp = Get-ChildItem $EvergreenTMPFolder -Recurse | Where-Object{$_.Name -eq $App.Filename}
    Start-Process $InstallApp.FullName -ArgumentList "/quiet /passive"


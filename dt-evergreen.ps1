# evergreen
    Set-ExecutionPolicy bypass -Force
    Install-Module -Name evergreen -Force
    Import-Module evergreen
    $EvergreenTMPFolder = "c:\tmp"

## devicetrust host 64bit

    $AppName = "devicetrust"
    $App = Get-EvergreenApp -Name $AppName | where-object{$_.Type -eq "Bundle"} | sort Version -Descending | Select-Object -first 1 
    $App | Save-EvergreenApp -Path $EvergreenTMPFolder
    $DownloadApp = Get-ChildItem $EvergreenTMPFolder -Recurse | Where-Object{$_.Name -match "deviceTRUST" -AND $_.Extension -eq ".zip"}

    $i = 0
    $count = 0
    $DestinationPath = ""
    $Path= $DownloadApp.FullName.Split("\")

    do{    
        $i++    
    } while($Path[$i] -ne $null)


    for($count;$count -le $i-2;$count++){
        [string]$DestinationPath = $DestinationPath + $Path[$count] + "\"
    }

    Expand-Archive $DownloadApp.FullName -DestinationPath $DestinationPath -Force
    $InstallApp = Get-ChildItem $DestinationPath | Where-Object{$_.Name -match "dthost-x64"}
    Start-Process $InstallApp.FullName -ArgumentList "/passive"

## devicetrust console 64bit

    $AppName = "devicetrust"
    $App = Get-EvergreenApp -Name $AppName | where-object{$_.Type -eq "Bundle"} | sort Version -Descending | Select-Object -first 1 
    $App | Save-EvergreenApp -Path $EvergreenTMPFolder
    $DownloadApp = Get-ChildItem $EvergreenTMPFolder -Recurse | Where-Object{$_.Name -match "deviceTRUST" -AND $_.Extension -eq ".zip"}

    $i = 0
    $count = 0
    $DestinationPath = ""
    $Path= $DownloadApp.FullName.Split("\")

    do{    
        $i++    
    } while($Path[$i] -ne $null)


    for($count;$count -le $i-2;$count++){
        [string]$DestinationPath = $DestinationPath + $Path[$count] + "\"
    }

    Expand-Archive $DownloadApp.FullName -DestinationPath $DestinationPath -Force
    $InstallApp = Get-ChildItem $DestinationPath | Where-Object{$_.Name -match "dtconsole-x64"}
    Start-Process $InstallApp.FullName -ArgumentList "/passive"

Remove-Item $EvergreenTMPFolder -Recurse -Force
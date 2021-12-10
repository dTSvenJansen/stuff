cd $PSScriptRoot

$services = "wuauserv","trustedinstaller"
$services | ForEach-Object{
    Get-Service $_ | Set-Service -StartupType manual
    Start-Service $_
}

$paths = "c:\Corporate App","c:\´Development App"
$paths | ForEach-Object{
    if(Test-Path $_){Remove-Item $_ -recurse -force}
}

# Copy Apps
$archives = Get-ChildItem .\AppLockerEnvInstall -Filter *.zip
$archives | ForEach-Object{
    Expand-Archive $_.FullName -DestinationPath 'c:\' -Force  
}

# set ACL
$setaclpath = ".\SetACL.exe"
$apppathSWINSTALL = "c:\Corporate App"
$apppathDA = "c:\Development App"

$SIDSCCM = (Get-LocalUser "sw-install").sid.value
$SIDDA = (Get-LocalUser "admin").sid.value

foreach($apppathSWINSTALLER in $apppathsSWINSTALLER){
    & $setaclpath -on $apppathSWINSTALLER -ot file -actn setowner -ownr "n:$SIDSCCM" | Out-Null
    Get-ChildItem $apppathSWINSTALLER | ForEach-Object{& $setaclpath -on $_.FullName -ot file -actn setowner -ownr "n:$SIDSCCM"}  | Out-Null
}

foreach($apppathDA in $apppathsDA){
    & $setaclpath -on $apppathDA -ot file -actn setowner -ownr "n:$SIDDA"  | Out-Null
    Get-ChildItem $apppathDA | ForEach-Object{& $setaclpath -on $_.FullName -ot file -actn setowner -ownr "n:$SIDDA"}  | Out-Null
}
cd $PSScriptRoot

# Locate SetACL exe
$setaclpath = ".\SetACL.exe"

# Configure the SW-INSTALL owned app folder
$apppathSWINSTALL = ".\Corporate App"

# Configure the ADMIN owned app folder
$apppathADMIN = ".\Development App"

# Get the SIDs for the local users ADMIN and SW-INSTALL
$SIDSWINSTALL = (Get-LocalUser "sw-install").sid.value
$SIDADMIN = (Get-LocalUser "admin").sid.value

# Set file rights for the SW-INSTALL owned app folder
& $setaclpath -on $apppathSWINSTALL -ot file -actn setowner -ownr "n:$SIDSWINSTALL" | Out-Null
Get-ChildItem $apppathSWINSTALL | ForEach-Object{& $setaclpath -on $_.FullName -ot file -actn setowner -ownr "n:$SIDSWINSTALL"}  | Out-Null

# Set file rights for the SW-INSTALL owned app folder
& $setaclpath -on $apppathADMIN -ot file -actn setowner -ownr "n:$SIDADMIN"  | Out-Null
Get-ChildItem $apppathADMIN | ForEach-Object{& $setaclpath -on $_.FullName -ot file -actn setowner -ownr "n:$SIDADMIN"}  | Out-Null
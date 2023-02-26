@echo off

REM Download ngrok
powershell -Command "Invoke-WebRequest https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-windows-amd64.zip -OutFile ngrok.zip"

REM Extract ngrok
powershell -Command "Expand-Archive ngrok.zip"

REM Authenticate ngrok
set NGROK_AUTH_TOKEN=2MGuYMvTqVrCmNlISqb5GJVeUck_6rp1ke5YLcKUiaHkCFMx8
.\ngrok\ngrok.exe authtoken %NGROK_AUTH_TOKEN%

REM Enable remote desktop access
REG ADD "HKLM\System\CurrentControlSet\Control\Terminal Server" /v "fDenyTSConnections" /t REG_DWORD /d 0 /f
netsh advfirewall firewall set rule group="Remote Desktop" new enable=Yes
REG ADD "HKLM\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v "UserAuthentication" /t REG_DWORD /d 1 /f

REM Create user account
net user binni P@ssw0rd /add

REM Create tunnel
.\ngrok\ngrok.exe tcp 3389

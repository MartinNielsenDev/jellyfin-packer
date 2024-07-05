@echo off
SET TIZEN_TOOLS_PATH=C:\tizen-studio\tools
SET TIZEN_BIN=%TIZEN_TOOLS_PATH%\ide\bin\tizen
SET DEVICE_MANAGER_BIN=%TIZEN_TOOLS_PATH%\device-manager\bin\device-manager.exe
SET TV_NAME=QE65Q60TAUXXC

echo You are installing Jellyfin.wgt to %TV_NAME% make sure 
echo You must open tizen device-manager.exe and connect to your TV while the TV is in developer mode (https://developer.samsung.com/tv/develop/getting-started/using-sdk/tv-device)
echo Attempting to open device manager

call "%DEVICE_MANAGER_BIN%"

echo In the Tizen Studio Device Manager, on the far right three icons can be seen, press the middle one to connect to your TV
pause

echo Installing Jellyfin.wgt to %TV_NAME%
call "%TIZEN_BIN%" install -n Jellyfin.wgt -t %TV_NAME%
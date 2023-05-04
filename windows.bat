@echo off
SET JELLYFIN_WEB_GIT=https://github.com/jellyfin/jellyfin-web.git
SET JELLYFIN_TIZEN_GIT=https://github.com/jellyfin/jellyfin-tizen.git

SET INSTALL_TO_TV=False
SET TIZEN_BIN=C:\tizen-studio\tools\ide\bin\tizen
SET TV_NAME=QE65Q60XXXXXX


echo Preparing jellyfin-web.
IF NOT EXIST "jellyfin-web" git clone %JELLYFIN_WEB_GIT%
cd jellyfin-web
git pull
SET SKIP_PREPARE=1
echo Installing packages...
call npm ci --no-audit
echo Building...
call npm run build:production
echo jellyfin-web done!

cd ..

echo Preparing jellyfin-tizen.
IF NOT EXIST "jellyfin-tizen" git clone %JELLYFIN_TIZEN_GIT%
cd jellyfin-tizen
git pull
SET JELLYFIN_WEB_DIR=../jellyfin-web/dist
echo Installing packages...
call npm ci --no-audit
echo jellyfin-tizen done!

echo Building (tizen build-web)...
call %TIZEN_BIN% build-web -e ".*" -e gulpfile.js -e README.md -e "node_modules/*" -e "package*.json" -e "yarn.lock"
echo Packaging build result...
call %TIZEN_BIN% package -t wgt -o . -- .buildResult

echo Cleaning up...
SET INSTALL_TO_TV=
SET TIZEN_BIN=
SET TV_NAME=
SET SKIP_PREPARE=
SET JELLYFIN_WEB_DIR=

move Jellyfin.wgt ../Jellyfin.wgt
cd ..

IF %INSTALL_TO_TV% == True (
    echo Installing to the TV...
    call %TIZEN_BIN% install -n Jellyfin.wgt -t %TV_NAME%
)

echo Done!
pause

@setlocal enabledelayedexpansion
cd /d "%~dp0"
set "ROOT=!CD!"
set "BUILD=!ROOT!\build"
set "STAGING=!BUILD!\archive_staging"
set "ARTIFACTS=!BUILD!\artifacts"

for /f "tokens=*" %%a in ('git describe --tags') do (set TAG=%%a)

md "!STAGING!"
cd "!STAGING!"

xcopy /s /e "!ARTIFACTS!" .

7z a !ROOT!\libwebp_%TAG%.7z *.* *

cd !ROOT!
rmdir /S /Q "!STAGING!"

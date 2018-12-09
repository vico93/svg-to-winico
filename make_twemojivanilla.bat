@echo off
SETLOCAL EnableDelayedExpansion
cd /D %~dp0

REM Set PATH only if you arent added inkscape already
SET PATH=%PATH%;C:\Program Files\Inkscape\

REM Folder where emojis are stored (git repository)
REM e.g.:<path to your Twemoji folder>\2\svg
set /p emoji_dir=Enter emoji dir path: 

REM Temp dir
set temp_dir=%~dp0\tmp
REM The dir where the finished icons are stored
set final_dir=%~dp0\bin\vanilla

mkdir %final_dir%

for /f %%f in ('dir /b /O:N %emoji_dir%') do (
	echo %%f
	REM Pasta temporária
	mkdir %temp_dir%\%%~nf
	cd /D %temp_dir%\%%~nf
	
	REM Processa svg do emoji
	inkscape %emoji_dir%\%%f --export-png="emoji_256.png" -w256 -h256 --without-gui
	inkscape %emoji_dir%\%%f --export-png="emoji_64.png" -w64 -h64 --without-gui
	inkscape %emoji_dir%\%%f --export-png="emoji_48.png" -w48 -h48 --without-gui
	inkscape %emoji_dir%\%%f --export-png="emoji_40.png" -w40 -h40 --without-gui
	inkscape %emoji_dir%\%%f --export-png="emoji_32.png" -w32 -h32 --without-gui
	inkscape %emoji_dir%\%%f --export-png="emoji_24.png" -w24 -h24 --without-gui
	inkscape %emoji_dir%\%%f --export-png="emoji_20.png" -w20 -h20 --without-gui
	inkscape %emoji_dir%\%%f --export-png="emoji_16.png" -w16 -h16 --without-gui
	
	REM Make the .ico	
	magick emoji_256.png emoji_64.png emoji_48.png emoji_40.png emoji_32.png emoji_24.png emoji_20.png emoji_16.png %final_dir%\%%~nf.ico

	REM Clear screen
	cls
)

cd /D %~dp0\bin
rmdir /s /q %temp_dir%

pause


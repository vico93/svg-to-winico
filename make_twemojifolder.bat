@echo off
SETLOCAL EnableDelayedExpansion
cd /D %~dp0

REM Folder where emojis are stored (git repository)
REM e.g.:<path to your Twemoji folder>\2\svg
set /p emoji_dir=Enter emoji dir path: 

REM Folder where you extracted the standard Windows file icon
set baseicons_dir=%~dp0\src\folder
REM Temp dir
set temp_dir=%~dp0\tmp
REM The dir where the finished icons are stored
set final_dir=%~dp0\bin\folder 

mkdir %final_dir%

for /f %%f in ('dir /b /O:N %emoji_dir%') do (
	echo %%f
	REM Pasta temporária
	mkdir %temp_dir%\%%~nf
	cd /D %temp_dir%\%%~nf
	
	REM Processa svg do emoji
	
	rsvg-convert "%emoji_dir%\%%f" -w 120 -h 120 -o emoji_256.png	
	rsvg-convert "%emoji_dir%\%%f" -w 32 -h 32 -o emoji_64.png	
	rsvg-convert "%emoji_dir%\%%f" -w 24 -h 24 -o emoji_48.png
	rsvg-convert "%emoji_dir%\%%f" -w 20 -h 20 -o emoji_40.png
	rsvg-convert "%emoji_dir%\%%f" -w 16 -h 16 -o emoji_32.png
	rsvg-convert "%emoji_dir%\%%f" -w 12 -h 12 -o emoji_24.png
	rsvg-convert "%emoji_dir%\%%f" -w 10 -h 10 -o emoji_20.png
	rsvg-convert "%emoji_dir%\%%f" -w 8 -h 8 -o emoji_16.png
	
	REM Composite the file icon
	magick %baseicons_dir%\256.png emoji_256.png -gravity North -geometry +0+84 -composite "compositeicon_256.png"
	magick %baseicons_dir%\64.png emoji_64.png -gravity North -geometry +0+17 -composite "compositeicon_64.png"
	magick %baseicons_dir%\48.png emoji_48.png -gravity North -geometry +0+12 -composite "compositeicon_48.png"
	magick %baseicons_dir%\40.png emoji_40.png -gravity North -geometry +0+10 -composite "compositeicon_40.png"
	magick %baseicons_dir%\32.png emoji_32.png -gravity North -geometry +0+9 -composite "compositeicon_32.png"
	magick %baseicons_dir%\24.png emoji_24.png -gravity North -geometry +0+6 -composite "compositeicon_24.png"
	magick %baseicons_dir%\20.png emoji_20.png -gravity North -geometry +0+5 -composite "compositeicon_20.png"
	magick %baseicons_dir%\16.png emoji_16.png -gravity North -geometry +0+4 -composite "compositeicon_16.png"
	
	REM Make the .ico	
	magick compositeicon_256.png compositeicon_64.png compositeicon_48.png compositeicon_40.png compositeicon_32.png compositeicon_24.png compositeicon_20.png compositeicon_16.png %final_dir%\%%~nf.ico
	pause

	REM Clear screen
	cls
)

cd /D %~dp0\bin
rem rmdir /s /q %temp_dir%

pause


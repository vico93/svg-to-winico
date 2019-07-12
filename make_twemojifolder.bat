@echo off
SETLOCAL EnableDelayedExpansion
cd /d %~dp0

REM Folder where emojis are stored (git repository)
REM e.g.:<path to your Twemoji folder>\2\svg
set /p twemoji_dir=Enter emoji dir path: 

REM Folder where you extracted the standard Windows folder icon
set winicons_dir=%~dp0\src\folder
REM Temp dir
set temp_dir=%~dp0\tmp_folder
REM The dir where the finished icons are stored
set final_dir=%~dp0\dist\folder

mkdir %final_dir%

for /f %%f in ('dir /b /O:N %twemoji_dir%') do (
	echo %%f
	REM Pasta temporária
	mkdir %temp_dir%\%%~nf
	cd /d %temp_dir%\%%~nf
	
	REM Processa svg do emoji
	svg2png %twemoji_dir%\%%f --output=".\emoji_256.png" --width=120 --height=120
	svg2png %twemoji_dir%\%%f --output=".\emoji_64.png" --width=32 --height=32
	svg2png %twemoji_dir%\%%f --output=".\emoji_48.png" --width=24 --height=24
	svg2png %twemoji_dir%\%%f --output=".\emoji_40.png" --width=20 --height=20
	svg2png %twemoji_dir%\%%f --output=".\emoji_32.png" --width=16 --height=16
	svg2png %twemoji_dir%\%%f --output=".\emoji_24.png" --width=12 --height=12
	svg2png %twemoji_dir%\%%f --output=".\emoji_20.png" --width=10 --height=10
	svg2png %twemoji_dir%\%%f --output=".\emoji_16.png" --width=16 --height=16

	REM Clear screen
	cls
)

cd /D %~dp0\dist
REM rmdir /s /q %temp_dir%

pause


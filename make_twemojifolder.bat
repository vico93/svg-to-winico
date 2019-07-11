REM @echo off
SETLOCAL EnableDelayedExpansion
cd /D %~dp0

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
	cd /D %temp_dir%\%%~nf
	
	REM Processa svg do emoji
	svg2png %twemoji_dir%\%%f --output="%temp_dir%\%%~nf\emoji_256.png" --width=120 --height=120
	svg2png %twemoji_dir%\%%f --output="%temp_dir%\%%~nf\emoji_64.png" --width=32 --height=32
	svg2png %twemoji_dir%\%%f --output="%temp_dir%\%%~nf\emoji_48.png" --width=24 --height=24
	svg2png %twemoji_dir%\%%f --output="%temp_dir%\%%~nf\emoji_40.png" --width=20 --height=20
	svg2png %twemoji_dir%\%%f --output="%temp_dir%\%%~nf\emoji_32.png" --width=16 --height=16
	svg2png %twemoji_dir%\%%f --output="%temp_dir%\%%~nf\emoji_24.png" --width=12 --height=12
	svg2png %twemoji_dir%\%%f --output="%temp_dir%\%%~nf\emoji_20.png" --width=10 --height=10
	svg2png %twemoji_dir%\%%f --output="%temp_dir%\%%~nf\emoji_16.png" --width=16 --height=16
	
	REM Composite the folder icon
	sharp composite %winicons_dir%\256.png --image emoji_256.png --gravity southeast --offset +16+29 -o ".\%%~nf"
	sharp composite %winicons_dir%\64.png --image emoji_64.png --gravity southeast --offset +4+6 -o ".\%%~nf"
	sharp composite %winicons_dir%\48.png --image emoji_64.png --gravity southeast --offset +3+6 -o ".\%%~nf"
	sharp composite %winicons_dir%\40.png --image emoji_64.png --gravity southeast --offset +2+5 -o ".\%%~nf"
	sharp composite %winicons_dir%\32.png --image emoji_64.png --gravity southeast --offset +3+3 -o ".\%%~nf"
	sharp composite %winicons_dir%\24.png --image emoji_64.png --gravity southeast --offset +1+3 -o ".\%%~nf"
	sharp composite %winicons_dir%\20.png --image emoji_20.png --gravity southeast --offset +2+2 -o ".\%%~nf"
	
	REM magick %winicons_dir%\256.png emoji_256.png -gravity SouthEast -geometry +16+29 -composite "composite\icon_256.png"
	REM magick %winicons_dir%\64.png emoji_64.png -gravity SouthEast -geometry +4+6 -composite "composite\icon_64.png"
	REM magick %winicons_dir%\48.png emoji_48.png -gravity SouthEast -geometry +3+6 -composite "composite\icon_48.png"
	REM magick %winicons_dir%\40.png emoji_40.png -gravity SouthEast -geometry +2+5 -composite "composite\icon_40.png"
	REM magick %winicons_dir%\32.png emoji_32.png -gravity SouthEast -geometry +3+3 -composite "composite\icon_32.png"
	REM magick %winicons_dir%\24.png emoji_24.png -gravity SouthEast -geometry +1+3 -composite "composite\icon_24.png"
	REM magick %winicons_dir%\20.png emoji_20.png -gravity SouthEast -geometry +2+2 -composite "composite\icon_20.png"
	
	xcopy /Y emoji_16.png compositeicon_16.png*
	
	REM Make the .ico
	icon-gen -i .\%%~nf -o %final_dir%

	REM Clear screen
	cls
)

cd /D %~dp0\bin
rmdir /s /q %temp_dir%

pause


@echo off
SETLOCAL EnableDelayedExpansion
cd /D %~dp0

REM Set PATH only if you arent added inkscape already
SET PATH=%PATH%;C:\Program Files\Inkscape\

REM Folder whëre emojis are stored (git repository)
set emoji_dir=D:\Users\vico\Git\Github\twitter\twemoji\2\svg
REM Folder where you extracted the standard Windows library icon
set folderico_dir=%~dp0\win10_library
REM Temp dir
set temp_dir=%~dp0\temp
REM The dir where the finished icons are stored
set final_dir=%~dp0\library-final

mkdir "%final_dir%"
cd /D %emoji_dir%

for /f %%f in ('dir /b %emoji_dir%') do (
	echo %%f
	REM Pasta temporária
	mkdir tmp_%%~nf
	cd tmp_%%~nf
	
	REM Processa svg do emoji
	inkscape ..\%%f --export-png="emoji_256.png" -w120 -h120 --without-gui
	inkscape ..\%%f --export-png="emoji_64.png" -w32 -h32 --without-gui
	inkscape ..\%%f --export-png="emoji_48.png" -w24 -h24 --without-gui
	inkscape ..\%%f --export-png="emoji_32.png" -w16 -h16 --without-gui
	inkscape ..\%%f --export-png="emoji_24.png" -w12 -h12 --without-gui
	inkscape ..\%%f --export-png="emoji_20.png" -w10 -h10 --without-gui
	inkscape ..\%%f --export-png="emoji_16.png" -w14 -h14 --without-gui
	
	REM Monta imagem da pasta com emoji
	mkdir %temp_dir%\%%~nf

	magick %folderico_dir%\256.png emoji_256.png -gravity center -geometry +0+8 -composite "%temp_dir%\%%~nf\256.png"
	magick %folderico_dir%\64.png emoji_64.png -gravity center -geometry +0+0 -composite "%temp_dir%\%%~nf\64.png"
	magick %folderico_dir%\48.png emoji_48.png -gravity center -geometry +0+0 -composite "%temp_dir%\%%~nf\48.png"
	magick %folderico_dir%\32.png emoji_32.png -gravity center -geometry +0+0 -composite "%temp_dir%\%%~nf\32.png"
	magick %folderico_dir%\24.png emoji_24.png -gravity center -geometry +0+0 -composite "%temp_dir%\%%~nf\24.png"
	magick %folderico_dir%\20.png emoji_20.png -gravity center -geometry +0+0 -composite "%temp_dir%\%%~nf\20.png"
	magick %folderico_dir%\16.png emoji_16.png -gravity center -geometry +0-1 -composite "%temp_dir%\%%~nf\16.png"
	
	REM Cria o ícone propriamente dito
	
	magick %temp_dir%\%%~nf\256.png %temp_dir%\%%~nf\64.png %temp_dir%\%%~nf\48.png %temp_dir%\%%~nf\32.png %temp_dir%\%%~nf\24.png %temp_dir%\%%~nf\20.png %temp_dir%\%%~nf\16.png %final_dir%\%%~nf.ico
	
	REM apaga pasta temporária
	rmdir /s /q %temp_dir%\%%~nf\
	
	REM Sai e apaga pasta temporária
	cd ..
	rmdir /s /q tmp_%%~nf
	cls
)

pause


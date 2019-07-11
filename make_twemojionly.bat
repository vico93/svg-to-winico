@echo off
SETLOCAL EnableDelayedExpansion
cd /D %~dp0
REM Folder where emojis are stored (git repository)
REM e.g.:<path to your Twemoji folder>\2\svg
set /p emoji_dir=Enter emoji dir path: 

REM The dir where the finished icons are stored
set final_dir=%~dp0\dist\vanilla

mkdir %final_dir%

for /f %%f in ('dir /b /O:N %emoji_dir%') do (
	echo %%f
	
	REM Processa svg do emoji
	icon-gen -i %emoji_dir%\%%f -o %final_dir% --ico name=%%~nf sizes=16,20,24,32,40,48,64,96,256

	REM Clear screen
	cls
)

cd /D %~dp0\dist

pause


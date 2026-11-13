@echo off
rem  FarmLand - byg installationsprogrammet FarmLand-Setup-x.y.z.exe (dobbeltklik paa denne fil)
rem  Kraever: farmland.py, farmland.iss og README.md i samme mappe som denne fil.
chcp 65001 >nul
cd /d "%~dp0"
title Bygger FarmLand-installation

set PY=
where py >nul 2>nul
if not errorlevel 1 set PY=py -3
if defined PY goto havepy
where python >nul 2>nul
if not errorlevel 1 set PY=python
:havepy
if not defined PY goto nopython
if not exist farmland.iss goto noiss

echo [1/5] Installerer pygame og PyInstaller ...
%PY% -m pip install --upgrade --quiet pip
rem  pygame: brug det, der er installeret. Ellers hentes en faerdig pakke - findes der ingen til denne
rem  Python-version (fx Python 3.14), bruges pygame-ce, som er samme bibliotek i en nyere udgave.
%PY% -c "import pygame" >nul 2>nul
if not errorlevel 1 goto havepg
%PY% -m pip install --quiet --only-binary=:all: pygame >nul 2>nul
if not errorlevel 1 goto havepg
echo       pygame findes ikke til denne Python-version - bruger pygame-ce i stedet ...
%PY% -m pip install --quiet --only-binary=:all: pygame-ce
if errorlevel 1 goto fejl
:havepg
%PY% -m pip install --upgrade --quiet pyinstaller
if errorlevel 1 goto fejl

set VER=
for /f "usebackq delims=" %%v in (`%PY% farmland.py --version`) do set VER=%%v
if not defined VER goto fejl
echo       FarmLand version %VER%

echo [2/5] Laver ikonet ...
%PY% farmland.py --make-icon farmland.ico
if errorlevel 1 goto fejl

echo [3/5] Bygger spillet (det tager et par minutter) ...
if exist installer_build rmdir /s /q installer_build
%PY% -m PyInstaller --noconfirm --clean --onedir --windowed --name FarmLand --icon "%~dp0farmland.ico" --distpath installer_build\dist --workpath installer_build\work --specpath installer_build farmland.py
if errorlevel 1 goto fejl
if not exist installer_build\dist\FarmLand\FarmLand.exe goto fejl

echo [4/5] Finder Inno Setup ...
call :findiscc
if defined ISCC goto haveiscc
echo       Inno Setup er ikke installeret - proever at hente det med winget ...
where winget >nul 2>nul
if errorlevel 1 goto noinno
winget install --id JRSoftware.InnoSetup -e --silent --accept-package-agreements --accept-source-agreements
call :findiscc
if not defined ISCC goto noinno
:haveiscc

echo [5/5] Pakker installationsprogrammet ...
if not exist dist mkdir dist
"%ISCC%" /Q /DAppVersion=%VER% farmland.iss
if errorlevel 1 goto fejl
rmdir /s /q installer_build >nul 2>nul

echo.
echo Faerdig!  Installationsprogrammet ligger her:
echo     %~dp0dist\FarmLand-Setup-%VER%.exe
echo Send den fil til dine venner. De dobbeltklikker paa den og foelger guiden -
echo de behoever hverken Python eller administratorrettigheder.
echo.
explorer "%~dp0dist"
pause
exit /b 0

:findiscc
set ISCC=
for /f "delims=" %%i in ('where ISCC 2^>nul') do if not defined ISCC set "ISCC=%%i"
if defined ISCC exit /b 0
if exist "%ProgramFiles(x86)%\Inno Setup 6\ISCC.exe" set "ISCC=%ProgramFiles(x86)%\Inno Setup 6\ISCC.exe"
if defined ISCC exit /b 0
if exist "%ProgramFiles%\Inno Setup 6\ISCC.exe" set "ISCC=%ProgramFiles%\Inno Setup 6\ISCC.exe"
if defined ISCC exit /b 0
if exist "%LOCALAPPDATA%\Programs\Inno Setup 6\ISCC.exe" set "ISCC=%LOCALAPPDATA%\Programs\Inno Setup 6\ISCC.exe"
exit /b 0

:nopython
echo Python blev ikke fundet. Installer Python 3 fra https://www.python.org/downloads/
echo og saet flueben i "Add python.exe to PATH" under installationen.
pause
exit /b 1

:noiss
echo farmland.iss mangler - den skal ligge i samme mappe som denne fil.
pause
exit /b 1

:noinno
echo.
echo Inno Setup blev ikke fundet. Hent og installer det gratis fra
echo     https://jrsoftware.org/isdl.php
echo og koer saa denne fil igen. Spillet er allerede bygget i installer_build\dist\FarmLand.
start "" https://jrsoftware.org/isdl.php
pause
exit /b 1

:fejl
echo.
echo Noget gik galt under bygningen - se teksten ovenfor.
pause
exit /b 1

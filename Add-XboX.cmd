

@echo off
for /f "tokens=6 delims=[]. " %%G in ('ver') do if %%G lss 16299 goto :version
%windir%\system32\reg.exe query "HKU\S-1-5-19" 1>nul 2>nul || goto :uac
setlocal enableextensions
cd /d "%~dp0"

if not exist "*Microsoft.XboxApp*.appx" goto :nofiles
if not exist "*Microsoft.XboxApp*.cer" goto :nofiles

set "PScommand=PowerShell -NoLogo -NoProfile -NonInteractive -InputFormat None -ExecutionPolicy Bypass"
set "Add=Add-AppxPackage"

:Menu
echo.
echo ------------------------------------------------------------
echo 1. Install Depedency (Required In Order XboX to Run)
echo ============================================================
echo ------------------------------------------------------------
echo 2. Install XboX Insider Hub (Do this after Depedency already Installed)
echo ============================================================
echo.
set /p op=
if "%op%"=="1" goto :Depedency
if "%op%"=="2" goto :APPX

:APPX
echo.
echo ============================================================
echo Adding XboX Insider Hub Certificate
echo ============================================================
echo.
%PScommand% Import-Certificate "Microsoft.XboxApp_48.69.18001.0_x64__8wekyb3d8bbwe.cer" -CertStoreLocation Cert:\LocalMachine\Root
echo.
echo ============================================================
echo Installing XboX Insider Hub
echo ============================================================
echo.
%PScommand% %Add% "*XboxApp*.appx"
echo.
echo ============================================================
echo XboX Insider Hub Installed!
echo ============================================================
echo.
timeout 3
goto :final

:Depedency
echo.
echo ------------------------------------------------------------
echo 1. Depedency (Arm)
echo ============================================================
echo ------------------------------------------------------------
echo 2. Depedency x64 (64 Bit)
echo ============================================================
echo ------------------------------------------------------------
echo 3. Depedency x32 (32 Bit)
echo ============================================================
echo.
set /p op=
if "%op%"=="1" goto :Arm
if "%op%"=="2" goto :x64
if "%op%"=="3" goto :x86

:Arm
if not exist "Arm\*Framework*2.1*arm*.appx" goto :nofiles
if not exist "Arm\*Runtime*2.1*arm*.appx" goto :nofiles
if not exist "Arm\*Microsoft.VCLibs*140*arm*.appx" goto :nofiles
if not exist "Arm\*Framework*1.7*arm*.appx" goto :nofiles
if not exist "Arm\*Runtime*1.7*arm*.appx" goto :nofiles
if not exist "Arm\*UWPDesktop*arm*.appx" goto :nofiles
echo.
echo ============================================================
echo Installing Arm Depedency....
echo ============================================================
echo.
%PScommand% %Add% "Arm\*arm*.appx"
echo.
echo ============================================================
echo Depedency (Arm) Installed!
echo ============================================================
echo.
timeout 3
goto :Menu

:x64
if not exist "x64\*Framework*2.1*x64*.appx" goto :nofiles
if not exist "x64\*Runtime*2.1*x64*.appx" goto :nofiles
if not exist "x64\*Microsoft.VCLibs*140*x64*.appx" goto :nofiles
if not exist "x64\*Framework*1.7*x64*.appx" goto :nofiles
if not exist "x64\*Runtime*1.7*x64*.appx" goto :nofiles
if not exist "x64\*UWPDesktop*x64*.appx" goto :nofiles
echo.
echo ============================================================
echo Installing x64 Depedency....
echo ============================================================
echo.
%PScommand% %Add% "x64\*x64*.appx"
echo.
echo ============================================================
echo Depedency x64 (64 Bit) Installed!
echo ============================================================
echo.
timeout 3
goto :Menu

:x86
if not exist "x86\*Framework*2.1*x86*.appx" goto :nofiles
if not exist "x86\*Runtime*2.1*x86*.appx" goto :nofiles
if not exist "x86\*Microsoft.VCLibs*140*x86*.appx" goto :nofiles
if not exist "x86\*Framework*1.7*x86*.appx" goto :nofiles
if not exist "x86\*Runtime*1.7*x86*.appx" goto :nofiles
if not exist "x86\*UWPDesktop*x86*.appx" goto :nofiles
echo.
echo ============================================================
echo Installing x86 Depedency....
echo ============================================================
echo.
%PScommand% %Add% "x86\*x86*.appx"
echo.
echo ============================================================
echo Depedency x86 (32 Bit) Installed!
echo ============================================================
echo.
timeout 3
goto :Menu

:uac
echo.
echo ------------------------------------------------------------
echo Run The Script In Admin Mode
echo ============================================================
echo.
echo.
echo Press any key to Exit
pause >nul
exit

:version
echo.
echo ------------------------------------------------------------
echo Only Support For Windows 18362.0+
echo ============================================================
echo.
echo.
echo Press any key to Exit
pause >nul
exit

:nofiles
echo.
echo ------------------------------------------------------------
echo Somefiles were missing, cannot execute...
echo ============================================================
echo.
echo.
echo Press any key to Exit
pause >nul
exit

:final
echo.
echo ------------------------------------------------------------
echo Finished
echo ============================================================
echo.
echo Press any Key to Exit.
pause >nul
exit

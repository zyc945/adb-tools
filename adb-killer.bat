::--------------------------------------------------------
::zyc write to solve the adb port ocuppied by 3rd apps
::2014-3-10
::--------------------------------------------------------
@echo off
setlocal
title adb killer

:findAdbProcess
set filterPorts=%tmp%\adbPortPids
set adbPids=%tmp%\adbPids
netstat -ano | findstr 127.0.0.1:5037 > %filterPorts%
rem type %filterPorts%
rem echo "filter result:"
FOR /F "tokens=5* delims= " %%i in (%filterPorts%) do if not %%i==0 @echo %%i >> %adbPids%
echo ================pids==================
type %adbPids%
echo ================pid names=============
FOR /F %%i in (%adbPids%) do tasklist | findstr %%i
del %adbPids%
goto killPids

:killPids
echo "input the pid you want to kill:"
set /p var=
echo "are you sure? (Y/N)":
set /p a=
if %a%=="n" goto :EOF
taskkill /f /pid %var%
echo "coutinue?(Y/N)"
set /p c=
if %c%=="n" goto :EOF
goto findAdbProcess


rem :findTaskName
rem setlocal
rem echo %1
rem tasklist | findstr %1
rem endlocal&goto :EOF
@echo off
setlocal
set installFile=%1
echo %installFile%
adb start-server
rem adb connect 192.168.56.101:5555
adb connect 192.168.56.102:5555
set count=1
set suffix=%~x1
if "%suffix%"==".tsk" goto install_skin
if "%suffix%"==".apk" goto install_apk
goto unsupported_install

:install_skin
echo "将安装皮肤文件： "
adb remount
adb push %installFile% /sdcard/ttpod/skin/
goto install_success

:install_apk
if %count% equ 2 goto install_failed
echo "将安装应用文件： "
rem =========================
rem adb install -r %installApk%
rem =========================
adb install -r %installFile% | findstr /Q "Failure"
rem =========================
rem install failed
if %ERRORLEVEL% equ 0 goto reinstall_apk
rem =========================
rem install succeed
goto install_success

:reinstall_apk
echo "应用安装失败，正在自动重新安装........"
adb uninstall "com.sds.android.ttpod" 
set count=2
goto install_apk

:install_success
echo "安装成功！！！！"
goto start_ttpod
rem goto end

:install_failed
echo "无法安装，去找开发人员吧！"
goto end

:unsupported_install
echo "该文件不支持，去找开发人员吧！"
goto end

:start_ttpod
adb shell am start -n "com.sds.android.ttpod/com.sds.android.ttpod.EntryActivity" -a android.intent.action.MAIN -c android.intent.category.LAUNCHER

:end
pause
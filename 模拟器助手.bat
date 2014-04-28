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
echo "����װƤ���ļ��� "
adb remount
adb push %installFile% /sdcard/ttpod/skin/
goto install_success

:install_apk
if %count% equ 2 goto install_failed
echo "����װӦ���ļ��� "
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
echo "Ӧ�ð�װʧ�ܣ������Զ����°�װ........"
adb uninstall "com.sds.android.ttpod" 
set count=2
goto install_apk

:install_success
echo "��װ�ɹ���������"
goto start_ttpod
rem goto end

:install_failed
echo "�޷���װ��ȥ�ҿ�����Ա�ɣ�"
goto end

:unsupported_install
echo "���ļ���֧�֣�ȥ�ҿ�����Ա�ɣ�"
goto end

:start_ttpod
adb shell am start -n "com.sds.android.ttpod/com.sds.android.ttpod.EntryActivity" -a android.intent.action.MAIN -c android.intent.category.LAUNCHER

:end
pause
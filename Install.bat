@echo off

set start_apprun="%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\ATCR.bat"
set set_appdata="%appdata%\Gjun\RunStartup.bat"
set defInst="%cd%"

if NOT EXIST RunStartup.bat goto main_menu
echo 設定檔已存在，正在執行安裝..
echo ......
echo ............
echo.
mkdir "%appdata%\Gjun\"
copy RunStartup.bat "%appdata%\Gjun\"
echo @echo off > %start_apprun%
echo cmd /c %set_appdata% >> %start_apprun%
echo exit >> %start_apprun%
echo.
echo 安裝完成，若要重新設定，請先將 RunStartup.bat 刪除
echo.
pause
exit

:main_menu
mkdir "%appdata%\Gjun\"
cls
cd /d "%appdata%\Gjun\"
echo.
ECHO ============================
ECHO *   電腦教室輔助管理程式   *
ECHO ============================
ECHO *                          *
ECHO *    1. Install            *   
ECHO *                          *
ECHO *    2. Uninstall          *
ECHO *                          *
ECHO *    3. exit               *
ECHO *                          *
ECHO ============================
ECHO * 本程式僅適用於 Gjun v1.1 *
ECHO * http://bit.ly/GjunALs    *
ECHO ============================
echo.
set /p select_start="請輸入1-3數字> "
if %select_start%==1 goto start_install
if %select_start%==2 goto start_uninstall
if %select_start%==3 goto exit_bye

:start_uninstall
cmd /c %defInst%\Uninstall.bat
exit

:start_install
cls
del "%appdata%\Gjun\*.ini" /q /f
set itemServ=er
set itemPath=er
set itemUser=er
set itemPass=er

echo.
echo 請輸入以下資料
echo 範例1：資料夾放在 \\pc1\student\gjun\classroom
echo 　　　沒有帳號，沒有密碼
echo 主機名稱=pc1
echo 資料夾路徑=\\pc1\student\gjun\classroom
echo 帳號及密碼留空白按enter
echo.
echo.
echo 範例2：資料夾放在 \\192.168.1.10\gjun\classroom
echo 　　　帳號：teacher 密碼：1234
echo 主機名稱=192.168.1.10
echo 資料夾路徑=\\192.168.1.10\gjun\classroom
echo 帳號：teacher
echo 密碼：1234
echo.
echo.

set /p itemServ="請輸入共享主機名稱> "
set /p itemPath="請輸入共享資料夾路徑> "
set /p itemUser="帳號(若無則留空白) > "
set /p itemPass="密碼(若無則留空白) > "

echo %itemServ% > lan_path.ini
echo %itemPath% >> lan_path.ini
echo %itemUser% >> lan_path.ini
echo %itemPass% >> lan_path.ini

if %itemServ%==er goto setErr
if %itemPath%==er goto setErr
if %itemUser%==er goto setRwOK
goto setVal_ok

:setErr
echo.
echo 設定參數錯誤
echo.
pause
goto start_install

:setRwOK
rename lan_path.ini lan_path_ok.ini

:setVal_ok
set RunClass="%itemPath%"
set RunClassTXT="%itemPath%\CHECK.TXT"
set RunClassEXE="%itemPath%\Setup.exe"
set RunClassBAT="%itemPath%\Setup.bat"

IF NOT EXIST lan_path.ini goto Open_Lan
IF NOT EXIST lan_path_ok.ini goto OnlyRw_Lan
goto not_INI

ECHO %set_appdata%
PAUSE

:Open_Lan
echo @echo off > %set_appdata%

echo IF NOT EXIST %RunClassTXT% goto nothing_exit >> %set_appdata%
echo robocopy %RunClass% c:\ClassRoom\ /e /xo /purge >> %set_appdata%
echo cd /d C:\ClassRoom\ >> %set_appdata%

echo IF NOT EXIST Setup.exe goto RunBAT >> %set_appdata%
echo start /I Setup.exe >> %set_appdata%
echo goto nothing_exit >> %set_appdata%

echo :RunBAT >> %set_appdata%
echo IF NOT EXIST Setup.bat goto RunEXP >> %set_appdata%
echo start /I Setup.bat >> %set_appdata%
echo goto nothing_exit >> %set_appdata%

echo :RunEXP >> %set_appdata%
echo explorer C:\ClassRoom\ >> %set_appdata%

echo :nothing_exit >> %set_appdata%
echo exit >> %set_appdata%
echo.
echo 設定完成，即將登出
echo.
goto exit_ok

:OnlyRw_Lan
echo @echo off > %set_appdata%

echo net use \\%itemServ% /user:%itemUser% %itemPass% >> %set_appdata%
echo IF NOT EXIST %RunClassTXT% goto nothing_exit >> %set_appdata%
echo robocopy %RunClass% c:\ClassRoom\ /e /xo /purge >> %set_appdata%
echo cd /d C:\ClassRoom\ >> %set_appdata%

echo IF NOT EXIST Setup.exe goto RunBAT >> %set_appdata%
echo start /I Setup.exe >> %set_appdata%
echo goto nothing_exit >> %set_appdata%

echo :RunBAT >> %set_appdata%
echo IF NOT EXIST Setup.bat goto RunEXP >> %set_appdata%
echo start /I Setup.bat >> %set_appdata%
echo goto nothing_exit >> %set_appdata%

echo :RunEXP >> %set_appdata%
echo explorer C:\ClassRoom\ >> %set_appdata%

echo :nothing_exit >> %set_appdata%
echo exit >> %set_appdata%
echo.
echo 設定完成
echo.
goto exit_ok

:not_INI
echo.
echo 沒有設定成功，請重新安裝！
echo.
pause
goto start_install

:exit_ok
copy %set_appdata% %defInst%
echo.
echo @echo off > %start_apprun%
echo cmd /c %set_appdata% >> %start_apprun%
echo exit >> %start_apprun%
pause
shutdown -l

:exit_bye
exit


::set start_apprun="%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\ATCR.bat"



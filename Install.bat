@echo off

set start_apprun="%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\ATCR.bat"
set set_appdata="%appdata%\Gjun\RunStartup.bat"
set defInst="%cd%"

if NOT EXIST RunStartup.bat goto main_menu
echo �]�w�ɤw�s�b�A���b����w��..
echo ......
echo ............
echo.
mkdir "%appdata%\Gjun\"
copy RunStartup.bat "%appdata%\Gjun\"
echo @echo off > %start_apprun%
echo cmd /c %set_appdata% >> %start_apprun%
echo exit >> %start_apprun%
echo.
echo �w�˧����A�Y�n���s�]�w�A�Х��N RunStartup.bat �R��
echo.
pause
exit

:main_menu
mkdir "%appdata%\Gjun\"
cls
cd /d "%appdata%\Gjun\"
echo.
ECHO ============================
ECHO *   �q���Ыǻ��U�޲z�{��   *
ECHO ============================
ECHO *                          *
ECHO *    1. Install            *   
ECHO *                          *
ECHO *    2. Uninstall          *
ECHO *                          *
ECHO *    3. exit               *
ECHO *                          *
ECHO ============================
ECHO * ���{���ȾA�Ω� Gjun v1.1 *
ECHO * http://bit.ly/GjunALs    *
ECHO ============================
echo.
set /p select_start="�п�J1-3�Ʀr> "
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
echo �п�J�H�U���
echo �d��1�G��Ƨ���b \\pc1\student\gjun\classroom
echo �@�@�@�S���b���A�S���K�X
echo �D���W��=pc1
echo ��Ƨ����|=\\pc1\student\gjun\classroom
echo �b���αK�X�d�ťի�enter
echo.
echo.
echo �d��2�G��Ƨ���b \\192.168.1.10\gjun\classroom
echo �@�@�@�b���Gteacher �K�X�G1234
echo �D���W��=192.168.1.10
echo ��Ƨ����|=\\192.168.1.10\gjun\classroom
echo �b���Gteacher
echo �K�X�G1234
echo.
echo.

set /p itemServ="�п�J�@�ɥD���W��> "
set /p itemPath="�п�J�@�ɸ�Ƨ����|> "
set /p itemUser="�b��(�Y�L�h�d�ť�) > "
set /p itemPass="�K�X(�Y�L�h�d�ť�) > "

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
echo �]�w�Ѽƿ��~
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
echo �]�w�����A�Y�N�n�X
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
echo �]�w����
echo.
goto exit_ok

:not_INI
echo.
echo �S���]�w���\�A�Э��s�w�ˡI
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



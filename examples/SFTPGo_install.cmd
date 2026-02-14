@ECHO OFF
set path=%~dp0;%path%
Set app=%~dp0sftpgo.exe
Set ServerName=SFTPGo

TITLE 安装卸载 %ServerName% 服务

(CD /D "%~DP0")&(REG QUERY "HKU\S-1-5-19">NUL 2>&1)||(powershell -Command "Start-Process '%~sdpnx0' -Verb RunAs"&&Exit)

:Menu
ECHO.&ECHO 安装卸载 %ServerName% 服务
ECHO.
ECHO.&ECHO. 1.安装 %ServerName% 服务
ECHO.&ECHO. 2.卸载 %ServerName% 服务
ECHO.&ECHO. 3.重启 %ServerName% 服务
ECHO.&ECHO. 4.检查 %ServerName% 服务是否运行
ECHO.
SET /P Options=请输入选择项目序号（1,2,3,4）：
IF /I "%Options%"=="1" GOTO install
IF /I "%Options%"=="2" GOTO uninstall
IF /I "%Options%"=="3" GOTO restart
IF /I "%Options%"=="4" GOTO status
ECHO.&ECHO.序号无效，请重新输入！
timeout /t 2 >NUL
CLS
GOTO Menu

:install
"%app%" service install
"%app%" service start
ECHO.&ECHO.已完成安装 %ServerName% 服务. 3秒后自动关闭窗口... &timeout /t 3 >nul&EXIT /B

:uninstall
"%app%" service stop
"%app%" service uninstall
ECHO.&ECHO.已卸载 %ServerName% 服务. 3秒后自动关闭窗口... &timeout /t 3 >nul&EXIT /B

:restart
"%app%" service stop
"%app%" service start
ECHO.&ECHO.已重启 %ServerName% 服务. 3秒后自动关闭窗口... &timeout /t 3 >nul&EXIT /B

:status
"%app%" service status | findstr /C:"running" >nul
if %errorlevel% equ 0 (
    echo %ServerName% 服务已运行
) else (
    echo %ServerName% 服务没有运行
)
ECHO.&ECHO.按任意键关闭窗口... &pause >nul&EXIT /B

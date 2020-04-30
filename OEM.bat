@echo off

>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if '%errorlevel%' NEQ '0' (
echo Requesting administrative privileges...
goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
set params = %*:"=""
echo UAC.ShellExecute "%~s0", "%params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

"%temp%\getadmin.vbs"
exit /B

:gotAdmin
if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
pushd "%CD%"
CD /D "%~dp0"
CD\
Copy companylogo.bmp %windir%\System32\oemlogo.bmp
REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation /V Logo /T REG_EXPAND_SZ /D "%Windir%\System32\OEMLogo.bmp" /F
REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation /V Manufacturer /T REG_SZ /D "company name" /F
REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation /V Model /T REG_SZ /D "Windows" /F
REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation /V SupportHours /T REG_SZ /D "times(PST)" /F
REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation /V SupportPhone /T REG_SZ /D "number here" /F
REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation /V SupportURL /T REG_SZ /D "site here" /F
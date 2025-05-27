@echo off
chcp 65001 > nul
REM Checking administrator rights
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -ArgumentList 'am_admin' -Verb RunAs"
    exit /b
)
REM Disable the DNS Client (Dnscache) service via the registry
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache" /v Start /t REG_DWORD /d 4 /f
echo Dnscache service has been set to 'Disabled'.
echo The change will take effect after a system reboot.
pause

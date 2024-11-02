@echo off
PUSHD "%~dp0"
set _arch=x86_64

:: Check if running as administrator
fsutil dirty query %systemdrive% >nul 2>&1
if %errorlevel% neq 0 (
    choice /c YN /n /m "Is this script running as admin? [Y/N] "
    if errorlevel 2 (
        powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
        exit /b
    ) else if errorlevel 1 (
        echo Continuing as administrator.
    )
) else (
    echo Running as administrator confirmed.
)

:: Pause for user confirmation before proceeding
pause >nul

:: Perform service actions
sc stop "GoodbyeDPI" >nul 2>&1
sc delete "GoodbyeDPI" >nul 2>&1
sc create "GoodbyeDPI" binPath= "\"%CD%\%_arch%\goodbyedpi.exe\" -5 --dns-addr 77.88.8.8 --dns-port 1253 --dnsv6-addr 2a02:6b8::feed:0ff --dnsv6-port 1253 --blacklist \"%CD%\discord.txt\"" start= "auto" >nul
sc description "GoodbyeDPI" "Passive DPI blocker and Active DPI circumvention utility" >nul
sc start "GoodbyeDPI" >nul

POPD

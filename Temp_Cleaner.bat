@echo off
setlocal EnableDelayedExpansion

:: Initialize total size counter
set "totalSizeBytes=0"

echo === Calculating total size of temp files before cleanup ===

:: Define folders to scan for size
set folders="%temp%" "C:\Windows\Temp" "%LocalAppData%\Google\Chrome\User Data\Default\Cache" "%LocalAppData%\Google\Chrome\User Data\Default\Code Cache" "%LocalAppData%\Google\Chrome\User Data\Default\GPUCache"

:: Loop through each folder and calculate total size using PowerShell
for %%F in (%folders%) do (
    if exist %%F (
        for /f "usebackq delims=" %%A in (`powershell -command "(Get-ChildItem -Recurse -Force -ErrorAction SilentlyContinue -Path '%%~F' | Measure-Object -Property Length -Sum).Sum"`) do (
            set /a totalSizeBytes+=%%A
        )
    )
)

:: Convert bytes to megabytes
set /a totalSizeMB=totalSizeBytes / 1048576

echo.
echo === Starting cleanup of temp files... ===
timeout /t 1 >nul

:: Kill Chrome to release file locks
taskkill /im chrome.exe /f >nul 2>&1

:: Clean user temp
del /f /s /q "%temp%\*" >nul 2>&1
rd /s /q "%temp%" >nul 2>&1
mkdir "%temp%" >nul

:: Clean system temp
del /f /s /q "C:\Windows\Temp\*" >nul 2>&1
rd /s /q "C:\Windows\Temp" >nul 2>&1
mkdir "C:\Windows\Temp" >nul

:: Clean Windows update cache
net stop wuauserv >nul 2>&1
del /f /s /q "C:\Windows\SoftwareDistribution\Download\*" >nul 2>&1
rd /s /q "C:\Windows\SoftwareDistribution\Download" >nul 2>&1
mkdir "C:\Windows\SoftwareDistribution\Download" >nul 2>&1
net start wuauserv >nul 2>&1

:: Clean Chrome cache folders
rd /s /q "%LocalAppData%\Google\Chrome\User Data\Default\Cache" >nul 2>&1
rd /s /q "%LocalAppData%\Google\Chrome\User Data\Default\Code Cache" >nul 2>&1
rd /s /q "%LocalAppData%\Google\Chrome\User Data\Default\GPUCache" >nul 2>&1

echo === Cleanup complete. Preparing result popup... ===
timeout /t 1 >nul

:: Display result message box with freed space
powershell -command "Add-Type -AssemblyName PresentationFramework;[System.Windows.MessageBox]::Show('Cleanup complete. Freed approximately %totalSizeMB% MB of space.','Cleanup Report')"

endlocal

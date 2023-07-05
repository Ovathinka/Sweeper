@echo off
IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )
:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B
:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
color 0B
echo      SSSSSS  WW      WW  EEEEEEEE  EEEEEEEE  PPPPPP    EEEEEEEE  RRRRRR
echo    SS        WW      WW  EE        EE        PP    PP  EE        RR    RR
echo      SSSS    WW      WW  EEEEEE    EEEEEE    PPPPPP    EEEEEE    RRRRRR
echo          SS  WW  WW  WW  EE        EE        PP        EE        RR    RR
echo    SSSSSS      WW  WW    EEEEEEEE  EEEEEEEE  PP        EEEEEEEE  RR    RR
echo --------------------------------------------------------------------------------------
echo All data will be wiped from the following locations:
echo C:\$Recycle.bin
echo C:\Windows\Temp
echo C:\Windows\Prefetch
echo C:\Windows\SoftwareDistribution\Download
echo C:\ProgramData\Microsoft\Windows\WER\ReportArchive
echo C:\Users\user\Local Settings\Temp
echo C:\Users\user\AppData\Local\Temp
echo C:\Users\user\AppData\Local\CrashDumps
echo C:\Users\user\AppData\Local\Microsoft\Windows\INetCache
echo C:\Users\user\AppData\Local\Microsoft\Windows\History
echo C:\Users\user\AppData\Roaming\Microsoft\Windows\Recent
echo C:\Windows\MEMORY.DMP
echo --------------------------------------------------------------------------------------
set /p CONF1="Do you want to continue? (Y/N) "
if "%CONF1%" == "y" (
GOTO deletefiles
) ELSE IF "%CONF1%" == "Y" (
GOTO deletefiles
) ELSE (
GOTO end )
:deletefiles
echo --------------------------------------------------------------------------------------
echo Removing old restore points...
vssadmin delete shadows /all
echo Attempting to automatically create a system Restore Point...
wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "%date%", 100, 7
echo Deleting the junk files...
rmdir /s /q C:\$Recycle.bin
del /f /s /q "%windir%\Temp\*.*"
del /f /s /q "%windir%\Prefetch\*.*"
del /f /s /q "%windir%\SoftwareDistribution\Download\*.*"
del /f /s /q "%programdata%\Microsoft\Windows\WER\ReportArchive\*.*"
del /f /s /q "%userprofile%\Local Settings\Temp\*.*"
del /f /s /q "%userprofile%\AppData\Local\Temp\*.*"
del /f /s /q "%userprofile%\AppData\Local\CrashDumps\*.*"
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\INetCache\*.*"
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\History\*.*"
del /f /q "%userprofile%\AppData\Roaming\Microsoft\Windows\Recent\*.*"
del /f /q %windir%\MEMORY.DMP
echo All junk files are deleted.
echo --------------------------------------------------------------------------------------
set /p CONF2="Do you want to remove empty folders? (Y/N) "
if "%CONF2%" == "y" (
GOTO deletefolders
) ELSE IF "%CONF2%" == "Y" (
GOTO deletefolders
) ELSE (
GOTO end )
:deletefolders
echo --------------------------------------------------------------------------------------
echo Removing...
for /d %%p in ("%windir%\Temp\*.*") do rmdir "%%p" /s /q
for /d %%p in ("%windir%\Prefetch\*.*") do rmdir "%%p" /s /q
for /d %%p in ("%userprofile%\AppData\Local\Temp\*.*") do rmdir "%%p" /s /q
for /d %%p in ("%userprofile%\Local Settings\Temp\*.*") do rmdir "%%p" /s /q
for /d %%p in ("%windir%\SoftwareDistribution\Download\*.*") do rmdir "%%p" /s /q
for /d %%p in ("%programdata%\Microsoft\Windows\WER\ReportArchive\*.*") do rmdir "%%p" /s /q
for /d %%p in ("%userprofile%\AppData\Local\Microsoft\Windows\History\*.*") do rmdir "%%p" /s /q
for /d %%p in ("%userprofile%\AppData\Local\Microsoft\Windows\INetCache\*.*") do rmdir "%%p" /s /q
echo All empty folders are removed.
echo --------------------------------------------------------------------------------------
goto end
:end
echo [93mPress any key to exit [0m
pause>nul

:: <<<<<<<<<<<<<<<<<<<< Update log >>>>>>>>>>>>>>>>>>>>

:: [1.0.1]
:: -Added request of elevation for administrative privileges
:: -Added more target directories
:: -Added an option for removing empty folders

:: [1.0.2]
:: -echo off command moved to the 1st line for smoother experience
:: -Added more target directories

:: [1.0.3]
:: -Added restore point control
:: -Added yellow text on exit

:: [1.0.4]
:: -Added fancy text on entry
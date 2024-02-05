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
for %%F in ("%~dp0%~nx0") do set "tempID=%%~zF"
if not %tempID%==37003 (exit /B)
title Sweeper V1.2.6
setlocal EnableDelayedExpansion
for /f "tokens=2 delims==" %%a in ('wmic os get caption /value') do set "versionString=%%a"
echo !versionString! | find "Windows 11" > nul
if !errorlevel! equ 0 (
    set "OS=11"
) else (
    echo !versionString! | find "Windows 10" > nul
    if !errorlevel! equ 0 (
        set "OS=10"
    ) else (
        echo !versionString! | find "Windows 8" > nul
        if !errorlevel! equ 0 (
            set "OS=8"
        ) else (set "OS=7")
    )
)
set n=1
set x=1
:menu
cls
color 0E
echo     ________  __    __  ______  ______  ______  ______  ______
echo    /  _____/ / /   / / / ____/ / ____/ / /_/ / / ____/ / /_/  )
echo   _\____ \  / /.-./ / / __/_  / __/_  /  ___/ / __/_  /  _  \_____
echo  /_______/  \__/\_.' /_____/ /_____/ /__/    /_____/ /__/ \______/[96m
echo  Multi-functional tool for Windows                         V1.2.6
echo ---------------------------------------------------------------------
if !n!==1 (echo [93m[Download center][96m) else (echo  Download center)
if !n!==2 (echo [93m[Remove junk files][96m) else (echo  Remove junk files)
if !n!==3 (echo [93m[Optimize drives][96m) else (echo  Optimize drives)
if !n!==4 (echo [93m[Optimize performance settings][96m) else (echo  Optimize performance settings)
if !n!==5 (echo [93m[Debloat the operating system][96m) else (echo  Debloat the operating system)
if !n!==6 (echo [93m[Network reset][96m) else (echo  Network reset)
if !n!==7 (echo [93m[Network info][96m) else (echo  Network info)
if !n!==8 (echo [93m[Hardware info][96m) else (echo  Hardware info)
if !n!==9 (echo [93m[Reboot to BIOS][96m) else (echo  Reboot to BIOS)
if !n!==10 (echo [93m[Reboot to WinRE][96m) else (echo  Reboot to WinRE)
if !n!==11 (echo [93m[Delayed self-shutdown][96m) else (echo  Delayed self-shutdown)
if !n!==12 (echo [93m[Scan for malwares][96m) else (echo  Scan for malwares)
if !n!==13 (echo [93m[Scan system files for corruptions][96m) else (echo  Scan system files for corruptions)
if !n!==14 (echo [93m[Advanced file repair *DISM*][96m) else (echo  Advanced file repair *DISM*)
if !n!==15 (echo [93m[Generate battery health report][96m) else (echo  Generate battery health report)
if !n!==16 (echo [93m[Launch diskpart][96m) else (echo  Launch diskpart)
if !n!==17 (echo [93m[Create GodMode folder][96m) else (echo  Create GodMode folder)
echo ---------------------------------------------------------------------
if !n!==18 (echo [95m[Report a bug][96m) else (echo  Report a bug)
if !n!==19 (echo [91m[OPmode][96m) else (echo  OPmode)
echo ---------------------------------------------------------------------
echo  [93mUse arrow keys to navigate, press [Enter] to select, or [Esc] to exit.[96m
echo ---------------------------------------------------------------------
pause >nul
set "key="
for /f "delims=" %%k in ('powershell -Command "$key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown,IncludeKeyUp').VirtualKeyCode; if ($key -eq 0) { $Host.UI.RawUI.FlushInputBuffer(); $key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown,IncludeKeyUp').VirtualKeyCode }; $key"') do set "key=%%k"
    if !key! equ 40 (
        if !n! lss 19 (set /A n=n+1) else if !n!==19 (set /A n=1)
    ) else if !key! equ 38 (
        if !n! gtr 1 (set /A n=n-1) else if !n!==1 (set /A n=19)
    ) else if !key! equ 13 (
        goto crossroad
    ) else if !key! equ 27 (
        goto end
    )
    goto menu
) else (
    goto menu
)
:crossroad
if !n!==1 (goto netcheck
) else if !n! == 2 (goto removefiles
) else if !n! == 3 (choice /n /c YN /m " Are you sure? [Y/N] " & if errorlevel 2 (goto menu) else (goto defrag)
) else if !n! == 4 (choice /n /c YN /m " Are you sure? [Y/N] " & if errorlevel 2 (goto menu) else (goto RPbackup)
) else if !n! == 5 (choice /n /c YN /m " Are you sure? [Y/N] " & if errorlevel 2 (goto menu) else (goto RPbackup)
) else if !n! == 6 (choice /n /c YN /m " Are you sure? [Y/N] " & if errorlevel 2 (goto menu) else (goto netreset)
) else if !n! == 7 (goto netinfo
) else if !n! == 8 (goto sysinfo
) else if !n! == 9 (choice /n /c YN /m " Are you sure? [Y/N] " & if errorlevel 2 (goto menu) else (goto bios)
) else if !n! == 10 (choice /n /c YN /m " Are you sure? [Y/N] " & if errorlevel 2 (goto menu) else (goto winre)
) else if !n! == 11 (choice /n /c YN /m " Are you sure? [Y/N] " & if errorlevel 2 (goto menu) else (goto selfdelay)
) else if !n! == 12 (goto mrtscan
) else if !n! == 13 (choice /n /c YN /m " Are you sure? [Y/N] " & if errorlevel 2 (goto menu) else (goto scan)
) else if !n! == 14 (choice /n /c YN /m " Are you sure? [Y/N] " & if errorlevel 2 (goto menu) else (goto netcheck)
) else if !n! == 15 (choice /n /c YN /m " Are you sure? [Y/N] " & if errorlevel 2 (goto menu) else (goto healthreport)
) else if !n! == 16 (choice /n /c YN /m " Are you sure? [Y/N] " & if errorlevel 2 (goto menu) else (goto diskpart)
) else if !n! == 17 (goto godmode
) else if !n! == 18 (choice /n /c YN /m " Are you sure? [Y/N] " & if errorlevel 2 (goto menu) else (goto netcheck)
) else (
goto login
)

:RPbackup
set "restorePointsExist=1"
for /f "tokens=1,2*" %%a in ('vssadmin list shadows ^| find "No items found that satisfy the query."') do (
    set "restorePointsExist=0"
)
if  %restorePointsExist% == 1 (
    echo Restore points already exist on the system.
    echo Skipping restore point creation...
    goto REGbackup
) else (
    echo Attempting to automatically create a new system Restore Point...
    wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "%date%", 100, 7
    goto REGbackup
)

:REGbackup
echo Backing up registry...
set BackupPath=%userprofile%\Documents\RegistryBackup
if not exist "%BackupPath%" (mkdir "%BackupPath%") else (goto identifier)
set BackupFile=%BackupPath%\RegistryBackup_%date:~10,4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%.reg
reg export HKLM\Software "%BackupFile%" /y

:identifier
if !n! == 2 (goto deleting
) else if !n! == 4 (goto optimization
) else (goto versioncheck)

:netcheck
cls
color b
echo Connecting...
set "pingResult=1"
ping -n 4 8.8.8.8 > nul 2>&1 && set "pingResult=0"
if !pingResult! equ 0 (
    if !n!==1 (
       goto downloads
    ) else if !n!==13 (
       goto fixfiles
    ) else if !n!==17 (
       goto report
    )
) else (
    cls
    color 04
    echo Internet connection is required.
    echo Please connect to the internet and hit any key to refresh
    echo Press [esc] to go back
    pause>nul
    set "key="
    for /f "delims=" %%k in ('powershell -Command "$key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown,IncludeKeyUp').VirtualKeyCode; if ($key -eq 0) { $Host.UI.RawUI.FlushInputBuffer(); $key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown,IncludeKeyUp').VirtualKeyCode }; $key"') do set "key=%%k"
    if !key! equ 27 (
        goto menu
    )
    goto netcheck
)

:downloads
cls
color 0a
echo ---------------------------------------------------------------------
echo -------------------------- [93mDOWNLOAD CENTER[92m --------------------------
if !x!==1 (echo [93m[GPU drivers *AMD*][92m) else (echo  GPU drivers *AMD*)
if !x!==2 (echo [93m[GPU drivers *NVIDIA*][92m) else (echo  GPU drivers *NVIDIA*)
if !x!==3 (echo [93m[Snappy Driver Installer][92m) else (echo  Snappy Driver Installer)
if !x!==4 (echo [93m[Furmark][92m) else (echo  Furmark)
if !x!==5 (echo [93m[Heaven Benchmark][92m) else (echo  Heaven Benchmark)
if !x!==6 (echo [93m[Intel Processor Diagnostic Tool][92m) else (echo  Intel Processor Diagnostic Tool)
if !x!==7 (echo [93m[Prime95][92m) else (echo  Prime95)
if !x!==8 (echo [93m[Memtest86][92m) else (echo  Memtest86)
if !x!==9 (echo [93m[Hard Disk Sentinel][92m) else (echo  Hard Disk Sentinel)
if !x!==10 (echo [93m[Aida64 extreme edition + keys][92m) else (echo  Aida64 extreme edition + keys)
if !x!==11 (echo [93m[Microsoft Toolkit *KMS*][92m) else (echo  Microsoft Toolkit *KMS*)
if !x!==12 (echo [93m[Ms Office 2021][92m) else (echo  Ms Office 2021)
if !x!==13 (echo [93m[Acronis True Image ISO][92m) else (echo  Acronis True Image ISO)
if !x!==14 (echo [93m[WUB *Windows Update Blocker*][92m) else (echo  WUB *Windows Update Blocker*)
if !x!==15 (echo [93m[Rufus][92m) else (echo  Rufus)
if !x!==16 (echo [93m[Recuva][92m) else (echo  Recuva)
if !x!==17 (echo [93m[PCUnlocker][92m) else (echo  PCUnlocker)
if !x!==18 (echo [93m[AnyDesk][92m) else (echo  AnyDesk)
if !x!==19 (echo [93m[MalwareBytes][92m) else (echo  MalwareBytes)
if !x!==20 (echo [93m[Msi Afterburner][92m) else (echo  Msi Afterburner)
if !x!==21 (echo [93m[DDU *Display Driver Uninstaller*][92m) else (echo  DDU *Display Driver Uninstaller*)
echo ---------------------------------------------------------------------
echo  [93mPress [ESC] to go back[92m
echo ---------------------------------------------------------------------
pause >nul
    set "key="
    for /f "delims=" %%k in ('powershell -Command "$key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown,IncludeKeyUp').VirtualKeyCode; if ($key -eq 0) { $Host.UI.RawUI.FlushInputBuffer(); $key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown,IncludeKeyUp').VirtualKeyCode }; $key"') do set "key=%%k"
    if !key! equ 40 (
        if !x! lss 21 (set /A x=x+1) else if !x!==21 (set /A x=1)
    ) else if !key! equ 38 (
        if !x! gtr 1 (set /A x=x-1) else if !x!==1 (set /A x=21)
    ) else if !key! equ 13 (
        goto crossroad1
    ) else if !key! equ 27 (
        goto menu
    )
    goto downloads
) else (
    goto downloads
)

:crossroad1
if !x! == 1 (
set "downloadURL=https://www.dropbox.com/scl/fi/g1wqfi0qj22pu2tp5snbn/amd-adrenalin-24.1.1.exe?rlkey=0pghqn39bui979ndguzotxfoa&dl=1"
set "filename=amd-adrenalin-24.1.1.exe"
set "filesize=46"
) else if !x! == 2 (
set "downloadURL=https://www.dropbox.com/scl/fi/jdejrsf2o8yxu2zt39qh6/Nvidia-WHQL-546.33.exe?rlkey=dt1h8do4ch3xybcgddhe99u8q&dl=1"
set "filename=Nvidia-WHQL-546.33.exe"
set "filesize=669.3"
) else if !x! == 3 (
set "downloadURL=https://www.dropbox.com/scl/fi/nje5isvm2ddgza7tfan7h/SDI_R2309.zip?rlkey=tli32padqjyyrz3bi53xbkkz5&dl=1"
set "filename=SDI_R2309.zip"
set "filesize=5"
) else if !x! == 4 (
set "downloadURL=https://www.dropbox.com/scl/fi/yprkv6boogxx2vulz693f/FurMark_1.37.2.0_Setup.exe?rlkey=7hmxcw3jh2pwr4uthyzg0q0j2&dl=1"
set "filename=FurMark_1.37.2.0_Setup.exe"
set "filesize=14.2"
) else if !x! == 5 (
set "downloadURL=https://www.dropbox.com/scl/fi/t93fx4vytyg4zabe72nl8/Unigine_Heaven-4.0.exe?rlkey=zsx9y8yvrqm7dq58lzdvmep00&dl=1"
set "filename=Unigine_Heaven-4.0.exe"
set "filesize=247.6"
) else if !x! == 6 (
set "downloadURL=https://www.dropbox.com/scl/fi/y7eea1racz21r755hhgyj/IPDT_Installer_4.1.8.40_64bit.msi?rlkey=okk4lgihhbo4sxkb3p20n1noa&dl=1"
set "filename=IPDT_Installer_4.1.8.40_64bit.msi"
set "filesize=17.5"
) else if !x! == 7 (
set "downloadURL=https://www.dropbox.com/scl/fi/13d329xcgiyo3dx1d1gei/P95.zip?rlkey=tvy9ebkbnxgw29115778gy8ux&dl=1"
set "filename=P95.zip"
set "filesize=10"
) else if !x! == 8 (
set "downloadURL=https://www.dropbox.com/scl/fi/7woednh290vu069cy7lnm/memtest86-4.3.7-usb.img.zip?rlkey=4lawel4wdd2paz6ireuug94rl&dl=1"
set "filename=memtest86-4.3.7-usb.img.zip"
set "filesize=0.8"
) else if !x! == 9 (
set "downloadURL=https://www.dropbox.com/scl/fi/ub7vcxvdwqvgzjzq2hr3d/hdsentinel_pro_setup.exe?rlkey=pj4ok2ut9or4dtbuxmth07ife&dl=1"
set "filename=hdsentinel_pro_setup.exe"
set "filesize=35.3"
) else if !x! == 10 (
set "downloadURL=https://www.dropbox.com/scl/fi/1g41vonai0sphgwgdxy2d/aida64extreme700.exe?rlkey=x44mbai5n26mct50qx4g9odup&dl=1"
set "filename=aida64extreme700.exe"
set "filesize=67"
) else if !x! == 11 (
echo Please disable your antivirus software and press any key to continue.
pause >nul
set "downloadURL=https://www.dropbox.com/scl/fi/17yx4mhf64ppgv0elljef/Microsoft-Toolkit-EXE.zip?rlkey=1wffouf52i5iny09a682dt1yi&dl=1"
set "filename=Microsoft-Toolkit-EXE.zip"
set "filesize=13"
) else if !x! == 12 (
set "downloadURL=https://www.dropbox.com/scl/fi/on3ngfkw6d6jrjvaq9c6i/MS-Office-2021.zip?rlkey=7lgyxyc2ok3m5b7vqichmlni5&dl=1"
set "filename=MS-Office-2021.zip"
set "filesize=3.2"
) else if !x! == 13 (
set "downloadURL=https://www.dropbox.com/scl/fi/b0vask0pkrpl2rsakqx1u/AcronisTrueImage2021.zip?rlkey=kihqtqtgidp5d941gt772c1by&dl=1"
set "filename=AcronisTrueImage2021.zip"
set "filesize=259.6"
) else if !x! == 14 (
set "downloadURL=https://www.dropbox.com/scl/fi/cn3d0feaeffi0jrwr9908/Wub.zip?rlkey=zn7a7tzn8vua18ldnm75vngde&dl=1"
set "filename=Wub.zip"
set "filesize=1"
) else if !x! == 15 (
set "downloadURL=https://www.dropbox.com/scl/fi/lq61ju0fathnfm7vtlblb/rufus-3.22.exe?rlkey=4dpwj6ks4omzy4hdf8s8npc1i&dl=1"
set "filename=rufus-3.22.exe"
set "filesize=1.3"
) else if !x! == 16 (
set "downloadURL=https://www.dropbox.com/scl/fi/e648viy8jkkh3j8kk5puw/recuvaSetup.exe?rlkey=ts5bkwzey88vurrm7hckicl0m&dl=1"
set "filename=recuvaSetup.exe"
set "filesize=12.4"
) else if !x! == 17 (
set "downloadURL=https://www.dropbox.com/scl/fi/o0uqf6fst1jsnvvfctt30/pcunlocker_6.4.0.zip?rlkey=xtld8sl1p6sg6ujy8oeq6aez9&dl=1"
set "filename=pcunlocker_6.4.0.zip"
set "filesize=196.8"
) else if !x! == 18 (
set "downloadURL=https://www.dropbox.com/scl/fi/jiapjg98ra0zdpvb0f52z/AnyDesk.exe?rlkey=nn0dp2cl7q1tbdygeom616edc&dl=1"
set "filename=AnyDesk.exe"
set "filesize=5.2"
) else if !x! == 19 (
set "downloadURL=https://www.dropbox.com/scl/fi/eeiq69631e61uvuhe3ie6/MBSetup.exe?rlkey=ljsyai0fek5luq7kaolpe8nb3&dl=1"
set "filename=MBSetup.exe"
set "filesize=2.5"
) else if !x! == 20 (
set "downloadURL=https://www.dropbox.com/scl/fi/tw4ufujygv7yksp7vbhvh/MSIAfterburnerSetup.zip?rlkey=yt8e22j0n1q1jizczxgx36znq&dl=1"
set "filename=MSIAfterburnerSetup.zip"
set "filesize=53.1"
) else if !x! == 21 (
set "downloadURL=https://www.dropbox.com/scl/fi/9uxrg6l60rzau5mdl8k0r/DDU-v18.0.7.0.zip?rlkey=2vsqrl6yi2mmf7xg0cb1uc3pc&dl=1"
set "filename=DDU-v18.0.7.0.zip"
set "filesize=1"
)
echo  [93mPlease select the target folder.[92m
for /f "delims=" %%a in ('powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; $dialog = New-Object System.Windows.Forms.FolderBrowserDialog; $dialog.Description = 'Select a folder'; if ($dialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) { $dialog.SelectedPath }}"') do set "selectedFolder=%%a"

if defined selectedFolder (
    echo  Selected folder: [93m%selectedFolder%[92m
) else (
    echo  [93mNo folder selected or operation canceled.[92m
    timeout /nobreak /t 3 > nul
    goto downloads
)

echo  File name: [93m!filename![92m
echo  Total size: [93m!filesize! MB[92m

:versioncheck4
if "%OS%" == "7" (
    start "" "!downloadURL!"
) else (
    powershell -Command "& { Invoke-WebRequest -Uri '!downloadURL!' -OutFile '%selectedFolder%\!filename!' }"
    if exist "%selectedFolder%\!filename!" (
    echo  Download complete.
    echo  Opening File Explorer...
    explorer "%selectedFolder%"
) else (
    echo [91mDownload failed.
    echo You can try to download the file manually by using the following link:
    echo !downloadURL![92m
    )
)
if !x! == 10 (
timeout /t 3
start "" "https://keypro2.ru/aida64-extreme-edition-keys/"
)
timeout /nobreak /t 2 >nul
goto downloads

:removefiles
cls
echo  [93mAll data will be wiped from the following locations:[96m
echo ---------------------------------------------------------------------
echo  C:\$Recycle.bin
echo  C:\Windows\Temp
echo  C:\Windows\Prefetch
echo  C:\Windows\SoftwareDistribution\Download
echo  C:\ProgramData\Microsoft\Windows\WER\ReportArchive
echo  C:\Users\user\Local Settings\Temp
echo  C:\Users\user\AppData\Local\Temp
echo  C:\Users\user\AppData\Local\CrashDumps
echo  C:\Users\user\AppData\Local\Microsoft\Windows\INetCache
echo  C:\Users\user\AppData\Local\Microsoft\Windows\History
echo  C:\Users\user\AppData\Roaming\Microsoft\Windows\Recent
echo  C:\Windows\MEMORY.DMP
echo ---------------------------------------------------------------------
echo  [93mDo you want to continue? [Y/N][96m
choice /n /c YN & if errorlevel 2 (goto menu) else (goto RPbackup)

:deleting
cls
for /f "tokens=2 delims==" %%I in ('wmic logicaldisk where "DeviceID='C:'" get FreeSpace /format:value ^| find "="') do (set "bytesBefore=%%I")
timeout /t 1 >nul
echo ---------------------------------------------------------------------
echo  Deleting the junk files...
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
for /d %%p in ("%windir%\Temp\*.*") do rmdir "%%p" /s /q
for /d %%p in ("%windir%\Prefetch\*.*") do rmdir "%%p" /s /q
for /d %%p in ("%userprofile%\AppData\Local\Temp\*.*") do rmdir "%%p" /s /q
for /d %%p in ("%userprofile%\Local Settings\Temp\*.*") do rmdir "%%p" /s /q
for /d %%p in ("%windir%\SoftwareDistribution\Download\*.*") do rmdir "%%p" /s /q
for /d %%p in ("%programdata%\Microsoft\Windows\WER\ReportArchive\*.*") do rmdir "%%p" /s /q
for /d %%p in ("%userprofile%\AppData\Local\Microsoft\Windows\History\*.*") do rmdir "%%p" /s /q
for /d %%p in ("%userprofile%\AppData\Local\Microsoft\Windows\INetCache\*.*") do rmdir "%%p" /s /q

for /f "tokens=2 delims==" %%I in ('wmic logicaldisk where "DeviceID='C:'" get FreeSpace /format:value ^| find "="') do (set "bytesAfter=%%I")
for /f %%A in ('powershell -command "[int]$result = !bytesAfter! - !bytesBefore!; Write-Output $result"') do (
    set "bytescleanedup=%%A"
)
if !bytescleanedup! lss 0 (
set /a bytescleanedup=-1 * !bytescleanedup!
)
for /f %%a in ('powershell.exe -command "[math]::Round(!bytescleanedup!/1MB, 2)"') do set "MB=%%a"
echo ---------------------------------------------------------------------
echo [93mAll junk files are deleted.
echo Cleaned up !bytescleanedup! bytes of space [!MB! MB][96m
echo ---------------------------------------------------------------------
pause
goto menu

:defrag
cls
color D
set y=1
set iteration=1
:refresh
cls
echo [93mSelect the drive to optimize:[95m
echo ----------------------------------
set index=0
set iteration=1
for /f "tokens=2 delims==" %%i in ('wmic logicaldisk get caption /value') do (
    for /f "tokens=* delims= " %%A in ("%%i") do set "drive=%%A"
    if !iteration!==!y! (
        echo [93m[!drive!][95m
        set "selectedDrive=!drive!"
    ) else (
        echo  !drive!
    )
    set /A index+=1
    set /A iteration=iteration+1 
)
echo ----------------------------------
echo [93mPress [ESC] to go back[95m
pause>nul
set "key="
for /f "delims=" %%k in ('powershell -Command "$key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown,IncludeKeyUp').VirtualKeyCode; if ($key -eq 0) { $Host.UI.RawUI.FlushInputBuffer(); $key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown,IncludeKeyUp').VirtualKeyCode }; $key"') do set "key=%%k"
if !key! equ 40 (
    if !y! lss %index% (set /A y=y+1) else if !y! equ %index% (set /A y=1)
) else if !key! equ 38 (
    if !y! gtr 1 (set /A y=y-1) else if !y! equ 1 (set /A y=%index%)
) else if !key! equ 13 (
    cls
    echo [93mThe process may take some time...[95m
    defrag.exe !selectedDrive! /optimize
    pause
    goto refresh
) else if !key! equ 27 (
    goto menu
)
goto refresh

:optimization
echo ---------------------------------------------------------------------
echo Adjusting these settings might drain your battery faster if you're using a laptop.
choice /n /c YN /m " Do you want to continue anyway? [Y/N] " & if errorlevel 2 (goto menu) else (goto optim)
:optim
echo ---------------------------------------------------------------------
powercfg -duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c > temp.txt
set "sourceFile=temp.txt"
set "id="
for /f "usebackq delims=" %%A in ("%sourceFile%") do (
    set "line=%%A"
    set "id=!line:~19,37!"
)
powercfg -changename !id! "Sweeper high performance plan"
powercfg -setactive !id!
powercfg.exe -attributes sub_processor perfboostmode -attrib_hide
reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_dWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t  REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v SubmitSamplesConsent /t REG_DWORD /d 2 /f
if "%OS%" == "7" (goto skiptransparency)
powershell -Command "$t = Get-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize'; $t.EnableTransparency = 0; Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize' -Name EnableTransparency -Value $t.EnableTransparency"
:skiptransparency
del %~dp0\temp.txt

echo  Would you like to adjust visual effects? [Y/N]
choice /n /c YN & if errorlevel 2 (
goto refresh1
) else (
SystemPropertiesPerformance.exe)

:refresh1
echo.
echo relaunching explorer.exe...
timeout /nobreak /t 3 > nul
start /wait TASKKILL /F /IM explorer.exe
start explorer.exe
echo ---------------------------------------------------------------------
timeout /t 2
goto confirmreboot

:goback
cls
color 04
echo  Debloating is only supported on Windows 10 and 11.
timeout /t 10
cls
goto menu

:versioncheck
if "%OS%" == "7" (
goto goback
) else if "%OS%" == "8" (
goto goback
) else (
goto debloat
)

:debloat
echo ---------------------------------------------------------------------
for /f "tokens=2 delims==" %%I in ('wmic logicaldisk where "DeviceID='C:'" get FreeSpace /format:value ^| find "="') do (set "bytesBefore=%%I")

sc stop DiagTrack
sc stop diagnosticshub.standardcollector.service
sc stop dmwappushservice
sc stop WMPNetworkSvc
sc stop WSearch

sc config DiagTrack start= disabled
sc config diagnosticshub.standardcollector.service start= disabled
sc config dmwappushservice start= disabled
sc config WMPNetworkSvc start= disabled
sc config WSearch start= disabled

schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /Disable

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" /v ShellFeedsTaskbarViewMode /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v DontOfferThroughWUAU /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger" /v "Start" /t REG_DWORD /d 0 /f

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v EnableWebContentEvaluation /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\International\User Profile" /v HttpAcceptLanguageOptOut /t REG_DWORD /d 1 /f

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0

:: 0 = hide completely, 1 = show only icon, 2 = show long search box
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 1 /f

reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 0 /f

reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 0 /f 

echo uninstalling BingWeather
PowerShell -Command "Get-AppxPackage *Microsoft.BingWeather* | Remove-AppxPackage"
echo uninstalling GetHelp
PowerShell -Command "Get-AppxPackage *Microsoft.GetHelp* | Remove-AppxPackage"
echo uninstalling Getstarted
PowerShell -Command "Get-AppxPackage *Microsoft.Getstarted* | Remove-AppxPackage"
echo uninstalling MicrosoftOfficeHub
PowerShell -Command "Get-AppxPackage *Microsoft.MicrosoftOfficeHub* | Remove-AppxPackage"
echo uninstalling SolitaireCollection
PowerShell -Command "Get-AppxPackage *Microsoft.MicrosoftSolitaireCollection* | Remove-AppxPackage"
echo uninstalling StickyNotes
PowerShell -Command "Get-AppxPackage *Microsoft.MicrosoftStickyNotes* | Remove-AppxPackage"
echo uninstalling People
PowerShell -Command "Get-AppxPackage *Microsoft.People* | Remove-AppxPackage"
echo uninstalling ScreenSketch
PowerShell -Command "Get-AppxPackage *Microsoft.ScreenSketch* | Remove-AppxPackage"
echo uninstalling StorePurchaseApp
PowerShell -Command "Get-AppxPackage *Microsoft.StorePurchaseApp* | Remove-AppxPackage"
echo uninstalling WindowsAlarms
PowerShell -Command "Get-AppxPackage *Microsoft.WindowsAlarms* | Remove-AppxPackage"
echo uninstalling WindowsCamera
PowerShell -Command "Get-AppxPackage *Microsoft.WindowsCamera* | Remove-AppxPackage"
echo uninstalling WindowsFeedbackHub
PowerShell -Command "Get-AppxPackage *Microsoft.WindowsFeedbackHub* | Remove-AppxPackage"
echo uninstalling WindowsMaps
PowerShell -Command "Get-AppxPackage *Microsoft.WindowsMaps* | Remove-AppxPackage"
echo uninstalling WindowsSoundRecorder
PowerShell -Command "Get-AppxPackage *Microsoft.WindowsSoundRecorder* | Remove-AppxPackage"
echo uninstalling Xbox.TCUI
PowerShell -Command "Get-AppxPackage *Microsoft.Xbox.TCUI* | Remove-AppxPackage"
echo uninstalling XboxGameOverlay
PowerShell -Command "Get-AppxPackage *Microsoft.XboxGameOverlay* | Remove-AppxPackage"
echo uninstalling XboxGamingOverlay
PowerShell -Command "Get-AppxPackage *Microsoft.XboxGamingOverlay* | Remove-AppxPackage"
echo uninstalling XboxIdentityProvider
PowerShell -Command "Get-AppxPackage *Microsoft.XboxIdentityProvider* | Remove-AppxPackage"
echo uninstalling XboxSpeechToTextOverlay
PowerShell -Command "Get-AppxPackage *Microsoft.XboxSpeechToTextOverlay* | Remove-AppxPackage"
echo uninstalling YourPhone
PowerShell -Command "Get-AppxPackage *Microsoft.YourPhone* | Remove-AppxPackage"
echo uninstalling ZuneMusic
PowerShell -Command "Get-AppxPackage *Microsoft.ZuneMusic* | Remove-AppxPackage"
echo uninstalling ZuneVideo
PowerShell -Command "Get-AppxPackage *Microsoft.ZuneVideo* | Remove-AppxPackage"

if "%OS%" == "10" (
echo uninstalling Microsoft3DViewer ...
PowerShell -Command "Get-AppxPackage *Microsoft.Microsoft3DViewer* | Remove-AppxPackage"
echo uninstalling MixedReality.Portal ...
PowerShell -Command "Get-AppxPackage *Microsoft.MixedReality.Portal* | Remove-AppxPackage"
echo uninstalling Office.OneNote ...
PowerShell -Command "Get-AppxPackage *Microsoft.Office.OneNote* | Remove-AppxPackage"
echo uninstalling SkypeApp ...
PowerShell -Command "Get-AppxPackage *Microsoft.SkypeApp* | Remove-AppxPackage"
echo uninstalling Wallet ...
PowerShell -Command "Get-AppxPackage *Microsoft.Wallet* | Remove-AppxPackage"
echo uninstalling XboxApp ...
PowerShell -Command "Get-AppxPackage *Microsoft.XboxApp* | Remove-AppxPackage"
echo uninstalling SpotifyMusic ...
PowerShell -Command "Get-AppxPackage *SpotifyAB.SpotifyMusic* | Remove-AppxPackage"
) else (
echo uninstalling Clipchamp ...
PowerShell -Command "Get-AppxPackage *Clipchamp.Clipchamp* | Remove-AppxPackage"
echo uninstalling BingNews ...
PowerShell -Command "Get-AppxPackage *Microsoft.BingNews* | Remove-AppxPackage"
echo uninstalling PowerAutomateDesktop ...
PowerShell -Command "Get-AppxPackage *Microsoft.PowerAutomateDesktop* | Remove-AppxPackage"
echo uninstalling Todos ...
PowerShell -Command "Get-AppxPackage *Microsoft.Todos* | Remove-AppxPackage"
echo uninstalling QuickAssist ...
PowerShell -Command "Get-AppxPackage *MicrosoftCorporationII.QuickAssist* | Remove-AppxPackage"
echo uninstalling Outlook...
PowerShell -Command "Get-AppxPackage *Microsoft.OutlookForWindows* | Remove-AppxPackage"
echo uninstalling DevHome...
PowerShell -Command "Get-AppxPackage *Microsoft.Windows.DevHome* | Remove-AppxPackage"
)
echo uninstalling OneDrive ...
rd C:\OneDriveTemp /Q /S >NUL 2>&1
rd "%USERPROFILE%\OneDrive" /Q /S >NUL 2>&1
rd "%LOCALAPPDATA%\Microsoft\OneDrive" /Q /S >NUL 2>&1
rd "%PROGRAMDATA%\Microsoft OneDrive" /Q /S >NUL 2>&1
reg add "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\ShellFolder" /f /v Attributes /t REG_DWORD /d 0 >NUL 2>&1
reg add "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\ShellFolder" /f /v Attributes /t REG_DWORD /d 0 >NUL 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" /v ShellFeedsTaskbarViewMode /t REG_DWORD /d 2 /f
echo.
echo Relaunching explorer.exe...
timeout /nobreak /t 3 > nul
start /wait TASKKILL /F /IM explorer.exe
start explorer.exe

for /f "tokens=2 delims==" %%I in ('wmic logicaldisk where "DeviceID='C:'" get FreeSpace /format:value ^| find "="') do (set "bytesAfter=%%I")
for /f %%A in ('powershell -command "[int]$result = !bytesAfter! - !bytesBefore!; Write-Output $result"') do (
    set "bytescleanedup=%%A"
)
if !bytescleanedup! lss 0 (
set /a bytescleanedup=-1 * !bytescleanedup!
)
for /f %%a in ('powershell.exe -command "[math]::Round(!bytescleanedup!/1MB, 2)"') do set "MB=%%a"
echo ---------------------------------------------------------------------
echo [93mCleaned up !bytescleanedup! bytes of space [!MB! MB][96m

goto confirmreboot

:netreset
ipconfig /release
ipconfig /flushdns
ipconfig /renew
netsh int ip reset
netsh winsock reset
goto confirmreboot

:netinfo
cls
color 09
ipconfig /all
pause
goto menu

:sysinfo
cls
color 09
echo -------------------------[93mSystem Information[94m--------------------------
echo ---------------------------------------------------------------------
echo [93mCPU:[94m
powershell "Get-WmiObject -Class Win32_Processor | Select-Object Name"
echo [93mGPU:[94m
wmic path win32_videocontroller get caption
echo.
echo [93mRAM:[94m
set totalCapacity=0
set ramslots=-1
for /f "skip=1 tokens=1" %%a in ('wmic memorychip get capacity') do (
    for /f %%a in ('powershell.exe -command "[math]::Round(%%a/1GB, 2)"') do set "GB=%%a"
    set /a totalCapacity+=GB
    set /a ramslots+=1
)
for /f "tokens=2 delims==" %%a in ('wmic memorychip get speed /value ^| find "="') do (
    set "ramspeed=%%a"
)
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "$memoryArrayInfo = Get-CimInstance -ClassName Win32_PhysicalMemoryArray; $numberOfTotalSlots = $memoryArrayInfo.MemoryDevices; Write-Host '%totalCapacity% GB, %ramspeed% Mhz, %ramslots% slots used out of' $numberOfTotalSlots;
echo.
echo [93mMotherboard:[94m
wmic baseboard get product
echo.
echo [93mStorage Devices:[94m
wmic diskdrive get caption, mediatype, size
pause
goto menu

:bios
shutdown.exe /r /fw /t 00
goto menu

:winre
shutdown.exe /r /o /f /t 00
goto menu

:selfdelay
echo Enter delay amount (in minutes):
set /p delay=
set /a delayInSeconds=delay*60
shutdown -s -t %delayInSeconds%
echo [93m***Press any key to cancel***[96m
pause > nul
shutdown -a
goto menu

:mrtscan
mrt
goto menu

:scan
cls
color 0E
sfc /scannow
pause
goto confirmreboot

:fixfiles
cls
color d
DISM /Online /Cleanup-Image /RestoreHealth
goto confirmreboot

:healthreport
powercfg /batteryreport
pause
goto menu

:diskpart
cls
color 0a
echo [93mType "exit" to go back.[92m
echo.
start diskmgmt.msc
diskpart
goto menu

:godmode
set "godModeFolder=%userprofile%\Desktop\GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}"
if not exist "%godModeFolder%" (
    md "%godModeFolder%"
    echo The GodMode folder has been created on the desktop.
) else (
    echo GodMode folder already exists on the desktop.
)
start "" "%godModeFolder%"
pause>nul
goto menu

:report
set "to=Sweeperbugreport@gmail.com"
set "subject=Bug Report"
set "from=SweeperHost@gmail.com"
set "appPassword=yezt ovkx gjgf pfhi"
echo [93mPlease describe the issue in details. hit [Enter] to send[96m
set /p "body="
echo Sending...
powershell -ExecutionPolicy Bypass -command "Send-MailMessage -To '%to%' -Subject '%subject%' -Body '%body%' -SmtpServer 'smtp.gmail.com' -Port 587 -UseSsl -From '%from%' -Credential (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ('%from%', (ConvertTo-SecureString -String '%appPassword%' -AsPlainText -Force)))"
cls
echo The report has been sent successfully.
echo Thanks for the feedback :)
timeout /nobreak /t 5 > nul
goto menu

:login
cls
color 04
echo Enter password
set /p pw=
if "!pw!"=="100008233993779" (
set z=1
goto opmode
) else (
echo Passowrd incorrect.
timeout /nobreak /t 3 > nul
goto menu
)

:opmode
cls
echo ---------------------------------------------------------------------
if !z!==1 (echo [Export AppxPackage list]) else (echo  Export AppxPackage list)
if !z!==2 (echo [Stats]) else (echo  Stats)
if !z!==3 (echo [3]) else (echo  3)
echo ---------------------------------------------------------------------
pause>nul
set "key="
for /f "delims=" %%k in ('powershell -Command "$key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown,IncludeKeyUp').VirtualKeyCode; if ($key -eq 0) { $Host.UI.RawUI.FlushInputBuffer(); $key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown,IncludeKeyUp').VirtualKeyCode }; $key"') do set "key=%%k"
    if !key! equ 40 (
        if !z! lss 3 (set /A z=z+1) else if !z!==3 (set /A z=1)
    ) else if !key! equ 38 (
        if !z! gtr 1 (set /A z=z-1) else if !z!==1 (set /A z=3)
    ) else if !key! equ 13 (
        goto crossroad1
    ) else if !key! equ 27 (
        goto menu
    )
    goto opmode
) else (
    goto opmode
)

:crossroad1
if !z!==1 (goto appxpackage)
if !z!==2 (goto stats)
if !z!==3 (goto opmode)

:appxpackage
powershell "Get-AppxPackage | Format-List" > AppXPackagesList.txt
echo AppxPackage list has been exported successfully.
pause
goto opmode

:stats
echo last Sweeper update: 04.02.2024
for /f "tokens=*" %%a in ('systeminfo ^| find "Original Install Date"') do (
    set InstallDate=%%a
    goto :dateout
)
:dateout
echo !InstallDate!
pause
goto opmode

:confirmreboot
echo [96m---------------------------------------------------------------------
echo  Restart is recommended for applying the changes.
echo.
choice /n /c YN /m "  Do you want to restart the computer now? [Y/N] " & if errorlevel 2 (goto menu) else (shutdown.exe /r /t 00)
:end
endlocal

:: <<<<<<< Script by Overthinker [Discord: thinka.] >>>>>>>
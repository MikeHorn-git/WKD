@echo off
call "W:\build\SetupBuildEnv.cmd"
cd %USERPROFILE%
git clone https://github.com/novafacing/HackSysExtremeVulnerableDriver
cd HackSysExtremeVulnerableDriver/Driver
cmake -S . -B build -DKITS_ROOT="W:\Program Files\Windows Kits\10"
cmake --build build --config Release
certutil -p Passw0rd! -importPFX HEVD\Windows\HEVD.pfx
bcdedit -set TESTSIGNING on
bcdedit -set loadoptions DISABLE_INTEGRITY_CHECKS
cd "%USERPROFILE%\HackSysExtremeVulnerableDriver\Driver\build\HEVD\Windows\"
sc create HEVD type= kernel binPath= "HEVD.sys"

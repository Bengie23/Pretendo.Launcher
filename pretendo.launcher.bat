@echo off
title Pretendo Launcher!
echo "--------------------------------------"!

echo "-         Launching Pretendo         -"!

echo "--------------------------------------"!

echo "--------------------------------------"!

echo "--------------------------------------"!

echo "--------------------------------------"!

echo "--------------------------------------"!

echo "--------------------------------------"!

echo "--------------------------------------"!

echo "--------------------------------------"!

echo "--------------------------------------"!

echo "-         Launching Backend          -"!

echo "--------------------------------------"!
@REM Powershell.exe -ExecutionPolicy Bypass -File backend.launcher.ps1 //functiona en la misma ventana
@REM powershell -NoExit -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -Verb RunAs powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File backend.launcher.ps1'"
start /min Powershell.exe -NoProfile -ExecutionPolicy Bypass -File backend.launcher.ps1
echo "--------------------------------------"!

echo "--------------------------------------"!

echo "--------------------------------------"!

echo "--------------------------------------"!

echo "--------------------------------------"!

echo "--------------------------------------"!

echo "--------------------------------------"!

echo "--------------------------------------"!

echo "-         Launching Frontend         -"!

echo "--------------------------------------"!
start /min Powershell.exe -NoProfile -ExecutionPolicy Bypass -File frontend.launcher.ps1

echo "--------------------------------------"!

echo "Pretendo App should pop up shortly... "!

echo "--------------------------------------"!
echo "If nothing popped, make sure to run this .bat as Admin"
pause
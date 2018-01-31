@echo off
powershell -ExecutionPolicy Bypass -Command %~dp0\init.ps1
set PATH=%~dp0.tools;%~dp0.tools\VSS.NuGet.AuthHelper;%PATH%

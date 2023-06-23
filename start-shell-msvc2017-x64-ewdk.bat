@ECHO OFF

SET MOZ_MSVCBITS=64
SET MOZ_MSVCVERSION=14
SET MOZ_MSVCYEAR=2017

REM Switch CWD to the current location so that the call to start.shell-bat
REM doesn't fail if invoked from a different location.
pushd "%~dp0"

SET EWDKROOT=C:\EWDK
SET VCINSTALLDIR=%EWDKROOT%\Program Files\Microsoft Visual Studio\2017\BuildTools\VC
SET VCROOTDIR=%VCINSTALLDIR%\Tools\MSVC\14.13.26128

SET WKITDIR=%EWDKROOT%\Program Files\Windows Kits\10

SET VCREDISTDIR=%VCINSTALLDIR%\Redist\MSVC\14.13.26020
SET VCHOST=x64
SET VCTARGET=x64

SET MOZILLABUILD=%~dp0
SET MOZ_TOOLS=%MOZILLABUILD%moztools
SET INCLUDE=%VCROOTDIR%\include;%WKITDIR%\Include\10.0.16299.0\shared;%WKITDIR%\Include\10.0.16299.0\um;%WKITDIR%\Include\10.0.16299.0\winrt;%WKITDIR%\Include\10.0.16299.0\ucrt
SET LIB=%VCROOTDIR%\lib\%VCTARGET%;%WKITDIR%\Lib\10.0.16299.0\um\%VCTARGET%;%WKITDIR%\Lib\10.0.16299.0\ucrt\%VCTARGET%
SET PATH=%VCROOTDIR%\bin\Host%VCHOST%\%VCTARGET%;%VCROOTDIR%\bin\Host%VCHOST%\%VCHOST%;%WKITDIR%\bin\10.0.16299.0\%VCTARGET%;%PATH%

SET CC=%VCROOTDIR%\bin\Host%VCHOST%\%VCTARGET%\cl.exe
SET LD=%VCROOTDIR%\bin\Host%VCHOST%\%VCTARGET%\link.exe
SET AR=%VCROOTDIR%\bin\Host%VCHOST%\%VCTARGET%\lib.exe
REM SET ML=%VCROOTDIR%\bin\Host%VCHOST%\%VCTARGET%\ml.exe
REM SET MT=%VCROOTDIR%\bin\Host%VCHOST%\%VCTARGET%\mt.exe

REM Don't mis-detect VC2015
SET VS140COMNTOOLS=

REM get short path
for /f "delims=" %%i in ("%CC%") do set CC=%%~si
for /f "delims=" %%i in ("%LD%") do set LD=%%~si
for /f "delims=" %%i in ("%AR%") do set AR=%%~si
REM for /f "delims=" %%i in ("%ML%") do set ML=%%~si
REM for /f "delims=" %%i in ("%MT%") do set MT=%%~si

REM translate path seprartor
for /f "delims=" %%i in ('%~dp0minitr \ / %CC%') do set CC=%%i
for /f "delims=" %%i in ('%~dp0minitr \ / %LD%') do set LD=%%i
for /f "delims=" %%i in ('%~dp0minitr \ / %AR%') do set AR=%%i
REM for /f "delims=" %%i in ('%~dp0minitr \ / %ML%') do set ML=%%i
REM for /f "delims=" %%i in ('%~dp0minitr \ / %MT%') do set MT=%%i

%MOZILLABUILD%msys\bin\bash --login -i

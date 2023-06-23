@ECHO OFF

SET MOZ_MSVCBITS=64
SET MOZ_MSVCVERSION=14
SET MOZ_MSVCYEAR=2017
SET MOZ_NOAUTORUN=1
SET MOZ_NO_RESET_PATH=1

REM Switch CWD to the current location so that the call to start.shell-bat
REM doesn't fail if invoked from a different location.
pushd "%~dp0"

CALL "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat" amd64 -vcvars_ver=14.16

set LIB=%LIB%;C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\DIA SDK\lib\amd64
set INCLUDE=%INCLUDE%;C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\DIA SDK\include

for /f "delims==" %%i in ('%~dp0whereis.bat link.exe') do set LD=%%i
for /f "delims==" %%i in ('%~dp0whereis.bat cl.exe') do set CC=%%i
for /f "delims==" %%i in ('%~dp0whereis.bat lib.exe') do set AR=%%i

REM Don't mis-detect VC2015
SET VS140COMNTOOLS=

REM get short path
for /f "delims=" %%i in ("%CC%") do set CC=%%~si
for /f "delims=" %%i in ("%LD%") do set LD=%%~si
for /f "delims=" %%i in ("%AR%") do set AR=%%~si

REM translate path seprartor
for /f "delims=" %%i in ('%~dp0minitr \ / %CC%') do set CC=%%i
for /f "delims=" %%i in ('%~dp0minitr \ / %LD%') do set LD=%%i
for /f "delims=" %%i in ('%~dp0minitr \ / %AR%') do set AR=%%i

CALL start-shell.bat

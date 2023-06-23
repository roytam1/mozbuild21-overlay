@echo off
for %%i in (%1) do echo %%~dp$PATH:i%%i

:: clean temp system files

@echo off
setlocal
call :Clear_Folder %SystemRoot%\TEMP
pushd C:\Users
for /d %%k in (*) do if exist "%%k\AppData\Local\Temp" call :Clear_Folder "%%k\AppData\Local\Temp"
popd
endlocal
goto :EOF

:: Clear_Folder
pushd "%~1"
for /d %%i in (*) do rd /s /q "%%i"
del /f /q *
popd
goto :EOF
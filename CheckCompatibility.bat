@echo off
setlocal

echo Looking for js file...
tree /f /a
for %%F in (src\hbui\*.js) do (
    echo Found %%~nxF
    set "currentFileName=%%~nxF"
)

echo Extracting appx...
7z x mcappx.zip -otmp

echo Checking compatibility...
if exist "tmp\data\gui\dist\hbui\%currentFileName%" (
    echo Compatible with %2
    >tmp\compatibility-status.json echo {"schemaVersion":1,"label":"%2","message":"Supported","color":"green"}
    set exitCode=0
) else (
    echo Incompatible with %2
    >tmp\compatibility-status.json echo {"schemaVersion":1,"label":"%2","message":"Not supported, needs update","color":"red"}
    exit /b 6
)
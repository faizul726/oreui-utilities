@echo off
setlocal

echo Looking for js file...
for %%F in ("src\hbui\*.js") do (
    echo [*] Found %%~nxF
    set "currentFileName=%%~nxF"
)

echo Extracting appx...
if not exist mcappx.zip (exit /b 1)
7z x mcappx.zip -otmp

echo Checking compatibility...
if exist "tmp\data\gui\dist\hbui\%currentFileName%" (
    echo Compatible with %1
    >tmp\compatibility-status.json echo {"schemaVersion":1,"label":"%1","message":"Supported","color":"brightgreen"}
) else (
    echo Incompatible with %1
    >tmp\compatibility-status.json echo {"schemaVersion":1,"label":"%1","message":"Not supported, needs update","color":"red"}
    echo ntg>failure

)

@echo off
setlocal

mkdir tmp
git fetch origin
git worktree add tmp gh-pages

echo Looking for js file...
tree /f /a
for %%F in ("src\hbui\*.js") do (
    echo Found %%~nxF
    set "currentFileName=%%~nxF"
)

echo Downloading appx...
echo curl -L %1 -o mcappx.zip
curl -L %1 -o mcappx.zip

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
    set exitCode=6
)

git add tmp\compatibility-status.json
git commit -m "Compatibility check"
git push origin gh-pages

exit %exitCode%
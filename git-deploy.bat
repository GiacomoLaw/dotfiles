:: deploy to github with commit message

@echo off
set /p desc = "Commit message: "
git add .
git add -u
git commit -m %desc%
git push origin master
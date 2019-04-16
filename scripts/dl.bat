:: init mp3 youtube download

@echo off
set /p url="URL: "
youtube-dl --extract-audio --audio-format mp3 %url%

Invoke-WebRequest -Uri "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v7.9.1/npp.7.9.1.Installer.exe" -OutFile "D:\notepadplusplus.exe"


Start-Process -FilePath "D:\notepadplusplus.exe" 




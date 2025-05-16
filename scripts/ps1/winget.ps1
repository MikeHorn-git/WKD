Install-PackageProvider -Name Nuget -Force
Install-Script winget-install -Force
winget-install -Force
winget source remove msstore
winget source update

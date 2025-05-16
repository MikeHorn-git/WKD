winget install --id Kitware.CMake --source winget
winget install --id Git.Git --source winget
winget install --id vim.vim --source winget --accept-source-agreements

winget install Microsoft.WindowsTerminal
winget install Microsoft.VisualStudio.2022.Community --silent --override "--wait --quiet --addProductLang En-us --add Microsoft.VisualStudio.Workload.NativeDesktop --add Microsoft.VisualStudio.Component.VC.ASAN --add Microsoft.VisualStudio.Component.VC.ATL --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 --add Microsoft.VisualStudio.Component.Windows11SDK.22621 --add Microsoft.Component.VC.Runtime.UCRTSDK --add Microsoft.VisualStudio.Workload.CoreEditor"

$pathToAdd = ";C:\Program Files\CMake\bin;C:\Program Files\Git\bin;C:\Program Files\Vim\vim91"
[Environment]::SetEnvironmentVariable("Path", $env:Path + $pathToAdd, "Machine")

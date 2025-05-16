# Enable Auto-logon
$Username = "vagrant"
$Pass = "vagrant"
$RegistryPath = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon'
Set-ItemProperty $RegistryPath 'AutoAdminLogon' -Value "1" -Type String 
Set-ItemProperty $RegistryPath 'DefaultUsername' -Value $Username -type String 
Set-ItemProperty $RegistryPath 'DefaultPassword' -Value $Pass -type String

# Download Enterprise Windows Driver Kit (EWDK)
$ISO = "EWDK_ge_release_svc_prod3_26100_250220-1537.iso"
$LocalPath = "C:\$ISO"
$LinkEWDK = "https://software-static.download.prss.microsoft.com/dbazure/998969d5-f34g-4e03-ac9d-1f9786c66749/$ISO"

if (-Not (Test-Path $LocalPath)) {
    $wc = New-Object net.webclient
    $wc.DownloadFile($LinkEWDK, $LocalPath)
    Write-Host "File downloaded."
} else {
    Write-Host "File already exists locally."
}

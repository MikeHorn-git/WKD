$ISO = "C:\EWDK_ge_release_svc_prod3_26100_250220-1537.iso"
$diskImage = Mount-DiskImage -ImagePath $ISO -NoDriveLetter
$volumeInfo = Get-Volume -DiskImage $diskImage
mountvol W: $volumeInfo.UniqueId

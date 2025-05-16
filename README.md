# Description

A [Windows Kernel](https://learn.microsoft.com/en-us/windows-hardware/drivers/ddi/_kernel/) developer environments.

## Plugins

```bash
VAGRANT_DISABLE_STRICT_DEPENDENCY_ENFORCEMENT=1 vagrant plugin install vagrant-reload
```

## Images

* Windows 11 Enterprise

## Providers

* Virtualbox

---

## Build

```bash
git clone https://github.com/MikeHorn-git/WKD
cd WKD
```

## Vagrant Provisionning

### Default

```bash
vagrant up
```

#### `setup.ps1`

* Enables automatic logon
* Downloads the Enterprise Windows Driver Kit (EWDK)

#### `winget.ps1`

* Install Winget
* Removes the Microsoft Store source
* Update Winget sources

#### `tools.ps1`

* **CMake**
* **Git**
* **Vim**
* **Windows Terminal**
* **Visual Studio 2022 Community Edition**

### VAGRANT_FUZZER

#### `mount.ps1`

* Mounts the **EWDK ISO** as a virtual disk
* Assigns it to the `W:` drive using `mountvol`

#### `hevd.bat`

* Launches the EWDK build environment
* Download [HackSysExtremeVulnerableDriver](https://github.com/novafacing/HackSysExtremeVulnerableDriver)
* Build [HackSysExtremeVulnerableDriver](https://github.com/novafacing/HackSysExtremeVulnerableDriver)
* Imports the test certificate for driver signing
* Enables **test signing** and disables **driver signature enforcement**
* Registers the HEVD driver as a kernel service

#### `start.bat`

* Launches the Visual Studio Developer Command Prompt
* Starts the HEVD driver service
* Compiles `fuzzer.c` using LLVM sanitizers:
   * `fuzzer`, `coverage=edge`, `trace-cmp`, `trace-div`

```bash
VAGRANT_FUZZER=true vagrant up
```

---

## Fuzzer

This fuzzer sends arbitrary input to ```HEVD``` using a vulnerable IOCTL to trigger and detect kernel stack overflows.

### Run

```pwsh
cd C:\fuzzer
./fuzzer.exe -len_control=0
```

## Credits

* [Practical Fuzzing](https://novafacing.github.io/practical-fuzzing/libfuzzer/kernel/windows/index.html)

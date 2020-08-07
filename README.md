# Setup Script

Simple scripts to setup my personal macOS machines, includes:

* Homebrew setup
* 3rd party app installs(via CASK)
* AppStore installs(via MAS)
* Installing CorpNewt's scripts
* Misc settings


## Install

```sh
git clone https://github.com/khronokernel/System-Setup
cd System-Setup
chmod +x setup-script.sh
chmod +x HiDPI-Fixup.sh

## Basic setup, all my machines have the same settings
setup-script.sh

## Enables HiDPI on my HP Elite X2 G1
HiDPI-Fixup.sh
```

## TO-DO

* Adjust screensaver
  * Pabbury Clock
    * Theme: Dark
    * Show on Main Display Only
* Arrange menubar items
* Set HiDPI scale to 1440p on both monitors
* set monitor arrangement
* Check SMBIOS type, and determine if CoconutBattery should be installed
  * Format = `%ww %r %p%`

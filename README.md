Codestarter installer for Ubuntu on Chromebooks
===============================================

This script will install everything necessary to transform an Acer C720 into a
Codestarter laptop. Primarily this involves partitioning the built-in SSD and
installing Ubuntu along with various patches and Codestarter customizations.

Upon completion, you will be able to boot into both ChromeOS (CTRL-D) or Ubuntu
(CTRL-L) from the developer mode boot screen.

For more back story on why we chose the Acer C720 and some of the Codestarter
customizations, see our blog post at http://bit.ly/X24d9r.

Supported device(s)
-------------------

* Acer C720 Chromebook

Prerequisites
-------------

* A Chromebook listed in the supported device(s) section
* A recovery image for your Chromebook in case something goes wrong. In order to achieve that, go to [chrome://imageburner](chrome://imageburner), on your Chromebook, and follow the instructions
* Chromebook in developer mode
* An external media of at least 1GB (USB Flash drive or SD Card)
* Patience

Usage
-----

**ATTENTION: This will wipe everything on your device**

1. Enable [developer mode](http://www.chromium.org/chromium-os/developer-information-for-chrome-os-devices/acer-c720-chromebook).
2. Download the [latest version of this installer](https://github.com/codestarterorg/ubuntu-chromebook-installer/archive/master.zip) and extract it to a removable media
3. Boot into ChromeOS, connect to a wireless network and log in as guest
4. Open a shell (CTRL + ALT + t) and type `shell`
5. From the shell go to the location of the script on the removable media `cd /media/removable/` and press **[TAB] [TAB]** on your keyboard to show and auto-complete your removable media path automatically
6. Run the script with `sudo bash main.sh`
7. On the first run you will be asked how much storage space you want to dedicate to Ubuntu. We suggest choosing the default.
8. After the first run, your system will reboot to complete the initial formatting.  (NOTICE: You must remove your removeable media before reboot).
9. Reinsert the media and re-run the script (steps 3-6) to complete the installation process
9. Follow the prompt to complete the installation
10. After the installation is completed and the Chromebook has rebooted, press CTRL+L to boot into Ubuntu
11. On first boot you will be asked to complete your system configuration (Language, Time zone, Computer name) and create a user account

Credit(s)
---------

* The [Ubuntu](http://ubuntu.com/) development team for creating this awesome Linux distribution
* Parimal Satyal for making a [guide](http://realityequation.net/installing-elementary-os-on-an-hp-chromebook-14) on how to install Ubuntu on the HP Chromebook 14
* Jay Lee for creating [ChrUbuntu](http://chromeos-cr48.blogspot.ca/) from which I use a modified version
* SuccessInCircuit on reddit for making a [guide](http://www.reddit.com/r/chrubuntu/comments/1rsxkd/list_of_fixes_for_xubuntu_1310_on_the_acer_c720/) on how to fix mostly everything with the Acer C720
* Benson Leung for his [cros-haswell-modules](https://googledrive.com/host/0B0YvUuHHn3MndlNDbXhPRlB2eFE/cros-haswell-modules.sh) script
* [Quatral Solutions](http://www.quatral.com) for providing the Acer C720 Chromebook
* Jesus Lopez - Thanks for helping testing ChromeeOS for the Asus Chromebox
* Jonathan Frank (Setsuna666) for creating Chromeeos and the Acer C720 profile
* Everyone who contributed
* Kevin Whitaker for c720p patches and Ubuntu specific changes from elementary OS

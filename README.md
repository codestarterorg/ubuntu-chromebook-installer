Codestarter installer for Ubuntu on Chromebooks
===============================================

This script will install everything necessary to transform an Acer C720 into a
Codestarter laptop. Primarily this involves partitioning the built-in SSD and
installing Ubuntu along with various patches and Codestarter customizations.

Upon completion, you will be able to boot into both ChromeOS (**ctrl + d**) or
Ubuntu (**ctrl + l**) from the developer mode boot screen.

For more back story on why we chose the Acer C720 and some of the Codestarter
customizations, see our blog post at
[http://blog.codestarter.org/how-we-turn-199-chromebooks-into-ubuntu-based/](http://blog.codestarter.org/how-we-turn-199-chromebooks-into-ubuntu-based/).

Supported device(s)
-------------------

* Acer C720 Chromebook

Prerequisites
-------------

* A Chromebook listed in the supported device(s) section.
* A recovery image for your Chromebook in case something goes wrong. In order to
  achieve that, go to [chrome://imageburner](chrome://imageburner), on your
  Chromebook, and follow the instructions.
* An external media of at least 1GB (USB Flash drive or SD Card).
* Patience.

Install
-------

**ATTENTION: This will wipe everything on your device**

### Copy the Installer to a USB Drive

1. Download the [latest version of this installer](https://github.com/codestarterorg/ubuntu-chromebook-installer/archive/master.zip)
   and extract it to your USB drive.

### Enable Developer Mode

1. Brand new Chromebooks need to be plugged in the first time they are used, so
   go ahead an do that now. Then open up the laptop.
1. As soon as you see the ChromeOS boot screen, hit **esc + refresh + power**
   (all three buttons are on the top row of keys; refresh is the 4th button from
   the left). Laptop will reboot.
1. You will see a scary white screen. Hit **ctrl + d**.
1. The text on the screen will change. Hit **enter**. Laptop will reboot.
1. Hit **ctrl + d** again. It will now transition to developer mode, which takes
   about a minute. When done, it will reboot.
1. On boot, your laptop will now always show a scary white screen that says
   "OS verification is OFF". Hit **ctrl + d** to boot to ChromeOS (or wait 30
   seconds and it will boot to ChromeOS by default).

Read more about
[developer mode](http://www.chromium.org/chromium-os/developer-information-for-chrome-os-devices/acer-c720-chromebook).

### Run the Codestarter Script (Stage One)

1. Once ChromeOS boots, connect to your wireless network and select
   **Continue**.
1. Select **Accept and continue**.
1. On the login screen, select **browse as Guest** in the right sidebar.
1. Open a crosh shell by hitting **ctrl + alt + t**. A black browser window
   should open.
1. Type `shell` and hit **enter**. The prompt should turn green.
1. Insert the Codestarter USB drive. A window should pop up with the contents.
1. Switch back to the shell window.
1. Go to the location of the script on the removable media by typing:
   `cd /media/removable/`, then press **tab tab** on your keyboard to show and
   auto-complete your removable media path automatically, then type
   `ubuntu-chromebook-installer-master/`. In all, it should look something like
   this: `cd /media/removable/USBDRIVE/ubuntu-chromebook-installer-master/`. Hit
   **enter**.
1. Type `sudo bash main.sh` and hit **enter**.
1. You will be asked how much storage space you want to dedicate to Ubuntu. We
   suggest entering `10` if you don't plan to use ChromeOS much. Hit **enter**.
1. The script will partition your drive and reboot after ten seconds.
1. After reboot, you'll see a white screen with: "Your system is repairing
   itself". This is normal, and should only last a few seconds. Then your laptop
   will reboot again. Once it does, hit **ctrl + d** to boot to ChromeOS.

### Run the Codestarter Script (Stage Two)

NOTE: Most of this step will look the same as the previous, as we are just
re-running the installation script. It knows how to finish the job.

1. Once ChromeOS boots, connect to your wireless network and select
   **Continue**.
1. Select **Accept and continue**.
1. On the login screen, select **browse as Guest** in the right sidebar.
1. Open a crosh shell by hitting **ctrl + alt + t**. A black browser window
   should open.
1. Type `shell` and hit **enter**. The prompt should turn green.
1. Go to the location of the script on the removable media by typing:
   `cd /media/removable/`, then press **tab tab** on your keyboard to show and
   auto-complete your removable media path automatically, then type
   `ubuntu-chromebook-installer-master/`. In all, it should look something like this:
   `cd /media/removable/USBDRIVE/ubuntu-chromebook-installer-master/`. Hit **enter**.
1. Type `sudo bash main.sh` and hit **enter**.
1. Now would be a good time to plug in your laptop, if it isn't already.
1. The script will finish the installation, which may take up to an hour (or
   more if you have a slow internet connection). It is fully automated, and you
   can safely step away while it installs. If your network drops out during the
   installation, you will need to reboot your laptop and redo this stage, except
   run `sudo bash main.sh -n` instead of the previously stated command (this will
   skip the partition phase, as that has already been done).
1. When the script finishes, it will ask you to hit [ENTER], so hit **enter**.

### Use your new Codestarter laptop!

1. When your laptop reboots, hit **ctrl + l** to boot into Linux. You can also
   hit **ctrl + d** to boot into ChromeOS (or wait 30 seconds and it will boot
   to ChromeOS by default).
1. On your first boot to Linux you will be asked to complete your system
   configuration (language, time zone, computer name) and create a user account.
1. Congrats, you're done!
1. BONUS: For a nicer experience, you can set up your machine to
   [boot to Ubuntu by default](https://gist.github.com/mojombo/7c873f457df6abee5717).

### Optional Stuff

* If you are doing more than one installation, you can save a ton of time by
  pre-downloading the Ubuntu installation files. Simply download
  [ubuntu_system.tar.gz](https://s3-us-west-1.amazonaws.com/mojombo-codestarter/ubuntu_system.tar.gz)
  and place it next to the Codestarter installation directory on your USB drive.
  Now when you run the script, it will use this local file instead of trying to
  download it every time!
* Replace OpenDNS. For example, to use Google DNS, edit `/etc/resolv.conf`:
    nameserver 8.8.8.8
    nameserver 8.8.4.4 

Reinstall
---------

If you need to reinstall Ubuntu on your Codestarter laptop, these instructions
will get you there.

**ATTENTION: This will wipe everything on your device**

### Copy the Installer to a USB Drive

1. Download the [latest version of this installer](https://github.com/codestarterorg/ubuntu-chromebook-installer/archive/master.zip)
   and extract it to your USB drive (with at least 1GB of free space).

### Run the Codestarter Script

1. Reboot your laptop and as soon as you see the white screen, hit **ctrl + d**.
1. Once ChromeOS boots, login and make sure you're connected to the internet.
   It's ok to select **browse as Guest** in the right sidebar if you don't
   want to login with your Google account.
1. Open a crosh shell by hitting **ctrl + alt + t**. A black browser window
  should open.
1. Type `shell` and hit **enter**. The prompt should turn green.
1. Go to the location of the script on the removable media by typing:
   `cd /media/removable/`, then press **tab tab** on your keyboard to show and
   auto-complete your removable media path automatically, then type
   `ubuntu-chromebook-installer-master/`. In all, it should look something like
   this: `cd /media/removable/USBDRIVE/ubuntu-chromebook-installer-master/`. Hit
   **enter**.
1. Now would be a good time to plug in your laptop, if it isn't already.
1. You may be asked to confirm that you want to write to an existing partition.
   If so, answer **yes**.
1. The script will finish the installation, which may take up to an hour (or
  more if you have a slow internet connection). It is fully automated, and you
  can safely step away while it installs. If your network drops out during the
  installation, you will need to reboot your laptop and redo the reinstallation.
1. When the script finishes, it will ask you to hit [ENTER], so hit **enter**.

### Use your new Codestarter laptop!

1. When your laptop reboots, hit **ctrl + l** to boot into Linux.
1. On your first boot to Linux you will be asked to complete your system
  configuration (language, time zone, computer name) and create a user account.
1. Congrats, you're done!

### If by chance you hit the space bar on the OS verification screen

1. Don't panic, you have reverted only your Chrome OS. The linux partition is still intact!
1. Re-enable developer mode as before (instructions above)
1. Reboot and instead of logging on with your password instead press **ctl + alt + ->**  (the forward button)
1. logon as chronos
1. type the following to re-enable linux boot **sudo crossystem dev_boot_usb=1 dev_boot_legacy=1** press enter
1. type **sudo reboot**   (you should now be able to press **ctrl + l** to boot into Linux.)

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

#elementary OS device profile for the Acer C720 Chromebook

#Devices hardware
system_drive="/dev/sda"
system_partition="${system_drive}7"

#Specify the swap file size and unit (ex: 2048M or 2G)
swap_file_size="2G"

#Define additional PPA and packages to install

#Kernel package(s) to install
#Add kernel ppa for this device (Not available yet)
#additional_kernel_ppa=""
#Add kernel packages from a PPA (Not available yet)
#kernel_ppa_pkgs=""

#Add kernel packages from URL
#Changed kernel source from mainlaine to Ubuntu official repository and version from 3.12.5 to 3.13, since this is the one that will be used in 14.04
#kernel_url_pkgs="http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.12.5-trusty/linux-headers-3.12.5-031205-generic_3.12.5-031205.201312120254_amd64.deb http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.12.5-trusty/linux-headers-3.12.5-031205_3.12.5-031205.201312120254_all.deb http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.12.5-trusty/linux-image-3.12.5-031205-generic_3.12.5-031205.201312120254_amd64.deb"
#kernel_url_pkgs="http://us.archive.ubuntu.com/ubuntu/ubuntu/ubuntu/pool/main/l/linux/linux-image-3.13.0-5-generic_3.13.0-5.20_amd64.deb http://us.archive.ubuntu.com/ubuntu/ubuntu/ubuntu/pool/main/l/linux/linux-headers-3.13.0-5-generic_3.13.0-5.20_amd64.deb http://us.archive.ubuntu.com/ubuntu/ubuntu/ubuntu/pool/main/l/linux/linux-headers-3.13.0-5_3.13.0-5.20_all.deb"

#Additional repository(ies) and package(s) to install
#Add additional PPA (Not available yet)
#additional_ppa=""

#Add packages from an URL (Not available yet)
#url_pkgs="${kernel_url_pkgs}"

#Add packages from a PPA
ppa_pkgs="xserver-xorg-core xbindkeys xdotool xbacklight"

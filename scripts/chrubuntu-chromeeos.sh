echo_red()
{
echo -e "\E[1;31m$1"
echo -e '\e[0m'
}

echo_green()
{
echo -e "\E[1;32m$1"
echo -e '\e[0m'
}

echo_yellow()
{
echo -e "\E[1;33m$1"
echo -e '\e[0m'
}

target_disk=""

echo_green "Determining support for legacy boot..."
LEGACY_LOCATION="`mosys -k eeprom map | grep RW_LEGACY`"
if [ "${LEGACY_LOCATION}" = "" ]; then
  echo_red "Error: this Chrome device does not seem to support CTRL+L Legacy SeaBIOS booting. Use the old ChrUbuntu script please..."
  exit 1
fi
echo_green "This system supports legacy boot. Good."

powerd_status="`initctl status powerd`"
if [ ! "${powerd_status}" = "powerd stop/waiting" ]
then
  echo_green "Stopping powerd to keep display from timing out..."
  initctl stop powerd
fi

setterm -blank 0

target_disk="`rootdev -d -s`"
# Do partitioning (if we haven't already)
ckern_size="`cgpt show -i 6 -n -s -q ${target_disk}`"
croot_size="`cgpt show -i 7 -n -s -q ${target_disk}`"
state_size="`cgpt show -i 1 -n -s -q ${target_disk}`"

max_ubuntu_size=$((${state_size}/1024/1024/2))
rec_ubuntu_size=$((${max_ubuntu_size} - 1))
# If KERN-C and ROOT-C are one, we partition, otherwise assume they're what they need to be...
if [ "${ckern_size}" =  "1" -o "${croot_size}" = "1" ]
then
while :
do
  read -p "Enter the size in gigabytes you want to reserve for elementary OS. Acceptable range is 5 to ${max_ubuntu_size}  but ${rec_ubuntu_size} is the recommended maximum: " ubuntu_size
  if [ ! ${ubuntu_size} -ne 0 2>/dev/null ]
  then
    echo_red "\n\nNumbers only please...\n\n"
    continue
  fi
  if [ ${ubuntu_size} -lt 5 -o ${ubuntu_size} -gt ${max_ubuntu_size} ]
  then
    echo_red "\n\nThat number is out of range. Enter a number 5 through ${max_ubuntu_size}\n\n"
    continue
  fi
  break
done
# We've got our size in GB for ROOT-C so do the math...

#calculate sector size for rootc
rootc_size=$((${ubuntu_size}*1024*1024*2))

#kernc is always 16mb
kernc_size=32768

#new stateful size with rootc and kernc subtracted from original
stateful_size=$((${state_size} - ${rootc_size} - ${kernc_size}))

#start stateful at the same spot it currently starts at
stateful_start="`cgpt show -i 1 -n -b -q ${target_disk}`"

#start kernc at stateful start plus stateful size
kernc_start=$((${stateful_start} + ${stateful_size}))

#start rootc at kernc start plus kernc size
rootc_start=$((${kernc_start} + ${kernc_size}))

#Do the real work

echo_green "\n\nModifying partition table to make room for Ubuntu." 
echo_green "Your Chromebook will reboot, wipe your data and then"
echo_green "you should re-run this script..."
umount -f /mnt/stateful_partition

# stateful first
cgpt add -i 1 -b ${stateful_start} -s ${stateful_size} -l STATE ${target_disk}

# now kernc
cgpt add -i 6 -b ${kernc_start} -s ${kernc_size} -l KERN-C -t "kernel" ${target_disk}

# finally rootc
cgpt add -i 7 -b ${rootc_start} -s ${rootc_size} -l ROOT-C ${target_disk}

#reboot
exit
fi

# hwid lets us know if this is a Mario (Cr-48), Alex (Samsung Series 5), ZGB (Acer), etc
hwid="`crossystem hwid`"

if [[ "${target_disk}" =~ "mmcblk" ]]
then
  target_rootfs="${target_disk}p7"
  target_kern="${target_disk}p6"
else
  target_rootfs="${target_disk}7"
  target_kern="${target_disk}6"
fi

if mount|grep ${target_rootfs}
then
  echo_red "Refusing to continue since ${target_rootfs} is formatted and mounted. Try rebooting"
  exit 
fi

mkfs.ext4 ${target_rootfs}

if [ ! -d /tmp/urfs ]
then
  mkdir /tmp/urfs
fi
mount -t ext4 ${target_rootfs} /tmp/urfs

mkdir -p /tmp/urfs/usr/bin/
if [ -f /usr/bin/old_bins/cgpt ]
then
  cp /usr/bin/old_bins/cgpt /tmp/urfs/usr/bin/
else
  cp /usr/bin/cgpt /tmp/urfs/usr/bin/
fi

chmod a+rx /tmp/urfs/usr/bin/cgpt
crossystem dev_boot_legacy=1 dev_boot_signed_only=1

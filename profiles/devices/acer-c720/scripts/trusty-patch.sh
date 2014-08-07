# Create a temp directory for our work
tempbuild="$(mktemp -d)"
cd "${tempbuild}"

# Determine kernel version (with and without Ubuntu-specific suffix)
#mykern=${1:-$(uname -r)}
#mykern=$(uname -r)
mykern=$(python << END
import re,sys

txt="`apt-cache show linux-image-generic | grep Depends |head -1`"

re1='.*?'	# Non-greedy match on filler
re2='(\\d+)'	# Integer Number 1
re3='(.)'	# Any Single Character 1
re4='(\\d+)'	# Integer Number 2
re5='(.)'	# Any Single Character 2
re6='(\\d+)'	# Integer Number 3
re7='([-+]\\d+)'	# Integer Number 1
re8='(.)'	# Any Single Character 3
re9='((?:[a-z][a-z]+))'	# Word 1

rg = re.compile(re1+re2+re3+re4+re5+re6+re7+re8+re9,re.IGNORECASE|re.DOTALL)
m = rg.search(txt)
if m:
    int1=m.group(1)
    c1=m.group(2)
    int2=m.group(3)
    c2=m.group(4)
    int3=m.group(5)
    signed_int1=m.group(6)
    c3=m.group(7)
    word1=m.group(8)
    print int1+c1+int2+c2+int3+signed_int1+c3+word1
END
)
#mykern=3.13.0-23-generic
mykernver="linux-$(echo ${mykern} | cut -d'-' -f 1)"


# Install necessary deps to build a kernel
sudo apt-get build-dep -y --no-install-recommends "linux-image-${mykern}"

# Grab Ubuntu kernel source
apt-get source "linux-image-${mykern}"
cd "${mykernver}"

if [ -f drivers/platform/x86/chromeos_laptop.c ]; then
  platform_folder=x86
elif [ -f drivers/platform/chrome/chromeos_laptop.c ]; then
  platform_folder=chrome
fi

# Use Benson Leung's post-Pixel Chromebook patches:
# https://patchwork.kernel.org/bundle/bleung/chromeos-laptop-deferring-and-haswell/
for patch in 3078491 3078481; do
  wget -O - "https://patchwork.kernel.org/patch/${patch}/raw/" | patch -p1
done

#for patch in 8759835 8759842 8759848 8759852 8759855 8759857; do
#  wget -O - "http://pastie.org/pastes/${patch}/download" | patch -p1
#done
wget -O - http://pastie.org/pastes/8878181/download | sed "s/drivers\/platform\/x86\/chromeos_laptop.c/drivers\/platform\/${platform_folder}\/chromeos_laptop.c/g" | patch -p0

# Need this
cp "/usr/src/linux-headers-${mykern}/Module.symvers" .

# Prep tree
cp "/boot/config-${mykern}" ./.config
make oldconfig
make prepare
make modules_prepare

# Build only the needed directories
make SUBDIRS="drivers/platform/${platform_folder}" modules
make SUBDIRS=drivers/i2c/busses modules

# switch to using our new chromeos_laptop.ko module
# preserve old as .orig
sudo mv "/lib/modules/${mykern}/kernel/drivers/platform/${platform_folder}/chromeos_laptop.ko" "/lib/modules/${mykern}/kernel/drivers/platform/${platform_folder}/chromeos_laptop.ko.orig"
sudo cp "drivers/platform/${platform_folder}/chromeos_laptop.ko" "/lib/modules/${mykern}/kernel/drivers/platform/${platform_folder}/"

# switch to using our new designware i2c modules
# preserve old as .orig
sudo mv "/lib/modules/${mykern}/kernel/drivers/i2c/busses/i2c-designware-core.ko" "/lib/modules/${mykern}/kernel/drivers/i2c/busses/i2c-designware-core.ko.orig"
sudo mv "/lib/modules/${mykern}/kernel/drivers/i2c/busses/i2c-designware-pci.ko" "/lib/modules/${mykern}/kernel/drivers/i2c/busses/i2c-designware-pci.ko.orig"
sudo mv "/lib/modules/${mykern}/kernel/drivers/i2c/busses/i2c-designware-platform.ko" "/lib/modules/${mykern}/kernel/drivers/i2c/busses/i2c-designware-platform.ko.orig"
sudo cp drivers/i2c/busses/i2c-designware-*.ko "/lib/modules/${mykern}/kernel/drivers/i2c/busses/"
sudo depmod -a ${mykern}
echo "Finished building Chromebook modules in ${tempbuild}. Reboot to use them."

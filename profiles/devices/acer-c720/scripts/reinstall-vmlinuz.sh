sudo rm /initrd.img /vmlinuz
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
mykernver="$(echo ${mykern} | cut -d'-' -f 1-2)"

echo "Installing latest kernel packages"
sudo apt-get install -y linux-generic linux-signed-generic

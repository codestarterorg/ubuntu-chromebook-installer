# This script customizes the Acer C720 with Codestarter-specific programs and
# settings. The 'x' that prefixes the script name ensures that this is the last
# device script to be run.

# Create a temp directory for our work
tempbuild=`mktemp -d`

echo "Installing Chrome"
cd $tempbuild
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome-stable_current_amd64.deb
export DEBIAN_FRONTEND=noninteractive; apt-get -f -y -q install
touch "chrome.done"

echo "Installing Scratch"
cd $tempbuild
export DEBIAN_FRONTEND=noninteractive; apt-get -y -q install scratch
touch "scratch.done"

echo "Installing Sublime Text 3"
cd $tempbuild
wget http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3059_amd64.deb
dpkg -i sublime-text_build-3059_amd64.deb
touch "sublime.done"

echo "Installing Vim"
cd $tempbuild
export DEBIAN_FRONTEND=noninteractive; apt-get -y -q install vim
touch "vim.done"

echo "Installing Emacs"
cd $tempbuild
export DEBIAN_FRONTEND=noninteractive; apt-get -y -q install emacs
touch "emacs.done"

echo "Installing ruby-install"
cd $tempbuild
wget -O ruby-install-0.4.3.tar.gz https://github.com/postmodern/ruby-install/archive/v0.4.3.tar.gz
tar -xzf ruby-install-0.4.3.tar.gz
cd ruby-install-0.4.3/
make install
cd $tempbuild
touch "ruby-install.done"

echo "Installing ruby"
cd $tempbuild
ruby-install ruby 2.1.2
touch "ruby.done"

echo "Installing chruby"
cd $tempbuild
wget -O chruby-0.3.8.tar.gz https://github.com/postmodern/chruby/archive/v0.3.8.tar.gz
tar -xzf chruby-0.3.8.tar.gz
cd chruby-0.3.8/
make install
echo "" >> /etc/skel/.bashrc
echo "source '/usr/local/share/chruby/chruby.sh'" >> /etc/skel/.bashrc
echo "source '/usr/local/share/chruby/auto.sh'" >> /etc/skel/.bashrc
echo "chruby ruby-2.1.2" >> /etc/skel/.bashrc
cd $tempbuild
touch "chruby.done"

echo "Installing node.js & npm"
cd $tempbuild
export DEBIAN_FRONTEND=noninteractive; apt-get -y -q install nodejs npm
touch "nodejs.done"

echo "Installing Java"
cd $tempbuild
export DEBIAN_FRONTEND=noninteractive; apt-get -y -q install default-jdk
touch "java.done"

# Install perlbrew, for easy installation of a non system perl
# See what is http://perlbrew.pl/ for further info

echo "Installing perlbrew"
cd $tempbuild
export DEBIAN_FRONTEND=noninteractive; apt-get -y -q install perlbrew
touch "perlbrew.done"

echo "Installing Minecraft"
cd $tempbuild
export DEBIAN_FRONTEND=noninteractive; add-apt-repository -y ppa:minecraft-installer-peeps/minecraft-installer
export DEBIAN_FRONTEND=noninteractive; apt-get -y -q update
export DEBIAN_FRONTEND=noninteractive; apt-get -y -q install minecraft-installer
touch "minecraft.done"

echo "Installing Git"
cd $tempbuild
export DEBIAN_FRONTEND=noninteractive; apt-get -y -q install git
touch "git.done"

echo "Installing wallpaper"
cd $tempbuild
wget https://s3-us-west-1.amazonaws.com/mojombo-codestarter/codestarter-tree.jpg
cp codestarter-tree.jpg /usr/share/backgrounds
touch "wallpaper.done"

# These dconf overrides do the following:
# 1. Customizes the Launcher (left dock bar) to hold commonly used programs.
# 2. Sets trackpad scrolling to "natural" (same as default on OSX).
# 3. Sets the desktop background to custom Codestarter wallpaper.
echo "Installing dconf overrides"
cd $tempbuild
echo -e "[com.canonical.Unity.Launcher]\n\
\n\
favorites=['application://nautilus.desktop', 'application://google-chrome.desktop', 'application://sublime_text.desktop', 'application://gnome-terminal.desktop', 'application://minecraft.desktop', 'application://ubuntu-software-center.desktop', 'application://unity-control-center.desktop', 'unity://running-apps', 'unity://expo-icon', 'unity://devices']
\n\
[org.gnome.settings-daemon.peripherals.touchpad]\n\
\n\
natural-scroll=true\n\
\n\
[org.gnome.desktop.background]\n\
\n\
picture-uri='file:///usr/share/backgrounds/codestarter-tree.jpg'" > /usr/share/glib-2.0/schemas/codestarter.gschema.override
glib-compile-schemas /usr/share/glib-2.0/schemas/
touch "dconf-overrides.done"

# Cleanup
rm -fr /tmp/tmp.*

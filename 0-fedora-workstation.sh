#!/bin/sh

# Configure dnf (In order: automatically select fastest mirror, parallel downloads, and disable telemetry)
printf "%s" "
fastestmirror=1
max_parallel_downloads=10
" | sudo tee -a /etc/dnf/dnf.conf

# Debloat
sudo dnf remove -y cheese gnome-calendar gnome-weather gnome-clocks gnome-contacts gnome-tour gnome-logs gnome-remote-desktop gnome-maps gnome-calculator gnome-characters gnome-font-viewer gnome-shell-extension* totem mediawriter gnome-connections nano nano-default-editor gnome-user-docs gnome-color-manager eog gnome-text-editor evince rhythmbox

# Run Updates
sudo dnf autoremove -y
sudo dnf upgrade -y

# Install Firmware Updates
# sudo fwupdmgr get-devices
# sudo fwupdmgr refresh --force
# sudo fwupdmgr get-updates -y
# sudo fwupdmgr update -y

# Setup Flathub and Flatpak
# Flathub is enabled by default, but fails to install anything outside of Fedora still.
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Setup RPMFusion & Other Repos
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[microsoft-edge]\nname=Microsoft Edge\nbaseurl=https://packages.microsoft.com/yumrepos/edge/\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/microsoft-edge.repo'
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode/\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
sudo sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo'

sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/home:/mkittler/Fedora_38/home:mkittler.repo

sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/home:TheLocehiliosan:yadm/Fedora_37/home:TheLocehiliosan:yadm.repo

sudo dnf groupupdate core -y

# Install things I need

# General
flatpak install -y flathub org.libreoffice.LibreOffice com.github.tchx84.Flatseal org.bleachbit.BleachBit org.gnome.Loupe org.gnome.Evolution com.usebottles.bottles org.gnome.Calculator com.mattjakeman.ExtensionManager org.gnome.Characters org.gnome.Evince sh.cider.Cider
sudo dnf install -y 1password 1password-cli btop syncthing ulauncher microsoft-edge-stable alacritty sqlite3 zsh zsh-autosuggestions zsh-syntax-highlighting ffmpeg compat-ffmpeg4 gnome-tweaks dconf-editor bat exa yadm git syncthingtray python3-pytz --best --allowerasing

# Install Starship
curl -sS https://starship.rs/install.sh | sh -- -y

# Development
sudo dnf install -y code emacs neovim

# Gaming
# sudo dnf install steam -y
# flatpak install -y com.heroicgameslauncher.hgl

# Virtualization
sudo dnf group install -y --with-optional virtualization

# Initialize virtualization
sudo sed -i 's/#unix_sock_group = "libvirt"/unix_sock_group = "libvirt"/g' /etc/libvirt/libvirtd.conf
sudo sed -i 's/#unix_sock_rw_perms = "0770"/unix_sock_rw_perms = "0770"/g' /etc/libvirt/libvirtd.conf
sudo systemctl enable libvirtd
sudo usermod -aG libvirt $(whoami)

# Install QuickEmu
sudo dnf install qemu bash coreutils edk2-tools grep jq lsb procps python3 genisoimage usbutils util-linux sed spice-gtk-tools swtpm wget xdg-user-dirs xrandr unzip -y
mkdir -p ~/software
git clone --filter=blob:none https://github.com/wimpysworld/quickemu ~/software/quickemu

# Configure GNOME
gsettings set org.gnome.desktop.a11y always-show-universal-access-status true
gsettings set org.gnome.desktop.wm.preferences button-layout "appmenu:minimize,close"
gsettings set org.gnome.shell favorite-apps "['microsoft-edge.desktop', 'Alacritty.desktop', 'sh.cider.Cider.desktop', 'code.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Software.desktop']"

echo "The configuration is now complete."

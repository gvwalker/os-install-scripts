#!/bin/sh

# Configure dnf (In order: automatically select fastest mirror, parallel downloads, and disable telemetry)
printf "%s" "
fastestmirror=1
max_parallel_downloads=10
" | sudo tee -a /etc/dnf/dnf.conf

# Debloat
sudo dnf remove -y libreoffice-core cheese gnome-calendar gnome-weather gnome-clocks gnome-contacts gnome-tour gnome-logs gnome-remote-desktop gnome-maps gnome-calculator gnome-characters gnome-font-viewer gnome-shell-extension* totem mediawriter gnome-connections nano nano-default-editor gnome-user-docs gnome-color-manager eog gnome-text-editor evince rhythmbox

# Run Updates
sudo dnf autoremove -y
sudo dnf upgrade -y

# Install Firmware Updates
# sudo fwupdmgr get-devices
# sudo fwupdmgr refresh --force
# sudo fwupdmgr get-updates -y
# sudo fwupdmgr update -y

# Setup Flathub and Flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Setup RPMFusion & Other Repos
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Edge and VSCode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[microsoft-edge]\nname=Microsoft Edge\nbaseurl=https://packages.microsoft.com/yumrepos/edge/\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/microsoft-edge.repo'
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode/\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

# 1Password
sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
sudo sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo'

# SyncthingTray
sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/home:/mkittler/Fedora_38/home:mkittler.repo

# YADM
sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/home:TheLocehiliosan:yadm/Fedora_37/home:TheLocehiliosan:yadm.repo

# Docker Engine
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

# LazyGit
sudo dnf copr enable atim/lazygit -y

sudo dnf groupupdate core -y

# Virtualization
sudo dnf group install -y --with-optional virtualization

# Initialize virtualization
sudo sed -i 's/#unix_sock_group = "libvirt"/unix_sock_group = "libvirt"/g' /etc/libvirt/libvirtd.conf
sudo sed -i 's/#unix_sock_rw_perms = "0770"/unix_sock_rw_perms = "0770"/g' /etc/libvirt/libvirtd.conf
sudo systemctl enable libvirtd
sudo usermod -aG libvirt $(whoami)

echo "First stage of configuration is now complete. Please reboot."

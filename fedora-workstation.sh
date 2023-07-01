#!/bin/sh

# Configure dnf (In order: automatically select fastest mirror, parallel downloads, and disable telemetry)
printf "%s" "
fastestmirror=1
max_parallel_downloads=10
countme=false
" | sudo tee -a /etc/dnf/dnf.conf

#Setting umask to 077
# No one except wheel user and root get read/write files
umask 077
sudo sed -i 's/umask 002/umask 077/g' /etc/bashrc
sudo sed -i 's/umask 022/umask 077/g' /etc/bashrc

# Debloat
sudo dnf remove -y abrt* adcli anaconda* cheese dmidecode gnome-classic-session anthy-unicode avahi baobab bluez-cups brasero-libs trousers hyperv* alsa-sof-firmware boost-date-time gnome-calendar gnome-shell-extension-background-logo gnome-weather gnome-boxes gnome-clocks gnome-contacts gnome-tour gnome-logs gnome-remote-desktop gnome-maps gnome-backgrounds virtualbox-guest-additions yelp gnome-calculator gnome-characters gnome-system-monitor gnome-font-viewer gnome-font-viewer simple-scan evince-djvu orca fedora-bookmarks fedora-chromium-config mailcap open-vm-tools openconnect openvpn ppp pptp qgnomeplatform rsync samba-client unbound-libs vpnc podman yajl zd1211-firmware atmel-firmware libertas-usb8388-firmware linux-firmware gnome-tour gnome-shell-extension* totem mediawriter gnome-connections nano nano-default-editor firefox xorg-x11-drv-vmware openssh-server sane* perl* thermald NetworkManager-ssh sos kpartx dos2unix gnome-user-docs sssd cyrus-sasl-plain gnome-color-manager geolite2* traceroute mtr realmd gnome-themes-extra ModemManager teamd tcpdump mozilla-filesystem nmap-ncat spice-vdagent eog gnome-text-editor perl-IO-Socket-SSL evince

# Verify systemd-oomd works
# systemctl status systemd-oomd

# Run Updates
sudo dnf autoremove -y
sudo dnf upgrade -y
sudo fwupdmgr get-devices
sudo fwupdmgr refresh --force
sudo fwupdmgr get-updates -y
sudo fwupdmgr update -y

# Configure GNOME
gsettings set org.gnome.desktop.a11y always-show-universal-access-status true
#gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface clock-show-seconds true
#gsettings set org.gnome.desktop.screensaver.lock-enabled false
#gsettings set org.gnome.desktop.notifications.show-in-lock-screen false
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true

# Setup Flathub and Flatpak
# Flathub is enabled by default, but fails to install anything outside of Fedora still.
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo

# Setup RPMFusion
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf groupupdate core -y

# Install things I need
flatpak install -y flathub com.transmissionbt.Transmission org.mozilla.firefox org.signal.Signal org.libreoffice.LibreOffice ch.protonmail.protonmail-bridge com.github.tchx84.Flatseal org.bleachbit.BleachBit org.getmonero.Monero org.gnome.Loupe org.keepassxc.KeePassXC com.brave.Browser org.gnome.Evolution com.github.micahflee.torbrowser-launcher org.inkscape.Inkscape io.freetubeapp.FreeTube net.mullvad.MullvadBrowser org.getmonero.Monero re.sonny.Junction com.tutanota.Tutanota com.protonvpn.www com.obsproject.Studio com.usebottles.bottles com.obsproject.Studio.Plugin.OBSVkCapture app.drey.Warp org.pipewire.Helvum org.freedesktop.Platform.VulkanLayer.OBSVkCapture net.davidotek.pupgui2 com.heroicgameslauncher.hgl com.valvesoftware.Steam org.freedesktop.Platform.VulkanLayer.MangoHud org.gnome.Calculator org.gnome.gitlab.YaLTeR.VideoTrimmer org.gnome.Extensions org.gnome.Characters org.blender.Blender org.gnome.Evince
sudo dnf install -y steam-devices alacritty neovim sqlite3 zsh-autosuggestions zsh-syntax-highlighting setroubleshoot newsboat ffmpeg compat-ffmpeg4 akmod-v4l2loopback yt-dlp @virtualization distrobox podman hugo flat-remix-icon-theme --best --allowerasing

# Initialize virtualization
sudo sed -i 's/#unix_sock_group = "libvirt"/unix_sock_group = "libvirt"/g' /etc/libvirt/libvirtd.conf
sudo sed -i 's/#unix_sock_rw_perms = "0770"/unix_sock_rw_perms = "0770"/g' /etc/libvirt/libvirtd.conf
sudo systemctl enable libvirtd
sudo usermod -aG libvirt $(whoami)

# Cockpit is still missing some core functionality, but will switch when it is added.
#sudo systemctl enable libvirtd --now
#sudo systemctl enable cockpit.socket --now

# Install Sway
# sudo dnf install -y sway waybar wofi wlsunset network-manager-applet

# Harden the Kernel with Kicksecure's patches
sudo curl https://raw.githubusercontent.com/Kicksecure/security-misc/master/etc/modprobe.d/30_security-misc.conf -o /etc/modprobe.d/30_security-misc.conf
sudo curl https://raw.githubusercontent.com/Kicksecure/security-misc/master/etc/sysctl.d/30_security-misc.conf -o /etc/sysctl.d/30_security-misc.conf
sudo curl https://raw.githubusercontent.com/Kicksecure/security-misc/master/etc/sysctl.d/30_silent-kernel-printk.conf -o /etc/sysctl.d/30_silent-kernel-printk.conf

# Enable Kicksecure CPU mitigations
sudo curl https://raw.githubusercontent.com/Kicksecure/security-misc/master/etc/default/grub.d/40_cpu_mitigations.cfg -o /etc/grub.d/40_cpu_mitigations.cfg
# Kicksecure's CPU distrust script
sudo curl https://raw.githubusercontent.com/Kicksecure/security-misc/master/etc/default/grub.d/40_distrust_cpu.cfg -o /etc/grub.d/40_distrust_cpu.cfg
# Enable Kicksecure's IOMMU patch (limits DMA)
sudo curl https://raw.githubusercontent.com/Kicksecure/security-misc/master/etc/default/grub.d/40_enable_iommu.cfg -o /etc/grub.d/40_enable_iommu.cfg

# Divested's brace patches
# Sandbox the brace systemd permissions
# If you have VPN issues: https://old.reddit.com/r/DivestOS/comments/12b4fk4/comment/jex4qt2/
sudo mkdir -p /etc/systemd/system/NetworkManager.service.d
sudo curl https://gitlab.com/divested/brace/-/raw/master/brace/usr/lib/systemd/system/NetworkManager.service.d/99-brace.conf -o /etc/systemd/system/NetworkManager.service.d/99-brace.conf
sudo mkdir -p /etc/systemd/system/irqbalance.service.d
sudo curl https://gitlab.com/divested/brace/-/raw/master/brace/usr/lib/systemd/system/irqbalance.service.d/99-brace.conf -o /etc/systemd/system/irqbalance.service.d/99-brace.conf

# GrapheneOS's ssh limits
# caps the system usage of sshd
# GrapheneOS has changed the way this is implemented, so I'm working on a reintegration.
# sudo mkdir -p /etc/systemd/system/sshd.service.d
# sudo curl https://raw.githubusercontent.com/GrapheneOS/infrastructure/main/systemd/system/sshd.service.d/limits.conf -o /etc/systemd/system/sshd.service.d/limits.conf
# echo "GSSAPIAuthentication no" | sudo tee /etc/ssh/ssh_config.d/10-custom.conf
# echo "VerifyHostKeyDNS yes" | sudo tee -a /etc/ssh/ssh_config.d/10-custom.conf

# NTS instead of NTP
# NTS is a more secured version of NTP
sudo curl https://raw.githubusercontent.com/GrapheneOS/infrastructure/main/chrony.conf -o /etc/chrony.conf

# Remove Firewalld's Default Rules
sudo firewall-cmd --permanent --remove-port=1025-65535/udp
sudo firewall-cmd --permanent --remove-port=1025-65535/tcp
sudo firewall-cmd --permanent --remove-service=mdns
sudo firewall-cmd --permanent --remove-service=ssh
sudo firewall-cmd --permanent --remove-service=samba-client
sudo firewall-cmd --reload

#Randomize MAC address and disable static hostname. This could be used to track general network activity.
sudo bash -c 'cat > /etc/NetworkManager/conf.d/00-macrandomize.conf' <<-'EOF'
[main]
hostname-mode=none

[device]
wifi.scan-rand-mac-address=yes

[connection]
wifi.cloned-mac-address=random
ethernet.cloned-mac-address=random
EOF

sudo systemctl restart NetworkManager
sudo hostnamectl hostname "localhost"

# Disable Bluetooth
sudo systemctl disable bluetooth
 
# Enable DNSSEC
# causes severe network instability, but working on getting this up and running
# sudo sed -i s/#DNSSEC=no/DNSSEC=yes/g /etc/systemd/resolved.conf
# sudo systemctl restart systemd-resolved

# Make the Home folder private
# Privatizing the home folder creates problems with virt-manager
# accessing ISOs from your home directory.
#chmod 700 /home/"$(whoami)"
# is reset using:
#chmod 755 /home/"$(whoami)"
#
# DaVinci Resolve tweaks
# Because no one ever said how to in detail
# I'm sorry GE, but this might as well be nonsense to normies: https://old.reddit.com/r/Fedora/comments/12g0mh4/fedora_38_issue_with_davinci_resolve/
# sudo dnf install mesa-Glu
#sudo cp /lib64/libglib-2.0.so.0* /opt/resolve/libs

echo "The configuration is now complete."

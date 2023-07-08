#!/bin/sh
#
# Installs NVIDIA driver
# Requires RPMFusion
# Sauce: https://rpmfusion.org/Howto/NVIDIA
sudo dnf install akmod-nvidia xorg-x11-drv-nvidia-cuda xorg-x11-drv-nvidia-cuda-libs nvidia-vaapi-driver libva-utils vdpauinfo
echo "
    Open grub config sudoedit /etc/default/grub
    Add nvidia-drm.modeset=1 to GRUB_CMDLINE_LINUX line
    Update grub config with sudo grub2-mkconfig -o /boot/grub2/grub.cfg command
    Reboot the system
"

#!/bin/sh
#
# Installs NVIDIA driver
# Requires RPMFusion
# Sauce: https://rpmfusion.org/Howto/NVIDIA
# I have a 1080TI, so I install NVIDIA, the Xorg CUDA libraries for CUDA acceleration and NVENC codecs, and vdpau for accerlated video things.
# You can also install the 390x version, which I don't have any compatible devices for, but I hear nouveau is probably the way to go, because of the drivers are EOL.
sudo dnf install akmod-nvidia xorg-x11-drv-nvidia-cuda xorg-x11-drv-nvidia-cuda-libs nvidia-vaapi-driver libva-utils vdpauinfo
echo "
    Open grub config sudoedit /etc/default/grub
    Add nvidia-drm.modeset=1 to GRUB_CMDLINE_LINUX line
    Update grub config with sudo grub2-mkconfig -o /boot/grub2/grub.cfg command
    Reboot the system
"

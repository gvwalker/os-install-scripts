#!/bin/sh
#
# Installs and automatically signs the NVIDIA driver for UEFI secure boot
# Sauce: https://rpmfusion.org/Howto/Secure%20Boot
# This also causes a "false flag" with GNOME/KDE's security menu, although it's not wrong.
# Your system must be installed with UEFI enabled out of the box, which if you have Secure
# Boot enabled prior to the installation, it works great. 
sudo dnf install kmodtool akmods openssl -y
sudo kmodgenca -a
sudo mokutil --import /etc/pki/akmods/certs/public_key.der
echo "Reboot, enter your key's password, then run script 2."

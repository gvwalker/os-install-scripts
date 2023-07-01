# Install Scripts
These are the scripts for installing things. Customize them however you want.

# Core Principles
- Supports basic security features (UEFI Secure Boot, full-disk encryption, random MAC, etc)
- Wayland-only; X11 is dead.
- SELinux or turning on AppArmor; default for distro (e.g. SELinux for Fedora, AppArmor for Debian)
- All applications with a Flatpak will be replaced with one.
- Additional hardening from DivestOS, GrapheneOS, and KickSecure (even on non-Debian distros)

# Technical To-Do
- Organize lines of uninstalling/installing stuff with comments
- Full guide for DaVinci Resolve, either on bare metal or distrobox
- Disabling GNOME's automount
- `chmod +700 "/home/$(whoami)"` when I find out where the heck you store ISOs properly
- BTRFS snapshots with snapper, but Fedora hates me
- TPM, when I upgrade in the coming years, probably through [systemd-cryptenroll](https://fedoramagazine.org/use-systemd-cryptenroll-with-fido-u2f-or-tpm2-to-decrypt-your-disk/)
- DNSSEC, when it doesn't murder my internet
- Flatpak overrides (these are heavily personal and I may need to make them for generalized)
- Replace CLI native packages by containerizing them in distrobox

# OSes to add
- Converting Debian XFCE to KickSecure
- Ubuntu (disable telemetry, replace some built-in apps with snaps, etc)
- openSUSE Tumbleweed (find a better way to uninstall base applications, but it's pretty good otherwise)
- Windows 11 (winget, chocolatey, Powershell Gallery, WSL setup)
- macOS (2 big brew commands, disabling brew's analytics, custom Lulu rules to block Apple telemetry)
- pfSense config
- Immutable Fedora (using ublue or one of the official spins as a base). Vast majority of tweaks are simple package changes or `/etc/`. I will testing Sericea first.
- Adjust Fedora for other spins as a base
- nixOS (When I get time to learn that configuration file)

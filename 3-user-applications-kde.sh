# Install things I need

# General
flatpak install -y flathub org.libreoffice.LibreOffice com.github.tchx84.Flatseal org.bleachbit.BleachBit com.usebottles.bottles sh.cider.Cider
sudo dnf install -y 1password 1password-cli btop tmux lazygit syncthing syncthingtray microsoft-edge-stable alacritty zsh zsh-autosuggestions zsh-syntax-highlighting ffmpeg compat-ffmpeg4 dconf-editor bat exa yadm git --best --allowerasing

# Install Starship
wget https://starship.rs/install.sh
chmod +x install.sh
./install.sh -y
rm install.sh

# Development
sudo dnf install -y code emacs neovim fzf ripgrep fd-find nodejs ruby 

# Gaming
# sudo dnf install steam -y
# flatpak install -y com.heroicgameslauncher.hgl

# Install QuickEmu
sudo dnf install qemu bash coreutils edk2-tools grep jq lsb procps python3 genisoimage usbutils util-linux sed spice-gtk-tools swtpm wget xdg-user-dirs xrandr unzip -y
mkdir -p ~/software
git clone --filter=blob:none https://github.com/wimpysworld/quickemu ~/software/quickemu


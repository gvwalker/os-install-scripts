# Install things I need

# General
flatpak install -y flathub org.libreoffice.LibreOffice com.github.tchx84.Flatseal org.bleachbit.BleachBit org.gnome.Loupe org.gnome.Evolution com.usebottles.bottles org.gnome.Calculator com.mattjakeman.ExtensionManager org.gnome.Characters org.gnome.Evince sh.cider.Cider
sudo dnf install -y 1password 1password-cli btop syncthing tmux lazygit ulauncher microsoft-edge-stable alacritty sqlite3 zsh zsh-autosuggestions zsh-syntax-highlighting ffmpeg compat-ffmpeg4 gnome-tweaks dconf-editor bat exa yadm git syncthingtray python3-pytz --best --allowerasing

# Install Starship
wget https://starship.rs/install.sh
chmod +x install.sh
./install.sh -y
rm install.sh

# Development
sudo dnf install -y code emacs neovim fzf ripgrep fd-find nodejs ruby docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo usermod -aG docker $USER
sudo systemctl enable docker.service

# Gaming
# sudo dnf install steam -y
# flatpak install -y com.heroicgameslauncher.hgl

# Install QuickEmu
sudo dnf install qemu bash coreutils edk2-tools grep jq lsb procps python3 genisoimage usbutils util-linux sed spice-gtk-tools swtpm wget xdg-user-dirs xrandr unzip -y
mkdir -p ~/software
git clone --filter=blob:none https://github.com/wimpysworld/quickemu ~/software/quickemu

# Configure GNOME
gsettings set org.gnome.desktop.a11y always-show-universal-access-status true
gsettings set org.gnome.desktop.wm.preferences button-layout "appmenu:minimize,close"
gsettings set org.gnome.shell favorite-apps "['microsoft-edge.desktop', 'Alacritty.desktop', 'sh.cider.Cider.desktop', 'code.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Software.desktop']"

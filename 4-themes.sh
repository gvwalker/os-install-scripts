#Catppuccin All the Things!
mkdir -p ~/software

#Bat
git clone https://github.com/catppuccin/bat bat-theme
mkdir -p "$(bat --config-dir)/themes"
cp bat-theme/*.tmTheme "$(bat --config-dir)/themes"
bat cache --build
echo '--theme="Catppuccin-mocha"' | tee -a ~/.config/bat/config

rm -rf bat-theme

# ZSH syntax highlighting
git clone https://github.com/catppuccin/zsh-syntax-highlighting ~/software/zsh-syntax-highlighting-theme

# GTK
sudo dnf install sassc -y
git clone https://github.com/catppuccin/gtk
cd gtk
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python install.py mocha -l
cd .. && rm -rf gtk
sudo dnf remove sassc -y
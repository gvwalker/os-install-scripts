sudo dnf install -y pipx
pipx install gnome-extensions-cli
echo 'PATH="/home/grant/.local/bin:$PATH"' | tee -a  ~/.zshrc
PATH="/home/grant/.local/bin:$PATH"

## Install Gnome Extensions

gnome-extensions-cli i appindicatorsupport@rgcjonas.gmail.com
gnome-extensions-cli i blur-my-shell@aunetx
gnome-extensions-cli i caffeine@patapon.info
gnome-extensions-cli i dash-to-dock@micxgx.gmail.com
gnome-extensions-cli i just-perfection-desktop@just-perfection
gnome-extensions-cli i openweather-extension@jenslody.de
gnome-extensions-cli i user-theme@gnome-shell-extensions.gcampax.github.com
gnome-extensions-cli i Vitals@CoreCoding.com

## Configure Gnome Extensions

# App Indicator
dconf write /org/gnome/shell/extensions/appindicator/icon-size 0
dconf write /org/gnome/shell/extensions/appindicator/legacy-tray-enabled true
dconf write /org/gnome/shell/extensions/appindicator/tray-pos "'right'"

# Dash to Dock
dconf write /org/gnome/shell/extensions/dash-to-dock/background-opacity 0.8
dconf write /org/gnome/shell/extensions/dash-to-dock/click-action "'focus-minimize-or-appspread'"
dconf write /org/gnome/shell/extensions/dash-to-dock/disable-overview-on-startup true
dconf write /org/gnome/shell/extensions/dash-to-dock/scroll-action "'cycle-windows'"
dconf write /org/gnome/shell/extensions/dash-to-dock/show-trash false
dconf write /org/gnome/shell/extensions/dash-to-dock/transparency-mode "'DYNAMIC'"

# Just Perfection
dconf write /org/gnome/shell/extensions/just-perfection/activities-button false
dconf write /org/gnome/shell/extensions/just-perfection/app-menu false
dconf write /org/gnome/shell/extensions/just-perfection/events-button false
dconf write /org/gnome/shell/extensions/just-perfection/hot-corner false
dconf write /org/gnome/shell/extensions/just-perfection/world-clock false
dconf write /org/gnome/shell/extensions/just-perfection/weather false
dconf write /org/gnome/shell/extensions/just-perfection/events-button false

# OpenWeather
dconf write /org/gnome/shell/extensions/openweather/city "'-33.8402778,18.6494444>Durbanville, City of Cape Town, Western Cape, South Africa>0'"

# Vitals
dconf write /org/gnome/shell/extensions/vitals/position-in-panel 0
dconf write /org/gnome/shell/extensions/vitals/show-fan false
dconf write /org/gnome/shell/extensions/vitals/hot-sensors "['_memory_usage_', '_system_load_1m_', '_processor_usage_', '_storage_free_', '__network-rx_max__']"
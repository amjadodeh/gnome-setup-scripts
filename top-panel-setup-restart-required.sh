#!/bin/bash

# Function to check if required packages are installed
check_command() {
	if ! command -v $1 &> /dev/null; then
		echo "'$1' command is not installed."
		check=failed
	fi
}

# Check for gnome-extensions, curl, and wget
check_command gnome-extensions
check_command curl
check_command wget

# Exit the script if required packages are not installed
if [[ "$check" == "failed" ]]; then
	echo
	echo "please install required packages before running this script."
	exit 1
fi

# Install desired GNOME Extensions with gnome-extensions
echo 'installing desired gnome extensions w/ gnome-extensions...'

EXT_LIST=(
	appindicatorsupport@rgcjonas.gmail.com
	clipboard-indicator@tudmotu.com
	color-picker@tuberry
	dash-to-panel@jderose9.github.com
	forge@jmmaranan.com
	legacyschemeautoswitcher@joshimukul29.gmail.com
	overviewbackground@github.com.orbitcorrection
	)

GN_CMD_OUTPUT=$(gnome-shell --version)
GN_SHELL=${GN_CMD_OUTPUT:12:2}
for i in "${EXT_LIST[@]}"; do
	VERSION_LIST_TAG=$(curl -Lfs "https://extensions.gnome.org/extension-query/?search=${i}" | jq '.extensions[] | select(.uuid=="'"${i}"'")')
	VERSION_TAG="$(echo "$VERSION_LIST_TAG" | jq '.shell_version_map |."'"${GN_SHELL}"'" | ."pk"')"
	wget -O "${i}".zip "https://extensions.gnome.org/download-extension/${i}.shell-extension.zip?version_tag=$VERSION_TAG"
	gnome-extensions install --force "${i}".zip
	rm -f ${i}.zip
done

# Enable desired GNOME Extensions with dconf
echo 'enabling desired gnome extensions w/ dconf...'
dconf write /org/gnome/shell/enabled-extensions "['appindicatorsupport@rgcjonas.gmail.com', 'clipboard-indicator@tudmotu.com', 'color-picker@tuberry', 'dash-to-panel@jderose9.github.com', 'forge@jmmaranan.com', 'legacyschemeautoswitcher@joshimukul29.gmail.com', 'overviewbackground@github.com.orbitcorrection']"

# Create Config Directory (if it doesn't already exist)
mkdir -p $HOME/.config

# Dash to Panel Customizations
echo 'customizing dash to panel...'
tee $HOME/.config/dash-to-panel 1> /dev/null <<- 'EOF'
	[/]
	appicon-margin=4
	appicon-padding=4
	dot-position='TOP'
	hide-overview-on-startup=true
	isolate-workspaces=true
	multi-monitors=false
	panel-anchors='{"0":"MIDDLE","1":"MIDDLE"}'
	panel-element-positions='{"0":[{"element":"showAppsButton","visible":true,"position":"stackedTL"},{"element":"activitiesButton","visible":false,"position":"stackedTL"},{"element":"leftBox","visible":true,"position":"stackedTL"},{"element":"taskbar","visible":true,"position":"stackedTL"},{"element":"centerBox","visible":true,"position":"stackedBR"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":true,"position":"stackedBR"}],"1":[{"element":"showAppsButton","visible":true,"position":"stackedTL"},{"element":"activitiesButton","visible":false,"position":"stackedTL"},{"element":"leftBox","visible":true,"position":"stackedTL"},{"element":"taskbar","visible":true,"position":"stackedTL"},{"element":"centerBox","visible":true,"position":"stackedBR"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":true,"position":"stackedBR"}]}'
	panel-lengths='{"0":100,"1":100}'
	panel-positions='{"0":"TOP","1":"TOP"}'
	panel-sizes='{"0":24,"1":24}'
	trans-use-custom-opacity=true
	trans-use-dynamic-opacity=true
EOF
dconf load /org/gnome/shell/extensions/dash-to-panel/ < $HOME/.config/dash-to-panel

# Custom Tweaks (via gsettings)
echo 'setting up some custom tweaks (via gsettings)...'
gsettings set org.gnome.desktop.privacy disable-camera true
gsettings set org.gnome.desktop.privacy old-files-age 'uint32 30'
gsettings set org.gnome.desktop.privacy recent-files-max-age -1
gsettings set org.gnome.desktop.privacy remember-recent-files false
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
gsettings set org.gnome.desktop.wm.preferences focus-mode 'sloppy'
gsettings set org.gnome.desktop.wm.preferences focus-new-windows 'strict'
gsettings set org.gnome.desktop.wm.preferences resize-with-right-button true
gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'hibernate'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'

# Custom Tweaks (via dconf)
echo 'setting up some custom tweaks (via dconf)...'
dconf write /ca/desrt/dconf-editor/show-warning false
dconf write /net/sapples/LiveCaptions/save-history false
dconf write /org/gnome/desktop/interface/clock-format "'24h'"
dconf write /org/gnome/desktop/interface/clock-show-date true
dconf write /org/gnome/desktop/interface/clock-show-seconds true
dconf write /org/gnome/desktop/interface/clock-show-weekday true
dconf write /org/gnome/desktop/interface/show-battery-percentage true
dconf write /org/gnome/desktop/peripherals/touchpad/tap-to-click true
dconf write /org/gnome/desktop/wm/keybindings/switch-applications "@as []"
dconf write /org/gnome/desktop/wm/keybindings/switch-windows "['<Super>Tab', '<Alt>Tab']"
dconf write /org/gnome/mutter/dynamic-workspaces true
dconf write /org/gnome/mutter/workspaces-only-on-primary true
dconf write /org/gnome/nautilus/preferences/show-hidden-files true
dconf write /org/gnome/nautilus/preferences/show-image-thumbnails "'always'"
dconf write /org/gnome/shell/extensions/forge/focus-border-toggle false
dconf write /org/gnome/shell/extensions/forge/tiling-mode-enabled true
dconf write /org/gtk/gtk4/settings/file-chooser/sort-directories-first true
dconf write /org/gtk/gtk4/settings/file-chooser/show-hidden true
dconf write /org/gtk/settings/file-chooser/show-hidden true
dconf write /org/virt-manager/virt-manager/console/scaling 2
dconf write /org/virt-manager/virt-manager/system-tray true

echo "Done! Please restart gnome-shell or reboot for changes to take effect."


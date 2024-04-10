#!/bin/bash

# Install desired GNOME Extensions with gnome-extensions
echo 'installing desired gnome extensions w/ gnome-extensions...'
echo 'this will require user interaction for each extension...'
sleep 3

EXT_LIST=(
	appindicatorsupport@rgcjonas.gmail.com
	clipboard-indicator@tudmotu.com
	color-picker@tuberry
	dash-to-panel@jderose9.github.com
	forge@jmmaranan.com
	legacyschemeautoswitcher@joshimukul29.gmail.com
	overviewbackground@github.com.orbitcorrection
	)

for i in "${EXT_LIST[@]}"; do
	busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s ${i}
done

# Create Config Directory (if it doesn't already exist)
mkdir -p $HOME/.config

# Get the users preferred panel position
if [[ "$1" == "top" || "$1" == "bottom" ]]; then
	position="$1"
else
	while :; do
		read -p "Panel on top or bottom? (top/bottom): " position

		position=$(echo "$position" | tr '[:upper:]' '[:lower:]')

		if [[ "$position" == "top" || "$position" == "bottom" ]]; then
			break
		else
			echo "Invalid input... please enter top or bottom."
		fi
	done
fi

# Dash to Panel Customizations
echo 'customizing dash to panel...'
if [[ "$position" == "top" ]]; then
	tee $HOME/.config/dash-to-panel 1> /dev/null <<- '	EOF'
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
elif [[ "$position" == "bottom" ]]; then
	tee $HOME/.config/dash-to-panel 1> /dev/null <<- '	EOF'
		[/]
		appicon-margin=0
		appicon-padding=10
		dot-position='BOTTOM'
		hide-overview-on-startup=true
		isolate-workspaces=true
		multi-monitors=false
		panel-anchors='{"0":"MIDDLE","1":"MIDDLE"}'
		panel-element-positions='{"0":[{"element":"showAppsButton","visible":true,"position":"stackedTL"},{"element":"activitiesButton","visible":false,"position":"stackedTL"},{"element":"leftBox","visible":true,"position":"stackedTL"},{"element":"taskbar","visible":true,"position":"stackedTL"},{"element":"centerBox","visible":true,"position":"stackedBR"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":true,"position":"stackedBR"}],"1":[{"element":"showAppsButton","visible":true,"position":"stackedTL"},{"element":"activitiesButton","visible":false,"position":"stackedTL"},{"element":"leftBox","visible":true,"position":"stackedTL"},{"element":"taskbar","visible":true,"position":"stackedTL"},{"element":"centerBox","visible":true,"position":"stackedBR"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":true,"position":"stackedBR"}]}'
		panel-lengths='{"0":100,"1":100}'
		panel-positions='{"0":"BOTTOM","1":"BOTTOM"}'
		panel-sizes='{"0":40,"1":40}'
		trans-use-custom-opacity=false
		trans-use-dynamic-opacity=false
	EOF
fi
dconf load /org/gnome/shell/extensions/dash-to-panel/ < $HOME/.config/dash-to-panel

# Terminator Config
if command -v terminator &> /dev/null; then
	echo 'setting up terminator config...'
	mkdir -p $HOME/.config/terminator
	tee $HOME/.config/terminator/config 1> /dev/null <<- '	EOF'
		[global_config]
		  focus = system
		  #borderless = True

		[keybindings]
		  #full_screen = <Ctrl><Shift>F11

		[profiles]
		  [[default]]
		    show_titlebar = False
		    scrollbar_position = hidden
		    #font = Fixed 10
		    #background_color = "#000000"
		    #foreground_color = "#FFFFFF"
		    scrollback_lines = "3000"
		    #cursor_blink = True
		    #custom_command = "echo \"foo#bar\""
		    #exit_action = restart
		[layouts]
		  [[default]]
		    [[[window0]]]
		      type = Window
		      parent = ""
		    [[[child1]]]
		      type = Terminal
		      parent = window0
		      profile = default
	EOF
fi

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

echo "Done!"


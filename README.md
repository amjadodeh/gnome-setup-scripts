
# gnome setup scripts

This repo contains scripts to automatically set up GNOME with my preferred look and feel. There are two variations of the script available to cater to different setup preferences.

## Script Variations

1. **gnome-setup-interactive.sh**: This version of the script requires user interaction to confirm the installation of each extension using a message-dialog. Ideal for users who prefer to complete the setup quickly without needing to restart GNOME shell.

2. **gnome-setup-restart.sh**: This version automates the entire setup process without needing user input for each extension but requires restarting the GNOME shell (for Wayland: logout/login; for Xorg: Alt+F2 r) or rebooting to complete the setup. Ideal for users looking for a more streamlined setup experience, especially when setting up a new Linux distribution, as it allows for the bundling of app installations and updates with a single system restart to finalize the configuration.

## Quick Setup

NOTE: This requires curl to run

To execute one of the scripts with a single command, select one of the following commands based on your preference and whether you want the panel at the top or the bottom of the screen, and execute it in your terminal.

### gnome-setup-interactive.sh

Use this script if you prefer to interactively confirm each step of the setup process. Specify 'top' or 'bottom' to set the panel's position without a prompt:

**For a top panel:**
```bash
bash <(curl -sL https://raw.githubusercontent.com/amjadodeh/gnome-setup-scripts/master/gnome-setup-interactive.sh) top
```
**For a bottom panel:**
```bash
bash <(curl -sL https://raw.githubusercontent.com/amjadodeh/gnome-setup-scripts/master/gnome-setup-interactive.sh) bottom
```

### gnome-setup-restart.sh

Use this script for a non-interactive setup that requires a GNOME shell restart (for Wayland: logout/login; for Xorg: Alt+F2 r) or a reboot. Like with the interactive script, specify 'top' or 'bottom' to set the panel's position:

**For a top panel:**
```bash
bash <(curl -sL https://raw.githubusercontent.com/amjadodeh/gnome-setup-scripts/master/gnome-setup-restart.sh) top
```
**For a bottom panel:**
```bash
bash <(curl -sL https://raw.githubusercontent.com/amjadodeh/gnome-setup-scripts/master/gnome-setup-restart.sh) bottom
```

## What does it actually do?

In short, the scripts install and enable the following GNOME extensions:

- [AppIndicator and KStatusNotifierItem Support](https://extensions.gnome.org/extension/615/appindicator-support/)
- [Clipboard Indicator](https://extensions.gnome.org/extension/779/clipboard-indicator/)
- [Color Picker](https://extensions.gnome.org/extension/3396/color-picker/)
- [Dash to Panel](https://extensions.gnome.org/extension/1160/dash-to-panel/)
- [Forge](https://extensions.gnome.org/extension/4481/forge/)
- [Legacy (GTK3) Theme Scheme Auto Switcher](https://extensions.gnome.org/extension/4998/legacy-gtk3-theme-scheme-auto-switcher/)
- [Overview Background](https://extensions.gnome.org/extension/5856/overview-background/)

The scripts accept either 'top' or 'bottom' as the first argument to determine the panel's position. If either of these options is specified, the panel is set to the chosen position. If neither is specified, the script will prompt the user to choose the preferred panel position.

Finally, the scripts configure and make some additional tweaks by writing to files, and by using gsettings and dconf.


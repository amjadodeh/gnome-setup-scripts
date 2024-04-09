
# [gnome-setup-scripts](https://github.com/amjadodeh/gnome-setup-scripts)

This repo contains scripts to automatically set up GNOME with my preferred look and feel. There are two variations of the script available to cater to different setup preferences.

## Variations

1. **gnome-setup-interactive.sh**: This version of the script requires user interaction to confirm the installation of each extension using a message-dialog. Ideal for users who prefer to complete the setup quickly without needing to restart GNOME shell.

2. **gnome-setup-restart.sh**: This version automates the entire setup process without needing user input for each extension but requires restarting the GNOME shell (for Wayland: logout/login; for Xorg: Alt+F2 r) or rebooting to complete the setup. Ideal for users looking for a more streamlined setup experience, especially when setting up a new Linux distribution, as it allows for the bundling of app installations and updates with a single system restart to finalize the configuration.

## What it actually does?

In short, the scripts install and enable the following GNOME extensions:

- [AppIndicator and KStatusNotifierItem Support](https://extensions.gnome.org/extension/615/appindicator-support/)
- [Clipboard Indicator](https://extensions.gnome.org/extension/779/clipboard-indicator/)
- [Color Picker](https://extensions.gnome.org/extension/3396/color-picker/)
- [Dash to Panel](https://extensions.gnome.org/extension/1160/dash-to-panel/)
- [Forge](https://extensions.gnome.org/extension/4481/forge/)
- [Legacy (GTK3) Theme Scheme Auto Switcher](https://extensions.gnome.org/extension/4998/legacy-gtk3-theme-scheme-auto-switcher/)
- [Overview Background](https://extensions.gnome.org/extension/5856/overview-background/)

The scripts also use the 'top' or 'bottom' options to determine the panel's position without prompting the user. If either of these options is specified, the panel is set to the chosen position. If neither is specified, the script will prompt the user to choose the preferred panel position.

Finally, the scripts configure and make some additional tweaks by writing to files, and by using gsettings and dconf.


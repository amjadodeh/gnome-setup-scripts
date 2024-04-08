
# [gnome-setup-scripts](https://github.com/amjadodeh/gnome-setup-scripts)

This repo contains scripts to automatically set up GNOME with my preferred look and feel.

## What it actually does?

In short, the script installs and enables the following gnome extensions:

- [appindicatorsupport@rgcjonas.gmail.com](https://extensions.gnome.org/extension/615/appindicator-support/)
- [clipboard-indicator@tudmotu.com](https://extensions.gnome.org/extension/779/clipboard-indicator/)
- [color-picker@tuberry](https://extensions.gnome.org/extension/3396/color-picker/)
- [dash-to-panel@jderose9.github.com](https://extensions.gnome.org/extension/1160/dash-to-panel/)
- [forge@jmmaranan.com](https://extensions.gnome.org/extension/4481/forge/)
- [legacyschemeautoswitcher@joshimukul29.gmail.com](https://extensions.gnome.org/extension/4998/legacy-gtk3-theme-scheme-auto-switcher/)
- [overviewbackground@github.com.orbitcorrection](https://extensions.gnome.org/extension/5856/overview-background/)

Then, it checks if the user used the 'top' or 'bottom' option to specify preffered panel position. If so, the panel is set to be in the specified position. If not, The script will prompt the user to specify preferred panel position before declaring preferred panel position.

Finally, it configures and makes some additional tweaks by writing to files, and by using gsettings and dconf.


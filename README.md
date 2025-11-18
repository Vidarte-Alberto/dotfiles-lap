# Hyprland Wayland Dotfiles

Personal dotfiles for my Hyprland-based Wayland setup. It bundles window manager tweaks, launcher presets, terminal themes, bar modules, and logout theming that I rely on every day.

## Repository Layout
- `.config/hypr/` – modular Hyprland/Hypridle/Hyprlock setup (monitors, workspace rules, keybinds, scripts).
- `.config/waybar/` – Waybar config with weather, playerctl, bitcoin, tray, and utility drawers.
- `.config/kitty/` – Kitty sessions, themes, and defaults.
- `.config/rofi/` – custom launchers, scripts, and image assets.
- `.config/wlogout/` – themed logout screen based on Everforest.

## Requirements
To reproduce the full experience you need:
- Hyprland (>=0.39), Hypridle, Hyprlock, `wl-clipboard`, and `cliphist`.
- Waybar, SwayNotificationCenter (`swaync`), `swww`, `nm-applet`, `blueman-applet`, and `polkit-gnome`.
- Kitty, Ghostty (used by the update module), Rofi, and Wlogout.
- Apps wired to keybinds: Brave, Nautilus, Pavucontrol, Spicetify, playerctl/PipeWire, `paru`, and `ghostty`.
- Python 3 with `pip install requests pyquery` for the weather script.
- Fonts: JetBrainsMono Nerd Font Propo + Nerd Font symbols for icons.

## Using These Dotfiles
You can automate everything with `sync-dotfiles.sh` or perform the steps manually.

### Sync Script
```bash
./sync-dotfiles.sh        # rsync copy + automatic backup
./sync-dotfiles.sh --link # create symbolic links instead of copying
```
Useful flags:
- `--no-backup` skips the backup step.
- `--target=/path/to/.config` syncs into another directory.

### Manual Steps
1. **Clone** this repo wherever you prefer (`~/dotfiles-lap` is assumed below).
2. **Back up** your current `~/.config`, e.g. `cp -r ~/.config ~/.config.backup`.
3. **Sync** the directories you want:
   ```bash
   rsync -avh --progress ./\.config/hypr ~/.config/
   rsync -avh --progress ./\.config/{waybar,kitty,rofi,wlogout} ~/.config/
   ```
   You can also use symlinks: `ln -sfn ~/dotfiles-lap/.config/hypr ~/.config/hypr`, etc.
4. **Install dependencies** mentioned in the requirements (primary target distro: Arch/Artix—adapt to yours).
5. **Log into Hyprland** and confirm Waybar, Rofi, Kitty, and Wlogout start cleanly. Adjust `modules/monitors.conf` and `modules/programs.conf` for your displays and default apps.

## Quick Customizations
- **Displays & workspaces** – `.config/hypr/modules/monitors.conf`, `workspacerules.conf`.
- **Keybinds & default apps** – `.config/hypr/modules/keybinds.conf`, `programs.conf`.
- **Colors & themes** – `.config/waybar/style.css`, `.config/kitty/current-theme.conf`, `.config/rofi/launchers/`.
- **Weather module** – toggle automatic geolocation or hardcode a location in `.config/waybar/scripts/Weather.py`.

## Maintenance Tips
- Run `git pull` occasionally to fetch upstream tweaks.
- Keep personal edits on a separate branch so you can rebase/merge easily.
- After changing Hyprland modules or autostart scripts, run `hyprctl reload` (or restart the session) to apply the new config.

Happy hacking!

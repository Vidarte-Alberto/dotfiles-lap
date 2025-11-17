# Dotfiles para Hyprland + Wayland

Colección de configuraciones personales para mi entorno Wayland basado en Hyprland. Incluye los ajustes de la WM, terminal, barra, lanzadores y utilidades que uso a diario.

## Qué hay dentro
- `.config/hypr/`: configuración modular de Hyprland, Hypridle y Hyprlock (monitores, reglas de ventanas, atajos y scripts auxiliares).
- `.config/waybar/`: barra superior con módulos personalizados (weather, playerctl, bitcoin, utilidades).
- `.config/kitty/`: perfiles y temas del emulador de terminal.
- `.config/rofi/`: lanzadores y applets con modos personalizados.
- `.config/wlogout/`: pantalla de cierre de sesión con tema Everforest.

## Requisitos
Para reproducir el setup completo necesitas al menos:
- Hyprland (>=0.39), Hypridle, Hyprlock y `wl-clipboard`/`cliphist`.
- Waybar, SwayNotificationCenter (`swaync`), `swww`, `nm-applet`, `blueman-applet` y `polkit-gnome`.
- Kitty, Ghostty (para el módulo de actualizaciones), Rofi y Wlogout.
- Aplicaciones que abren muchos atajos por defecto: Brave, Nautilus, Pavucontrol, Spicetify, playerctl/pipewire, `paru` (para el módulo de actualizaciones) y `ghostty`.
- Python 3 + pip y los paquetes `requests` y `pyquery` para el módulo de clima.
- Fuentes: JetBrainsMono Nerd Font (Propo) y símbolos Nerd para los íconos de Waybar, Rofi y Wlogout.

## Cómo usarlos
Puedes automatizar todo con `./sync-dotfiles.sh` (ver abajo) o seguir los pasos manuales.

### Script de sincronización
```bash
./sync-dotfiles.sh        # copia con rsync y crea backup automático
./sync-dotfiles.sh --link # crea enlaces simbólicos en lugar de copiar
```
Opciones útiles:
- `--no-backup` para omitir el respaldo previo.
- `--target=/ruta/al/.config` para sincronizar hacia otra carpeta.

### Pasos manuales
1. **Clonar** el repo en tu máquina (`~/dotfiles-lap` o la ruta de preferencia).
2. **Respaldar** tu `~/.config` actual, p. ej. `cp -r ~/.config ~/.config.backup`.
3. **Sincronizar** los directorios deseados:
   ```bash
   rsync -avh --progress ./\.config/hypr ~/.config/
   rsync -avh --progress ./\.config/{waybar,kitty,rofi,wlogout} ~/.config/
   ```
   También puedes crear enlaces simbólicos si prefieres mantener el repo versionado: `ln -sfn ~/dotfiles-lap/.config/hypr ~/.config/hypr`, etc.
4. **Instalar dependencias** listadas arriba (distribución principal: Arch/Artix, pero ajusta los comandos a tu distro).
5. **Iniciar sesión en Hyprland** y valida que Waybar, Rofi, Kitty y Wlogout arrancan sin errores. Ajusta `modules/monitors.conf` y `modules/programs.conf` a tus necesidades (monitores, apps por defecto, rutas).

## Personalización rápida
- **Monitores y workspaces**: edita `.config/hypr/modules/monitors.conf` y `workspacerules.conf`.
- **Atajos y apps por defecto**: `.config/hypr/modules/keybinds.conf` y `programs.conf`.
- **Colores y temas**: `.config/waybar/style.css`, `.config/kitty/current-theme.conf`, `.config/rofi/launchers`.
- **Módulo de clima**: si quieres coordenadas fijas, edita `Weather.py` y desactiva `get_location()` como indica el comentario en el script.

## Actualizaciones
- Usa `git pull` para traer nuevos cambios.
- Si haces modificaciones locales, comítalas en una rama propia para tener tu historial.
- Cada vez que cambies scripts que se ejecutan en Hyprland (por ejemplo en `modules/autostart.conf`), reinicia Hyprland (`Super+Shift+Q`) o ejecuta `hyprctl reload` para aplicar los cambios.

¡Listo! Con esto deberías tener una base sólida para replicar y versionar tu entorno Wayland.

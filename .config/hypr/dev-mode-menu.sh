#!/bin/bash
set -e

CHOICE=$(printf "🍃 Ambrosia\n🧪 Morciz\n❌ Cancelar" |
  rofi -dmenu -p "Dev Environment" -theme ~/.config/rofi/launchers/styles/style-2.rasi)

case "$CHOICE" in
"🍃 Ambrosia") source ~/code/ambrosia.sh ;;
"🧪 Morciz") source ~/code/morciz.sh ;;
*) echo "Cancelado" ;;
esac

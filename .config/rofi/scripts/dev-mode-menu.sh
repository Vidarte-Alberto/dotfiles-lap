#!/bin/bash
set -e

CHOICE=$(printf "Ambrosia\nMorciz" | rofi -dmenu -p "Development Mode:")

case "$CHOICE" in
"Ambrosia")
  # Apaga HDMI y deja solo la pantalla del laptop
  source ~/code/ambrosia.sh
  ;;

"Morciz")
  # Activa HDMI y posiciona a la derecha de eDP
  source ~/code/morciz.sh
  ;;

*)
  echo "Cancelado"
  ;;
esac

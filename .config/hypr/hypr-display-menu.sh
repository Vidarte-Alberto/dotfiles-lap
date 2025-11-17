#!/bin/bash

CHOICE=$(printf "Solo Laptop\nExtender Pantallas" | rofi -dmenu -p "Configurar pantalla:")

case "$CHOICE" in
"Solo Laptop")
  # Apaga HDMI y deja solo la pantalla del laptop
  hyprctl keyword monitor "HDMI-A-1,disable"
  hyprctl keyword monitor "eDP-1,1920x1080@144,0x0,1"
  ;;

"Extender Pantallas")
  # Activa HDMI y posiciona a la derecha de eDP
  hyprctl keyword monitor "eDP-1,1920x1080@144,0x0,1"
  hyprctl keyword monitor "HDMI-A-1,1920x1080@60,1920x0,1"
  ;;

*)
  echo "Cancelado"
  ;;
esac

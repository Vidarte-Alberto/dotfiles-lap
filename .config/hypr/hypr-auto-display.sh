#!/bin/bash

# Detecta si HDMI está conectado
if hyprctl monitors | grep -q "HDMI-A-1"; then
  echo "HDMI conectado, extendiendo escritorio..."

  hyprctl keyword monitor "eDP-1,1920x1080@144.02,0x0,1"
  hyprctl keyword monitor "HDMI-A-1,1920x1080@60.00,1920x0,1"
else
  echo "Solo pantalla del laptop..."

  hyprctl keyword monitor "HDMI-A-1,disable"
  hyprctl keyword monitor "eDP-1,1920x1080@144.02,0x0,1"
fi

#!/usr/bin/env bash
set -euo pipefail

DOTFILES=(hypr waybar kitty rofi wlogout)
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="${REPO_ROOT}/.config"
TARGET_DIR="${HOME}/.config"
BACKUP=true
MODE="copy"

usage() {
  cat <<'USAGE'
Uso: ./sync-dotfiles.sh [opciones]

Opciones:
  --copy          (por defecto) Copia los directorios usando rsync.
  --link          Crea enlaces simbólicos en lugar de copiar.
  --no-backup     No mueve los directorios actuales a un backup.
  --target=RUTA   Ruta alternativa al ~/.config actual.
  -h, --help      Muestra esta ayuda.
USAGE
}

log() { printf "[sync-dotfiles] %s\n" "$*"; }

require_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Error: se requiere el comando '$1'" >&2
    exit 1
  fi
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --copy)
      MODE="copy"
      shift
      ;;
    --link)
      MODE="link"
      shift
      ;;
    --no-backup)
      BACKUP=false
      shift
      ;;
    --target=*)
      TARGET_DIR="${1#*=}"
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Opción desconocida: $1" >&2
      usage
      exit 1
      ;;
  esac
fi

if [[ ! -d "$SOURCE_DIR" ]]; then
  echo "No se encontró ${SOURCE_DIR}. Ejecuta el script desde el repositorio de dotfiles." >&2
  exit 1
fi

mkdir -p "$TARGET_DIR"

if [[ "$MODE" == "copy" ]]; then
  require_cmd rsync
fi

if $BACKUP; then
  timestamp=$(date +%Y%m%d-%H%M%S)
  BACKUP_DIR="${TARGET_DIR}.backup-${timestamp}"
  mkdir -p "$BACKUP_DIR"
  for dir in "${DOTFILES[@]}"; do
    if [[ -e "${TARGET_DIR}/${dir}" ]]; then
      log "Respaldando ${TARGET_DIR}/${dir} -> ${BACKUP_DIR}/${dir}"
      mv "${TARGET_DIR}/${dir}" "${BACKUP_DIR}/${dir}"
    fi
  done
  log "Backup guardado en ${BACKUP_DIR}"
else
  log "Backup deshabilitado"
fi

for dir in "${DOTFILES[@]}"; do
  src="${SOURCE_DIR}/${dir}"
  dst="${TARGET_DIR}/${dir}"

  if [[ ! -d "$src" ]]; then
    log "Saltando ${dir}: no existe en el repositorio"
    continue
  fi

  if [[ "$MODE" == "copy" ]]; then
    log "Copiando ${dir} -> ${dst}"
    mkdir -p "$dst"
    rsync -avh --delete "$src/" "$dst/"
  else
    log "Creando enlace simbólico ${dst} -> ${src}"
    ln -sfn "$src" "$dst"
  fi

done

log "Listo. Reinicia Hyprland o ejecuta 'hyprctl reload' para aplicar cambios."

#!/bin/bash

# ========== Konfigurasi ========== #
PANEL_DIR="/var/www/pterodactyl"
REPO_URL="https://github.com/rexoffcmarket/ThemePterodactyl.git"
TMP_DIR="/tmp/ptero-theme-install"
# ================================= #

echo ">>> [1/5] Membersihkan folder sementara..."
rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR"

echo ">>> [2/5] Meng-clone tema dari GitHub..."
git clone "$REPO_URL" "$TMP_DIR"

if [ ! -d "$TMP_DIR/public" ]; then
    echo "!!! Folder public tidak ditemukan di repo."
    exit 1
fi

echo ">>> [3/5] Membackup folder public lama..."
cp -r "$PANEL_DIR/public" "$PANEL_DIR/public-backup-$(date +%s)"

echo ">>> [4/5] Menyalin file tema ke panel..."
cp -r "$TMP_DIR/public/"* "$PANEL_DIR/public/"

echo ">>> [5/5] Membersihkan cache Laravel..."
cd "$PANEL_DIR" || exit
php artisan view:clear
php artisan config:clear
php artisan cache:clear

echo ">>> Instalasi tema selesai!"
echo "Silakan refresh halaman panel Anda."

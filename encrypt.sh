#!/usr/bin/env bash
# Re-encrypt each decrypted dashboard folder into <name>/<name>.tar.gz.enc. Usage: ./encrypt.sh [keyfile]
set -euo pipefail
cd "$(dirname "$0")"
KEY="${1:-dashboards.key}"
[ -f "$KEY" ] || { echo "Key file '$KEY' not found."; exit 1; }
for d in bachmai tranphu vtm rangdong; do
  [ -f "$d/package.json" ] || { echo "Skipping $d (not decrypted)"; continue; }
  echo "Encrypting $d ..."
  tar --exclude=node_modules --exclude=dist --exclude="$d.tar.gz.enc" -czf - "$d" \
    | openssl enc -aes-256-cbc -pbkdf2 -iter 600000 -salt -pass "file:$KEY" -out "$d/$d.tar.gz.enc.tmp"
  mv "$d/$d.tar.gz.enc.tmp" "$d/$d.tar.gz.enc"
done

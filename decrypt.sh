#!/usr/bin/env bash
# Decrypt every <name>/<name>.tar.gz.enc in place. Usage: ./decrypt.sh [keyfile]
set -euo pipefail
cd "$(dirname "$0")"
KEY="${1:-dashboards.key}"
[ -f "$KEY" ] || { echo "Key file '$KEY' not found. See README.md."; exit 1; }
for d in bachmai tranphu vtm rangdong; do
  echo "Decrypting $d ..."
  openssl enc -d -aes-256-cbc -pbkdf2 -iter 600000 -pass "file:$KEY" -in "$d/$d.tar.gz.enc" | tar -xzf -
done
echo "Done. See <folder>/SETUP.md to run each dashboard."

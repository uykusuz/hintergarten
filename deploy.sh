#!/usr/bin/env bash
# Upload index.html to the web root on laube.
set -euo pipefail

HOST="bobbel@laube"
REMOTE_DIR="/var/www/hintergarten.de/html"
FILE="index.html"

cd "$(dirname "$0")"

if [[ ! -f "$FILE" ]]; then
  echo "error: $FILE not found in $(pwd)" >&2
  exit 1
fi

# Upload to a temp file first, then move into place so the live file is never half-written.
scp -q "$FILE" "$HOST:$REMOTE_DIR/.$FILE.tmp"
ssh "$HOST" "chmod 644 '$REMOTE_DIR/.$FILE.tmp' && mv '$REMOTE_DIR/.$FILE.tmp' '$REMOTE_DIR/$FILE'"

echo "Deployed $FILE to $HOST:$REMOTE_DIR/$FILE"

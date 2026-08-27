#! /bin/bash

set -e

cat $0

APP="$1"

test -n "$APP"
test -n "$DEMO"
test -n "$VER"

cd ./projects/$APP

if echo "$APP"|grep -qv "^bfc$"; then
  if ! command -v ffmpeg; then
    if $DEMO; then
      apt update || true
      apt install -y ffmpeg
    else
      brew install ffmpeg
    fi
  fi
fi
pip install -r requirements.txt
if echo "$APP"|grep -q "^diarix$"; then
  $DEMO || command -v whispermlx || pip install whispermlx
fi

log python$VER app.py & pid=$!
sleep 20
test -d /proc/$pid


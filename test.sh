#! /bin/bash

set -e

APP="$1"

test -n "$APP"
test -n "$DEMO"
test -n "$VER"

cd ./projects/$APP

if echo "$APP"|grep -qv "^bfc$"; then
  if ! command -v ffmpeg &>/dev/null; then
    if $DEMO; then
      apt update &>/dev/null || true
      apt install -y ffmpeg &>/dev/null
    else
      brew install ffmpeg &>/dev/null
    fi
  fi
fi
pip install -r requirements.txt &>/dev/null
if echo "$APP"|grep -q "^diarix$"; then
  $DEMO || command -v whispermlx &>/dev/null || pip install whispermlx &>/dev/null
fi

python$VER app.py & pid=$!
sleep 20
test -d /proc/$pid


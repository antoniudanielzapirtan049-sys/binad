! /bin/bash

set -e

cat $0

APPS="$(ls projects)"
: ${AUDIT:=false}
ARG="$1"
OS="$(uname)"
PORTS="5030 5034 5005"
VER="3.12"

DEMO=false
if echo "$OS"|grep -q "^Linux$"; then
	DEMO=true
fi
$DEMO && VER="3.13"

test -n "$APPS"
test -n "$DEMO"
test -n "$OS"
test -n "$PORTS"
test -n "$VER"

export DEMO VER

flaskill() {
for PORT in $PORTS; do
  pids="$(lsof -i ":$PORT"|sed -n '2,$p' |cut -f 2)"
  test -n "$pids" && for pid in $pids; do
    test -n "$pid" && test -d /proc/$pid && kill -15 $pid
  done
done
}

purge_pip() {
  flaskill
  command -v deactivate && deactivate || true
  rm -rf $HOME/.cache/pip || true
  rm -rf .venv venv || true
  python$VER -m venv .venv
  source .venv/bin/activate
  test -n "$VIRTUAL_ENV"
  test -d "$VIRTUAL_ENV"
  export VIRTUAL_ENV
  pip install --upgrade pip || true
}

direct_pip() {
  flaskill
  command -v deactivate && deactivate || true
  test -d .venv || python$VER -m venv .venv
  source .venv/bin/activate || return
  test -n "$VIRTUAL_ENV"
  test -d "$VIRTUAL_ENV"
  export VIRTUAL_ENV
}

launch_apps() {
  for APP in $APPS; do
    test -n "$APP"
    bash test.sh "$APP"
  done
}

warm=false
echo "Please wait ..."
if $warm; then
  if direct_pip && launch_apps; then
    true
  else
    purge_pip && launch_apps
  fi
else
  purge_pip && launch_apps
fi

echo "All apps have been launched"
echo "See them on ports 5030, 5034 and 5005"
echo "Done."

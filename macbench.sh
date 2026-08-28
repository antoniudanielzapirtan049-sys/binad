! /bin/bash

set -e

cat $0

AUDIT=true
: ${DEMO:=false}
VER="3.12"
$DEMO && VER="3.13"

export VER

purge_pip() {
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

DIR=$PWD

cd $DIR/projects/bfc
purge_pip
pip install -r requirements.txt

cd $DIR/projects/diarix
command -v brew && brew install ffmpeg
purge_pip
pip install -r requirements.txt
$DEMO || pip install whispermlx

cd $DIR/projects/vd
command -v brew && brew install ffmpeg
purge_pip
pip install -r requirements.txt


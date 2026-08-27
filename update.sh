#! /bin/bash

set -e

OWNER="CorneliuBoboc"
REPO="MONAD"
test -n "$OWNER"
test -n "$REPO"

cd $HOME
TARGETDIR=$HOME/.backups/
mkdir -p $TARGETDIR/
tar -C $HOME -czf $TARGETDIR/${REPO}_$(date +%y%m%d_%H%M%S).tar.gz $REPO
rm -rf $REPO
git clone https://github.com/$OWNER/$REPO.git
cd $REPO
bash lau.sh


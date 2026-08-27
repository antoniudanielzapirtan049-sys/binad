#! /bin/bash

set -e

cat $0

DATE=$(date +%y%m%d_%H%M%S_%N)
OWNER=CorneliuBoboc
REPO=MONAD
TARGETDIR=$HOME/.backups/

test -n "$DATE"
test -n "$OWNER"
test -n "$REPO"
test -n "$TARGETDIR"

cd $HOME
mkdir -p $TARGETDIR/
tar -C $HOME -czf $TARGETDIR/${REPO}_$DATE.tar.gz $REPO
rm -rf $REPO
git clone https://github.com/$OWNER/$REPO.git
cd $REPO
bash lau.sh


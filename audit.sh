#! /bin/bash

LOG=$HOME/log.txt
: >$LOG
./log $@ &
tail -f $LOG &
echo ""
echo "Done"

#! /bin/bash

LOG=$HOME/log.txt
: >$LOG
./log $@ &
tail -f $LOG &
wait
echo ""
echo "Done"

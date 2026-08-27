#! /bin/bash

LOG=$HOME/log.txt
: >$LOG
bash log lau.sh --cold &
tail -f $LOG

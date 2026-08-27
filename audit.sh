#! /bin/bash

LOG=$HOME/log.txt
: >$LOG
log lau.sh --cold &
tail -f $LOG

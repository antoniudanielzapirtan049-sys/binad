#! /bin/bash

export AUDIT=true
LOG=$HOME/log.txt
: >$LOG
RAW=$HOME/raw.txt
stamp() {
len=$1
newlen=$2
len1=$(($len + 1))
for n in $(seq $len1 $newlen); do
DATE="$(date +%s%N)"
LINE="$(cat $RAW|head -n $n|tail -n 1)" || true
test -n "$LINE" && echo "$DATE	$LINE" >>$LOG
done >>$LOG
}
len=0
bash lau.sh &>$RAW & pid=$!
tail -f $LOG &
while true; do
newlen=$(cat $RAW|wc -l)
if [ $newlen -gt $len ]; then
stamp $len $newlen
len=$newlen
fi
sleep 0.02
test -d /proc/$pid || break
done
wait
echo ""
echo "Done"

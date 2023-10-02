#! /bin/bash

if [ -z "${DCLITIMESTAMP}" ]
then
    DCLITIMESTAMP=$(date -d '1 day ago' +%s000)
fi

while true
do
    DCLIRESULT=$(dcli t l --start $DCLITIMESTAMP --end now)
    echo $DCLIRESULT | /opt/fluent-bit/bin/fluent-bit -c $DCLIFLUENTBITPATH -q
    DCLITIMESTAMP=$(echo $DCLIRESULT | jq '.date_time' | head -n1)
    sleep 300
done
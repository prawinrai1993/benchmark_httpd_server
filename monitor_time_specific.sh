#!/bin/bash


#!/bin/bash    
psrecord $(pgrep httpd_server) --interval 1 --duration 300 --plot monitor_data.png &
P1=$!

runtime="5 minute"
endtime=$(date -ud "$runtime" +%s)

while [[ $(date -u +%s) -le $endtime ]]
do
    echo "Time Now: `date +%H:%M:%S`"
    ab -n 50000 -c 100 http://localhost:8888/ > output.txt &
    P2=$!
    wait $P2
done


wait $P1
echo 'Done'

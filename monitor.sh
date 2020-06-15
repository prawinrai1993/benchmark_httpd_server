#!/bin/bash    
psrecord $(pgrep httpd_server) --interval 1 --duration 150 --plot monitor_data.png &
P1=$!

for i in {1..10}
do
   ab -n 50000 -c 100 http://localhost:8888/ > output.txt &
   P2=$!
   wait $P2
   echo "cycle number $i... "
done

wait $P1
echo 'Done'

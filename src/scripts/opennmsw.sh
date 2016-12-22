#!/bin/bash

# This script is run by Supervisor to start/stop OpenNMS in foreground mode
stop() {
   echo "OpenNMS is stopping..." >> /tmp/opennms.log
   PID=$(pgrep -f '/opt/opennms/lib/opennms_bootstrap.jar start')
   while [ ! -z "$PID" ]; do
     echo "OpenNMS ($PID) is stopping..." >> /tmp/opennms.log
     /opt/opennms/bin/opennms stop
     sleep 60
     sudo kill -9 $PID
     PID=$(pgrep -f '/opt/opennms/lib/opennms_bootstrap.jar start')
   done
   exit 0
}

trap stop HUP INT QUIT ABRT KILL ALRM TERM TSTP

start() {
   echo "OpenNMS is starting..."
   #/opt/opennms/bin/opennms -f start
   /opt/opennms/bin/opennms start
   while true; do
     sleep 1
   done
}

start

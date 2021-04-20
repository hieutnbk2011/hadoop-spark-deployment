#!/bin/bash
service ssh start
printenv > ~/printenv.sh
echo $SSH_PUBLIC_KEY >> ~/.ssh/authorized_keys
case $SPARK_MODE in
  MASTER)
    start-master
    mkdir -p /tmp/spark-events
    start-history-server
    ;;
  WORKER)
    start-worker $SPARK_MASTER
    ;;
  *)
    echo you need to set a mode
    exit 0
    ;;
esac
tail -f /opt/spark/logs/*.out

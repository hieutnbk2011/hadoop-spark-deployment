#!/bin/bash

service ssh start
chown -R hadoop:hadoop /home/hadoop
if [ ! -f "/home/hadoop/mydata/hdfs/installed" ]; then
	runuser -u hadoop -- mkdir -p /home/hadoop/mydata/hdfs/namenode /home/hadoop/mydata/datanode
	runuser -u hadoop -- $HADOOP_HOME/bin/hdfs namenode -format
	touch /home/hadoop/mydata/hdfs/installed
fi

runuser -u hadoop -- $HADOOP_HOME/sbin/start-dfs.sh
runuser -u hadoop -- $HADOOP_HOME/sbin/start-yarn.sh
if runuser -u hadoop -- $HADOOP_HOME/bin/hadoop fs -ls /data &>/dev/null
then
  echo Data folder exists
else 
  echo Create data folder
  runuser -u hadoop -- $HADOOP_HOME/bin/hadoop fs -mkdir /data
fi


tail -f /home/hadoop/hadoop/logs/hadoop-hadoop-datanode*.log

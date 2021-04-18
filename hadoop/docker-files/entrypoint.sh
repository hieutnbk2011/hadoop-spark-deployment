#!/bin/bash

sudo service ssh start

if [ ! -d "/home/hadoop/mydata/hdfs/installed" ]; then
        $HADOOP_HOME/bin/hdfs namenode -format
	$HADOOP_HOME/bin/hadoop fs -mkdir /data
	touch /home/hadoop/mydata/hdfs/installed
fi

$HADOOP_HOME/sbin/start-dfs.sh
$HADOOP_HOME/sbin/start-yarn.sh

/usr/bin/supervisord

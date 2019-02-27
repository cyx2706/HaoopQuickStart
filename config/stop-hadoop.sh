#!/bin/bash
set -e

echo -e "\n"

sh $HADOOP_HOME/sbin/stop-yarn.sh

echo -e "\n"

sh $HADOOP_HOME/sbin/stop-dfs.sh

echo -e "\n"

sh $HADOOP_HOME/sbin/mr-jobhistory-daemon.sh stop historyserver

echo -e "\n"
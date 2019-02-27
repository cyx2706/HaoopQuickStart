#!/bin/bash
set -e

echo -e "\n"

sh $HADOOP_HOME/sbin/stop-yarn.sh

echo -e "\n"

sh $HADOOP_HOME/sbin/stop-dfs.sh

echo -e "\n"

sh $HADOOP_HOME/sbin/start-dfs.sh

echo -e "\n"

sh $HADOOP_HOME/sbin/start-yarn.sh

echo -e "\n"
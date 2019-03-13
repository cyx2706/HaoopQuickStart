#!/bin/bash
#使用方法
set -e
config_path="./config"
for node in $*
do
    scp_remote="root@$node"
    echo -e "\n"
    echo "updating $scp_remote's hadoop configuration...."
    scp $config_path/ssh_config $scp_remote:~/.ssh/config
    scp $config_path/hadoop-env.sh $scp_remote:$HADOOP_HOME/etc/hadoop/hadoop-env.sh
    scp $config_path/hdfs-site.xml $scp_remote:$HADOOP_HOME/etc/hadoop/hdfs-site.xml
    scp $config_path/core-site.xml $scp_remote:$HADOOP_HOME/etc/hadoop/core-site.xml
    scp $config_path/mapred-site.xml $scp_remote:$HADOOP_HOME/etc/hadoop/mapred-site.xml
    scp $config_path/yarn-site.xml $scp_remote:$HADOOP_HOME/etc/hadoop/yarn-site.xml
    scp $config_path/slaves $scp_remote:$HADOOP_HOME/etc/hadoop/slaves
    scp $config_path/start-hadoop.sh $scp_remote:~/start-hadoop.sh
    scp $config_path/stop-hadoop.sh $scp_remote:~/stop-hadoop.sh
    scp $config_path/restart-hadoop.sh $scp_remote:~/restart-hadoop.sh
    scp $config_path/run-wordcount.sh $scp_remote:~/run-wordcount.sh
done
echo -e "\n"
echo "hadoop configuration updated!"
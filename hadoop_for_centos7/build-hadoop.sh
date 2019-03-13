#!/bin/bash
set -e

current_path=`pwd`

echo "shutdown the fire wall"
#¹Ø±Õ·À»ðÇ½
systemctl stop firewalld
systemctl disable firewalld

echo "building java ..."
tar -xzvf $current_path/jdk-8u201-linux-x64.tar.gz -C ~/
mv ~/jdk1.8.0_201 /usr/local/jdk1.8.0_201

echo "JAVA_HOME=/usr/local/jdk1.8.0_201" >> /etc/profile
echo "JRE_HOME=\$JAVA_HOME/jre" >> /etc/profile
echo "CLASS_PATH=.:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar:\$JRE_HOME/lib" >> /etc/profile
echo "PATH=\$PATH:\$JAVA_HOME/bin:\$JRE_HOME/bin" >> /etc/profile
source /etc/profile
mkdir /usr/lib/jvm
ln -s $JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

echo "ready to build hadoop ..."
yum install wget -y
wget https://github.com/kiwenlau/compile-hadoop/releases/download/2.7.2/hadoop-2.7.2.tar.gz
tar -xzvf hadoop-2.7.2.tar.gz && \
    mv hadoop-2.7.2 /usr/local/hadoop && \
    rm hadoop-2.7.2.tar.gz

echo "building hadoop path ..."
echo "HADOOP_HOME=/usr/local/hadoop" >> /etc/profile
echo "PATH=\$PATH:/usr/local/hadoop/bin:/usr/local/hadoop/sbin" >> /etc/profile
source /etc/profile

mkdir -p ~/hdfs/namenode && \
mkdir -p ~/hdfs/datanode && \
mkdir $HADOOP_HOME/logs


config_path="$current_path/../config"

\cp $config_path/ssh_config ~/.ssh/config && \
    \cp $config_path/hadoop-env.2.0.sh /usr/local/hadoop/etc/hadoop/hadoop-env.sh && \
    \cp $config_path/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml && \
    \cp $config_path/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml && \
    \cp $config_path/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml && \
    \cp $config_path/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml && \
    \cp $config_path/slaves $HADOOP_HOME/etc/hadoop/slaves && \
    \cp $config_path/start-hadoop.sh ~/start-hadoop.sh && \
    \cp $config_path/stop-hadoop.sh ~/stop-hadoop.sh && \
    \cp $config_path/restart-hadoop.sh ~/restart-hadoop.sh && \
    \cp $config_path/run-wordcount.sh ~/run-wordcount.sh

chmod +x ~/start-hadoop.sh && \
    chmod +x ~/stop-hadoop.sh && \
    chmod +x ~/restart-hadoop.sh && \
    chmod +x ~/run-wordcount.sh && \
    chmod +x $HADOOP_HOME/sbin/start-dfs.sh && \
    chmod +x $HADOOP_HOME/sbin/start-yarn.sh

# format namenode
$HADOOP_HOME/bin/hdfs namenode -format
echo "hadoop build success!"
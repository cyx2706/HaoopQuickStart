#!/bin/bash



set -e

echo "shutdown the fire wall"
#¹Ø±Õ·À»ðÇ½
systemctl stop firewalld
systemctl disable firewalld

echo "building java ..."
yum install java-1.7.0-openjdk-devel.x86_64 -y
echo "JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.201-2.6.16.1.el7_6.x86_64" >> /etc/profile
echo "JRE_HOME=\$JAVA_HOME/jre" >> /etc/profile
echo "CLASS_PATH=.:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib" >> /etc/profile
echo "PATH=\$PATH:\$JAVA_HOME/bin:\$JRE_HOME/bin" >> /etc/profile
source /etc/profile
ln -s $JAVA_HOME $JAVA_HOME/../java-7-openjdk-amd64

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


config_path="../config"

\cp $config_path/ssh_config ~/.ssh/config && \
    \cp $config_path/hadoop-env.sh /usr/local/hadoop/etc/hadoop/hadoop-env.sh && \
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
    chmod +x ~/run-wordcount.sh && \
    chmod +x $HADOOP_HOME/sbin/start-dfs.sh && \
    chmod +x $HADOOP_HOME/sbin/start-yarn.sh

# format namenode
/usr/local/hadoop/bin/hdfs namenode -format
echo "hadoop build success!"
exit 1
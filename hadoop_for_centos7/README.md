# HaoopQuickStart for hadoop
- 运行方式：
    1. 配置好各个节点之间的ssh免密登录，略
    2. 配置好各个节点的hosts文件，至少需要配置的节点：hadoop-master + hadoop-slave1 + hadoop-slave2, 略
    3. 在各个节点的服务器上运行：**source** build-hadoop.sh
# 声明
- 本项目中大部分脚本是在KiwenLau（kiwenlau@126.com）大神的《基于Docker搭建Hadoop集群之升级版》上的项目修改及优化而成
- 详见：https://kiwenlau.com/2016/06/12/160612-hadoop-cluster-docker-update/
# 改动概述
- 将源项目的Dockerfile修改为适合centos7的build-hadoop.sh
- 添加了update-config.sh，更加方便快速更新配置文件到各个节点使用方法: **source** update-config.sh hadoop-master hadoop-slave1 hadoop-slave2 ...
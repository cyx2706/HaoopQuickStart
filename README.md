# HaoopQuickStart
快速搭建hadoop，提供Centos(7.6版本最优)及docker两种方式
# 声明
- 本项目中大部分脚本是在KiwenLau（kiwenlau@126.com）大神的《基于Docker搭建Hadoop集群之升级版》上的项目修改及优化而成
- 详见：https://kiwenlau.com/2016/06/12/160612-hadoop-cluster-docker-update/
# 改动概述
- 修改了源项目中的Dockerfile:
    1. 更换了sources.list(使用了国内源）,使镜像建立速度更快；
- 修改了源项目中的容器run脚本:
    1. 添加了:run前先建立hadoop的network（centos执行脚本会时提示不存在名为hadoop的network...)
    2. 更改了：使用了静态ip
    3. 添加了：容器建立成功后马上执行hadoop启动脚本
- 修改了start-hadoop.sh:
    1. 添加了：启动historyserver，更加方便查看已完成的Appliction历史情况
- 修改了yarn.xml:
    1. 添加了yarn.log-aggregation-enable属性，更方便hadoop保存已完成任务的日志到hdfs
- 添加了一些更方便的脚本，如重启、关停hadoop脚本
- 修改了mapred-site.xml:
    1. 添加了任务完成回调属性等
# 其他
- 详见hadoop_for_centos7.6及hadoop_for_docker下README.md
- 或联系 cyx2706@163.

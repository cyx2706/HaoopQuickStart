echo "starting hadoop-master container..."
sudo docker start hadoop-master

echo "starting hadoop-slave1 container..."
sudo docker start hadoop-slave1

echo "starting hadoop-slave2 container..."
sudo docker start hadoop-slave2

echo "starting hadoop ...."
sudo docker exec -it "hadoop-master" /bin/sh /root/start-hadoop.sh
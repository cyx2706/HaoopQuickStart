#!/bin/bash

# the default node number is 3
N=${1:-3}

sudo docker network create --subnet=172.18.0.0/16 hadoop &> /dev/null

# start hadoop master container
sudo docker rm -f hadoop-master &> /dev/null
echo "start hadoop-master container..."
sudo docker run -itd \
		-v /media/sf_scrapy_sources:/var/python \
		--net=hadoop \
		--ip 172.18.0.2 \
		-p 50070:50070 \
        -p 8088:8088 \
        --name hadoop-master \
        --hostname hadoop-master \
        kiwenlau/hadoop:1.0

# start hadoop slave container
i=1
while [ $i -lt $N ]
do
	j=$(( $i + 2 ))
	sudo docker rm -f hadoop-slave$i &> /dev/null
	echo "start hadoop-slave$i container..."
	sudo docker run -itd \
			-v /media/sf_scrapy_sources:/var/python \
			--net=hadoop \
		    --ip 172.18.0.$j \
	        --name hadoop-slave$i \
	        --hostname hadoop-slave$i \
	        kiwenlau/hadoop:1.0
	i=$(( $i + 1 ))
done 

# start hadoop in container
echo "starting hadoop ...."
sudo docker exec -it "hadoop-master" /bin/sh /root/start-hadoop.sh

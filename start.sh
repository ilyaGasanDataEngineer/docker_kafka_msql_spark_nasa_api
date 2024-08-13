#!/bin/sh

nohup /opt/kafka/bin/zookeeper-server-start.sh /opt/kafka/config/zookeeper.properties &

# Ожидание запуска ZooKeeper
sleep 5

# Запуск Kafka
nohup /opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties &


nohup /opt/kafka/bin/kafka-topics.sh --create --topic my_topic --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1

# Ожидание запуска Kafka
sleep 5

# Запуск вашего Python проекта
python app.py

python kafka_consumers/fireball_consumer.py

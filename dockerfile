FROM python:3.9-slim

# Установка необходимых пакетов для Kafka
RUN apt-get update && \
    apt-get install -y wget curl gnupg2 software-properties-common && \
    apt-get install -y default-jre-headless

ENV KAFKA_VERSION=3.7.0
ENV SCALA_VERSION=2.13
RUN wget https://downloads.apache.org/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz && \
    tar -xvzf kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz && \
    mv kafka_${SCALA_VERSION}-${KAFKA_VERSION} /opt/kafka && \
    rm kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz

ENV PATH="/opt/kafka/bin:$PATH"

# Копирование файлов в контейнер
COPY . .

# Установка зависимостей Python
RUN pip install --no-cache-dir -r requirements.txt

# Копирование скрипта запуска и установка прав на выполнение
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Открытие порта для Kafka
EXPOSE 9092
EXPOSE 5000

# Указание команды по умолчанию для запуска
CMD ["/start.sh"]


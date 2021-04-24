FROM python:3.8-slim-buster
RUN apt-get update && apt-get install -y openssh-server openssh-client sudo wget openjdk-11-jre openjdk-11-jdk scala git procps rsync vim
RUN pip3 install numpy==1.16.1 pandas scikit-learn sklearn pyspark matplotlib
#Setup SSH
COPY ssh_config /etc/ssh/ssh_config
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && chmod 0600 ~/.ssh/authorized_keys
#Download and setup Spark
WORKDIR /opt
RUN wget --progress=bar:force:noscroll http://mirror.easyname.ch/apache/spark/spark-3.1.1/spark-3.1.1-bin-hadoop3.2.tgz && tar -zxf spark-3.1.1-bin-hadoop3.2.tgz && rm -f spark-3.1.1-bin-hadoop3.2.tgz && mv spark-3.1.1-bin-hadoop3.2 spark
ENV SPARK_HOME=/opt/spark
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin
ENV PYSPARK_PYTHON=/usr/local/bin/python3.8
ENV PYTHONPATH=/usr/local/bin/python3.8:/usr/local/lib/python3.8/site-packages
RUN echo "set -o allexport;. ~/printenv.sh &>/dev/null;cd" >> /root/.profile
RUN update-alternatives --install "/usr/sbin/start-master" "start-master" "/opt/spark/sbin/start-master.sh" 1
RUN update-alternatives --install "/usr/sbin/start-worker" "start-worker" "/opt/spark/sbin/start-worker.sh" 1
RUN update-alternatives --install "/usr/sbin/stop-worker" "stop-worker" "/opt/spark/sbin/stop-worker.sh" 1
RUN update-alternatives --install "/usr/sbin/spark-daemon.sh" "spark-daemon.sh" "/opt/spark/sbin/spark-daemon.sh" 1
RUN update-alternatives --install "/usr/sbin/spark-config.sh" "spark-config.sh" "/opt/spark/sbin/spark-config.sh" 1
RUN update-alternatives --install "/usr/bin/spark-shell" "spark-shell" "/opt/spark/bin/spark-shell" 1
RUN update-alternatives --install "/usr/bin/spark-class" "spark-class" "/opt/spark/bin/spark-class" 1
RUN update-alternatives --install "/usr/bin/spark-sql" "spark-sql" "/opt/spark/bin/spark-sql" 1
RUN update-alternatives --install "/usr/bin/spark-submit" "spark-submit" "/opt/spark/bin/spark-submit" 1
RUN update-alternatives --install "/usr/bin/pyspark" "pyspark" "/opt/spark/bin/pyspark" 1
RUN update-alternatives --install "/usr/bin/load-spark-env.sh" "load-spark-env.sh" "/opt/spark/bin/load-spark-env.sh" 1
RUN update-alternatives --install "/usr/sbin/start-history-server" "start-history-server" "/opt/spark/sbin/start-history-server.sh" 1
RUN echo "spark.eventLog.enabled           true" >> "/opt/spark/conf/spark-defaults.conf" 
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

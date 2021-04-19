FROM openjdk:11-jdk-buster
RUN apt-get update && apt-get install -y openssh-server sudo wget

#Install hadoop to user hadoop home directory 
RUN useradd -m hadoop && echo "hadoop:supergroup" | chpasswd && adduser hadoop sudo && echo "hadoop     ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers 
WORKDIR /home/hadoop
USER hadoop
RUN wget https://mirror.downloadvn.com/apache/hadoop/common/hadoop-3.2.2/hadoop-3.2.2.tar.gz && tar -zxvf hadoop-3.2.2.tar.gz && rm -f hadoop-3.2.2.tar.gz && mv hadoop-3.2.2 hadoop
ENV HDFS_NAMENODE_USER hadoop
ENV HDFS_DATANODE_USER hadoop
ENV HDFS_SECONDARYNAMENODE_USER hadoop
ENV YARN_RESOURCEMANAGER_USER hadoop
ENV YARN_NODEMANAGER_USER hadoop


ENV HADOOP_HOME /home/hadoop/hadoop
ENV PATH $PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

RUN echo "export JAVA_HOME=$JAVA_HOME" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh
COPY hadoop_config/core-site.xml $HADOOP_HOME/etc/hadoop/
COPY hadoop_config/hdfs-site.xml $HADOOP_HOME/etc/hadoop/
COPY hadoop_config/yarn-site.xml $HADOOP_HOME/etc/hadoop/

# Config SSH
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && chmod 0600 ~/.ssh/authorized_keys

COPY ssh_config /etc/ssh/ssh_config
# Change back to user root
USER root
# Add the entrypoint script
COPY docker-files/entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

#!/bin/bash
set +x

# start ssh server
/usr/sbin/sshd &

# format namenode
su hadoop -c "$HADOOP_HOME/bin/hdfs namenode -format"

# start hadoop
su hadoop -c "$HADOOP_HOME/sbin/start-dfs.sh"
su hadoop -c "$HADOOP_HOME/sbin/start-yarn.sh"
su hadoop -c "$HADOOP_HOME/sbin/mr-jobhistory-daemon.sh start historyserver"

#su hadoop -c "$HADOOP_HOME/bin/hdfs dfs -mkdir /user"
#su hadoop -c "$HADOOP_HOME/bin/hdfs dfs -mkdir /user/hadoop"


# keep container running
tail -f /dev/null
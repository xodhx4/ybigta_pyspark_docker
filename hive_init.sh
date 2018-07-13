service ssh start
$HADOOP_HOME/sbin/start-dfs.sh
$HADOOP_HOME/sbin/start-yarn.sh

hdfs dfs -mkdir -p /tmp/hive
hdfs dfs -mkdir -p /user/hive/warehouse
hdfs dfs -chmod g+w /tmp
hdfs dfs -chmod 777 /tmp/hive
hdfs dfs -chmod g+w /user/hive
hdfs dfs -chmod g+w /user/hive/warehouse

$HOME/hive/bin/schematool -initSchema -dbType derby
cp $HOME/hive/conf/hive-site.xml $HOME/spark/conf/

$HADOOP_HOME/sbin/stop-yarn.sh
$HADOOP_HOME/sbin/stop-dfs.sh
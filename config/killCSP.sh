#!/bin/sh


PROCESS=`ps -ef|grep csp |grep -v grep|grep -v PPID|awk '{ print $2}'`
for i in $PROCESS
do
  echo "Kill the $1 process [ $i ]"
  kill -9 $i
done
. /home/livebos/user_projects/domains/livebos/bin/start_cluster_csp_new1.sh
. /home/livebos/user_projects/domains/livebos/bin/start_cluster_csp_new2.sh

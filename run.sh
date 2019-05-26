#!/bin/bash

mongod &

if [ ! -f "/data/db/do_not_delete" ]; then
  echo "Initial mongo data"
  ret=0
  while true; do
    mongorestore -h localhost -d leanote --dir /root/leanote/mongodb_backup/leanote_install_data/
    ret=$?
    [ $ret == "0" ] && break || sleep 2
  done

  echo "do not delete this file" >> /data/db/do_not_delete
  chmod 400 /data/db/do_not_delete
fi

cp -n -r /root/leanote /data/

echo `date "+%Y-%m-%d %H:%M:%S"`' >>>>>> start leanote service'
/data/leanote/bin/run.sh

#!/bin/bash
export SENTINEL_HOSTNAME=$1
export REDIS_MASTER_HOSTNAME=$2
export REDIS_SLAVE_HOSTNAME=$3

if [ -z $SENTINEL_HOSTNAME ] || [ -z $REDIS_MASTER_HOSTNAME ] || [ -z $REDIS_SLAVE_HOSTNAME ] ; then
  echo "Argument missing" >&2
  exit 1;
fi

export SENTINEL_IP=`docker node inspect --format {{.Status.Addr}} $SENTINEL_HOSTNAME`
export REDIS_MASTER_IP=`docker node inspect --format {{.Status.Addr}} $REDIS_MASTER_HOSTNAME`

echo "Sentinel: $SENTINEL_HOSTNAME -  $SENTINEL_IP"
echo "Redis master: $REDIS_MASTER_HOSTNAME - $REDIS_MASTER_IP"
echo "Redis slave: $REDIS_SLAVE_HOSTNAME"

docker stack deploy -c redis-ha-stack.yml rha

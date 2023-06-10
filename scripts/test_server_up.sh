#!/bin/bash
url=$1
timeout=$2
frequency=$3

start_time=$(date +%s)
end_time=$(($start_time + $timeout))

while [ $(date +%s) -lt $end_time ]; do
  if curl --output /dev/null --silent --head "$url"; then
    echo "Server is up"
    exit 0
  else
    echo "Server is not yet up, sleeping for $frequency seconds..."
    sleep $frequency
  fi
done

echo "Server did not start within $timeout seconds"
exit 1

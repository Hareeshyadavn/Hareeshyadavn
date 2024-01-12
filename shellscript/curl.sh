#!/bin/bash
while read line; do
http_code=$(curl -s -o /dev/null -w "%{http_code}" $site)
if [[ $http_code -eq 200 ]]; then
	echo "up"
else
	echo "down"
fi
done < $1

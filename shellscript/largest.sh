#!/bin/bash

smallest=100
read -p "enter the limit value: " limit
for (( i=1; i<=$limit; i++ ))
do
	read -p "enter the i value : " num
	if [ $num -lt $smallest ]; then
		smallest=$num
	fi
done
echo "$smallest"


#!/bin/bash

read -p "enter the fn series for : " N
read -p "enter the first num fib : " a
read -p "enter the second numof fib: " b
echo "fibonacci series is : "
for (( i=0; i<=$N; i++))
do
	echo -n "$a"
	fn=$((a+b))
	a=$b
	b=$fn
done


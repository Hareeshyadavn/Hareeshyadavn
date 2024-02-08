#!/bin/bash
echo "$1"
if [ -e "/home/ubuntu/docker/folder.txt" ]; then
       find -maxdepth 1 -type f -name  "*.txt" | xargs -I{} cp {} /home/ubuntu/docker/folder.txt
else
 echo "$1 not exists"
fi
if [ -e "/home/ubuntu/docker/folder.pdf" ]; then
        find -maxdepth 1 -type f -name  "*.pdf" | xargs -I{} cp {} /home/ubuntu/docker/folder.pdf
else
        echo "$2 not exists"
fi

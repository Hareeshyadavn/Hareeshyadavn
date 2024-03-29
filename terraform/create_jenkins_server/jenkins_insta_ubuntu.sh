#!/bin/bash

#installing jenkins on ubuntu user
#to install on ubuntu, run this command
#curl -s <url of git file > | bash


echo -e "\n-------updating the linux-----\n"
sleep 2
sudo apt update

echo -e "\n-------installing java-----\n"
sleep 2
sudo apt -y install fontconfig openjdk-17-jre 

echo -e "\n-------checking the version of java-----\n"
sleep 2
java -version

echo -e "\n-------downloading jenkins installing packages to apt package list-----\n"
sleep 2
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo -e "\n-------printing the package list downloaded----------\n"
sleep 2
  echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null 
  
  echo -e "\n-------updating the linux-----\n"
  sleep 2
  sudo apt update
  
  echo -e "\n-------installing jenkins into linux machine-----\n"
  sleep 2
  sudo apt install -y jenkins
  
  echo -e "\n-------check the status of jenkins-----\n"
  
  sudo systemctl status jenkins
  
  echo -e "\n-------starting the linux--------\n"
  
  sudo systemctl start jenkins
  
  echo -e "\n-------printing the jenkins password stored in var/lib-----\n"
  
  sudo cat /var/lib/jenkins/secrets/initialAdminPassword

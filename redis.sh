#!/bin/bash

ID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE="/tmp/$0-$TIMESTAMP.log"
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"


echo "script started executing at $TIMESTAMP" &>> $LOGFILE

VALIDATE() {
    if [ $1 -ne 0 ]
    then 
     echo -e "$2 ... $R Failed $N"
    else
     echo -e " $2.... $G Success $N"
    fi
}

if [ $ID -ne 0 ]
then
 echo " Run with root user"
 exit 1
else 
 echo " you are root user"
fi

dnf install https://rpms.remirepo.net/enterprise/remi-release-8.6.rpm -y
VALIDATE $? "repo installation"

dnf module enable redis:remi-6.2
VALIDATE $? "redis 6.2 module enable"

dnf install redis -y
VALIDATE $? "redis installation"

sed -i '/s/127.0.0.1/0.0.0.0/g' /etc/redis/redis.conf 
VALIDATE $? "remote access"

systemctl enable redis
VALIDATE $? "enable redis"

systemctl start redis
VALIDATE $? "start redis"
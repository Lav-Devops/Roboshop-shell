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
     echo -e "$2 ...$R Failed $N"
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

cp Mongo.repo /etc/yum.repos.d/mongo.repo &>> $LOGFILE
VALIDATE $? "Mongo repo copying"

dnf install mongodb-org -y &>> $LOGFILE
VALIDATE $? "installation of Mongodb"

systemctl enable mongod &>> $LOGFILE
VALIDATE $? "Mongodb enable "

systemctl start mongod &>> $LOGFILE
VALIDATE $? "Mongodb start "

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
VALIDATE $? "remote access "

systemctl restart mongod &>> $LOGFILE
VALIDATE $? "restarting "
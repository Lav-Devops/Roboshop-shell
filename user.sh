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

dnf module disable nodejs -y &>> $LOGFILE
VALIDATE $? "Nodejs disable"

dnf module enable nodejs:18 -y &>> $LOGFILE
VALIDATE $? "Nodejs enable"

dnf install nodejs -y &>> $LOGFILE
VALIDATE $? "Installation of Nodejs"

id roboshop
if [ $? -ne 0 ]
then
  useradd roboshop &>> $LOGFILE
  VALIDATE $? "User adding"
else
  echo -e "user already exists..$Y skipping $N"
fi

mkdir -p /app &>> $LOGFILE
VALIDATE $? "directory creation"

curl -L -o /tmp/user.zip https://roboshop-builds.s3.amazonaws.com/user.zip &>> $LOGFILE
VALIDATE $? "download user "

cd /app

unzip -o /tmp/user.zip &>> $LOGFILE
VALIDATE $? "Unzipping user"

cd /app &>> $LOGFILE

npm install &>> $LOGFILE
VALIDATE $? " dependencies installation"

cp /home/centos//Roboshop-shell/user.service /etc/systemd/system/user.service
VALIDATE $? "copying user service"

systemctl daemon-reload
VALIDATE $? "Deamon reload"

systemctl enable user
VALIDATE $? "enable user"

systemctl start user
VALIDATE $? "start user"

cp /home/centos/Roboshop-shell/Mongo.repo /etc/yum.repos.d/mongo.repo
VALIDATE $? "mongo repor copy"

dnf install mongodb-org-shell -y
VALIDATE $? "install mongodb client" 

mongo --host 54.242.20.181 </app/schema/user.js
VALIDATE $? "Loading catalogue data into Mongodb"
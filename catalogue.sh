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
     echo -e "$2 ...  $R Failed $N"
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

curl -o /tmp/catalogue.zip https://roboshop-builds.s3.amazonaws.com/catalogue.zip &>> $LOGFILE
VALIDATE $? "download catalogue "

cd /app &>> $LOGFILE

unzip -o /tmp/catalogue.zip &>> $LOGFILE
VALIDATE $? "Unzipping catalogue"

cd /app &>> $LOGFILE

npm install &>> $LOGFILE
VALIDATE $? " dependencies installation"

cp /home/centos/Roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service &>> $LOGFILE
VALIDATE $? "copying catalogue service"

systemctl daemon-reload
VALIDATE $? "Deamon reload"

systemctl enable catalogue
VALIDATE $? "enable catalogue"

systemctl start catalogue
VALIDATE $? "start catalogue"

cp /home/centos/Roboshop-shell/Mongo.repo /etc/yum.repos.d/mongo.repo
VALIDATE $? "mongo repor copy"

dnf install mongodb-org-shell -y
VALIDATE $? "install mongodb client" 

mongo --host 444.204.202.59 </app/schema/catalogue.js
VALIDATE $? "Loading catalogue data into Mongodb"
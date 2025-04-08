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
 "user already exists..skipping"
fi

mkdir -p /app &>> $LOGFILE
VALIDATE $? "directory creation"

curl -L -o /tmp/cart.zip https://roboshop-builds.s3.amazonaws.com/cart.zip
VALIDATE $? "download cart "

cd /app 

unzip -o /tmp/cart.zip
VALIDATE $? "Unzipping cart"

cd /app &>> $LOGFILE

npm install &>> $LOGFILE
VALIDATE $? " dependencies installation"

cp /home/centos/Roboshop-Shell/cart.service /etc/systemd/system/cart.service
VALIDATE $? "copying cart service"

systemctl daemon-reload
VALIDATE $? "Deamon reload"

systemctl enable cart
VALIDATE $? "enable cart"

systemctl start cart
VALIDATE $? "start cart"
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

dnf install maven -y
VALIDATE $? "maven installation"

useradd roboshop
VALIDATE $? "roboshop user addition"

mkdir -p /app
VALIDATE $? "making directory"

curl -L -o /tmp/shipping.zip https://roboshop-builds.s3.amazonaws.com/shipping.zip
VALIDATE $? "downloading shipping zip folder"

cd /app

unzip -o /tmp/shipping.zip
VALIDATE $? "unzipping"

mvn clean package
VALIDATE $? "dependencies"

mv target/shipping-1.0.jar shipping.jar
VALIDATE $? "moving shipping jar file"

cp /home/centos/Roboshop-shell/shipping.service /etc/systemd/system/shipping.service
VALIDATE $? "copying shipping service"

systemctl daemon-reload
VALIDATE $? "deamon reload"

systemctl enable shipping 
VALIDATE $? "shipping enable"

systemctl start shipping
VALIDATE $? "shipping start"

dnf install mysql -y
VALIDATE $? "mysql client installation"

mysql -h 35.172.214.187 -uroot -pRoboShop@1 < /home/centos/Roboshop-shell/shipping.sql &>> $LOGFILE
VALIDATE $? "loading shipping sql to mysql"

systemctl restart shipping
VALIDATE $? "system restart"
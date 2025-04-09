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
     echo " $2.... $G Success $N"
    fi
}

if [ $ID -ne 0 ]
then
 echo " Run with root user"
 exit 1
else 
 echo " you are root user"
fi

dnf install nginx -y >> $LOGFILE
VALIDATE $? "Nginx installation"

systemctl enable nginx >> $LOGFILE
VALIDATE $? "Nginx enable"

systemctl start nginx >> $LOGFILE
VALIDATE $? "start Nginx"

rm -rf /usr/share/nginx/html/* >> $LOGFILE
VALIDATE $? "removing default html"

curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip >> $LOGFILE
VALIDATE $? "Download zip"

cd /usr/share/nginx/html

unzip -o /tmp/web.zip >> $LOGFILE
VALIDATE $? "unzipping"

cp /home/centos/Roboshop-Shell/roboshop.conf /etc/nginx/default.d/roboshop.conf 
VALIDATE $? "configuration copy"

systemctl restart nginx  >> $LOGFILE
VALIDATE $? "restart nginx"
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

dnf module disable mysql -y
VALIDATE $? "mysql default module disable"

cp home/centos/Roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo
VALIDATE $?  "coping mysql repo"

dnf install mysql-community-server -y
VALIDATE $?  "mysql installation"

systemctl enable mysqld
VALIDATE $? "mysql enable"

systemctl start mysqld
VALIDATE $? "mysql start"

mysql_secure_installation --set-root-pass RoboShop@1
VALIDATE $? "updating password"

#mysql -uroot -pRoboShop@1
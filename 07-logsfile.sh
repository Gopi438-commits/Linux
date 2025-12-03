#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "ERROR:: please run this script with root privelege"
    exit 1
fi
LOGS_FOLDER=/var/log/Linux
SCRIPT_NAME=$(echo $0 |cut -d '.'-f1)
Log_file=$LOGS_FOLDER/$SCRIPT_NAME.log
mkdir -p LOGS_FOLDER

VALIDATE(){

  if [ $1 -ne 0]; then
       echo  -e "Installing $2 ... $R failure $N" >>& Log_file
       exit 1
  else   
       echo -e "Installing $2 ...$G SUCCESS $N"   >>& Log_file
  fi     

}

dnf list installed mysql
#install if it is not found
if [ $? -ne 0 ]; then
  dnf install mysql -y     >>& Log_file
   VALIDATE $? "MYSQL"
else 
   echo  -e "MQSQL  already exist ...$Y SKIPPING $N"
 fi  
   

dnf list installed Nginx
#install if it is not found
if [ $? -ne 0 ]; then
  dnf install nginx -y  >>& Log_file
   VALIDATE $? "Nginx"
else 
   echo  -e "Nginx  already exist ...$Y SKIPPING $N"
 fi  
   
dnf list installed python3
#install if it is not found
if [ $? -ne 0 ]; then
  dnf install python3 -y  >>& Log_file
   VALIDATE $? "python3"
else 
   echo -e "python3 already exist ...$Y SKIPPING $N"
 fi  
   

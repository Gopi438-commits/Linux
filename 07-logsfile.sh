#!/bin/bash
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/Linux"
SCRIPT_NAME=$( echo $0 |cut -d '.'-f1 )
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"



if [ $USERID -ne 0 ]; then
    echo "ERROR:: please run this script with root privelege"
    exit 1
fi

mkdir -p LOGS_FOLDER
echo "Script started executed at: $(date)"

VALIDATE(){

  if [ $1 -ne 0]; then
       echo  -e "Installing $2 ... $R failure $N" &>>$LOG_FILE
       exit 1
  else   
       echo -e "Installing $2 ...$G SUCCESS $N"   &>>$LOG_FILE
  fi     

}

dnf list installed mysql  &>>$LOG_FILE
#install if it is not found
if [ $? -ne 0 ]; then
  dnf install mysql -y     &>>$LOG_FILE
   VALIDATE $? "MYSQL"
else 
   echo  -e "MQSQL  already exist ...$Y SKIPPING $N"
 fi  
   

dnf list installed Nginx  &>>$LOG_FILE
#install if it is not found
if [ $? -ne 0 ]; then
  dnf install nginx -y  &>>$LOG_FILE
   VALIDATE $? "Nginx"
else 
   echo  -e "Nginx  already exist ...$Y SKIPPING $N"
 fi  
   
dnf list installed python3 &>>$LOG_FILE
#install if it is not found
if [ $? -ne 0 ]; then
  dnf install python3 -y  &>>$LOG_FILE
   VALIDATE $? "python3"
else 
   echo -e "python3 already exist ...$Y SKIPPING $N"
 fi  
   

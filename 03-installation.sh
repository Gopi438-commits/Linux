#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "ERROR:: please run this script with root privelege"
fi

dnf install mysql -y

if [ $? -ne 0]; then
    echo "ERROR:: Installing MYSQL is failure"
else
    echo "Installing MYSQL is success"
fi        
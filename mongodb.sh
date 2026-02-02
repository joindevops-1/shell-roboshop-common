#!/bin/bash

source ./common.sh

log_cmd check_root

log_cmd cp mongo.repo /etc/yum.repos.d/mongo.repo
VALIDATE $? "Adding Mongo repo"

log_cmd dnf install mongodb-org -y
VALIDATE $? "Installing MongoDB"

log_cmd systemctl enable mongod
VALIDATE $? "Enable MongoDB"

log_cmd systemctl start mongod 
VALIDATE $? "Start MongoDB"

log_cmd sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
VALIDATE $? "Allowing remote connections to MongoDB"

log_cmd systemctl restart mongod
VALIDATE $? "Restarted MongoDB"

print_total_time
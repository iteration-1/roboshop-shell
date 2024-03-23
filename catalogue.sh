source common.sh

print_head "disable and enable nodejs"
dnf module disable nodejs -y &>>${LOG}
dnf module enable nodejs:18 -y &>>${LOG}
status_check

print_head "Install nodejs"
dnf install nodejs -y
status_check

print_head "add roboshop user"
id roboshop &>>${LOG}
if [ $? -ne 0 ]; then
  useradd roboshop &>>${LOG}
fi
status_check

print_head "make app dir"
mkdir -p /app
status_check


print_head "download app dir and unzip"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${LOG}
cd /app
unzip /tmp/catalogue.zip &>>${LOG}
status_check

print_head "npm install"
npm install &>>${LOG}
status_check

print_head "copy config file"
cp ${script_location}/files/catalogue.service /etc/systemd/system/catalogue.service &>>${LOG}
status_check

systemd

print_head "copy mongo repo"
cp ${script_location}/files/mongo.repo /etc/yum.repos.d/mongo.repo &>>${LOG}
status_check

print_head "install mongo client"
dnf install mongodb-org-shell -y &>>${LOG}
status_check

print_head "load schema"
mongo --host mongodb-dev.pappik.online </app/schema/catalogue.js
status_check


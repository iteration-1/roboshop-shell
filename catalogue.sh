source common.sh
component = catalogue

nodejs

print_head "copy mongo repo"
cp ${script_location}/files/mongo.repo /etc/yum.repos.d/mongo.repo &>>${LOG}
status_check

print_head "install mongo client"
dnf install mongodb-org-shell -y &>>${LOG}
status_check

print_head "load schema"
mongo --host mongodb-dev.pappik.online </app/schema/catalogue.js
status_check

systemd
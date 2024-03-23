source common.sh

print_head "copy mongo repo file"
cp ${script_location}/files/mongo.repo /etc/yum.repos.d/mongo.repo &>>${LOG}
status_check

print_head "install mongodb"
dnf install mongodb-org -y &>>${LOG}
status_check

print_head "change listening addr"
sed -i -e 's/127.0.0.0/0.0.0.0/' /etc/mongod.conf &>>${LOG}
status_check

print_head "systemd service"
systemd


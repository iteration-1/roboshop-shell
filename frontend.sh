source common.sh

print_head "install nginx"
dnf install nginx -y &>>${LOG}
status_check
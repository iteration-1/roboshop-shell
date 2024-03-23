source common.sh

print_head "install nginx"
dnf install nginx &>>${LOG}
status_check
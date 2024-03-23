source common.sh

print_head "install mysql"
dnf install mysql-community-server -y &>>${LOG}
status_check

print_head "setup mysql passwd"
mysql_secure_installation --set-root-pass RoboShop@1 &>>${LOG}
status_check

systemd
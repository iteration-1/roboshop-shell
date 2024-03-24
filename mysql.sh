source common.sh

print_head "disable mysql"
dnf install mysql-community-server -y &>>${LOG}
status_check

print_head "copy mysql repo"
cp ${script_location}/files/mysql.repo /etc/yum.repos.d/mysql.repo &>>${LOG}

print_head "install mysql"
dnf install mysql-community-server -y &>>${LOG}
status_check

print_head "setup mysql passwd"
mysql_secure_installation --set-root-pass RoboShop@1 &>>${LOG}
status_check

print_head "enable mysqld"
systemctl enable mysqld

print_head "restart mysqld"
systemctl restart mysqld
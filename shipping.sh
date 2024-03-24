source common.sh
component=shipping

maven



print_head "mysql client install"
dnf install mysql -y &>>${LOG}
status_check

print_head "load schema"
mysql -h mysql-dev.pappik.online -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>${LOG}
status_check

systemd
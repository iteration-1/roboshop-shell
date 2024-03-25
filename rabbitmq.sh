source common.sh

print_head "configure repos"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>${LOG}
status_check

print_head "configure rabbitmq repo"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>${LOG}
status_check

print_head "install rabbitmq"
dnf install rabbitmq-server -y &>>${LOG}
status_check

print_head "enable and restart rabbitmq"
systemctl enable rabbitmq-server
systemctl start rabbitmq-server
status_check

print_head "set username and passwd rabbitmq"
rabbitmq list_users | grep roboshop &>>{LOG}
if [ $? -ne 0 ]; then
 rabbitmqctl add_user roboshop roboshop123 &>>${LOG}
fi
status_check

print_head "add tags to appli user"
rabbitmq set_user_tags rboshop administrator &>>${LOG}
status_check

print_head "add permission to application user"
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>${LOG}
status_check
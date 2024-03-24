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

print_head"enable and restart rabbitmq"
systemctl enable rabbitmq-server
systemctl start rabbitmq-server
status_check

print_head "set username and passwd rabbitmq"
rabbitmqctl add_user roboshop roboshop123 &>>${LOG}
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>${LOG}
status_check
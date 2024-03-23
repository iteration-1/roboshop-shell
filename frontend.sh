source common.sh
component=nginx

print_head "install nginx"
dnf install nginx -y &>>${LOG}
status_check

print_head "remove html content"
rm -rf /usr/share/nginx/html/* &>>${LOG}
status_check

print_head "download content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${LOG}
status_check

print_head "extract the content"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>${LOG}
status_check

print_head "copy config file"
cp /${script_location}/roboshop.conf /etc/nginx/default.d/roboshop.conf
status_check

systemd
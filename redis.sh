source common.sh

print_head "Install redis"
dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>${LOG}
status_check

print_head "enable redis"
dnf module enable redis:remi-6.2 -y &>>${LOG}
status_check

print_head "install redis"
dnf install redis -y &>>${LOG}
status_check

print_head "update listening address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf /etc/redis/redis.conf
status_check

print_head "enable redis"
systemctl enable redis

print_head "restart redis"
systemctl restart redis


LOG=/tmp/roboshop.log
script_location=$(pwd)

print_head(){
  echo -e "\e[35m $1 \e[0m"
}

status_check(){
  if [ $? -eq 0 ]; then
    echo -e "\e[32m SUCCESS \e[0m"
  else
     echo -e "\e[31m FAILURE \e[0m"
  fi
}

systemd() {
  print_head "daemon reload"
  systemctl daemon-reload

  print_head "enable ${component}"
  systemctl enable ${component}

  print_head "restart ${component}"
  systemctl restart ${component}
}

nodejs() {
  print_head "disable and enable nodejs"
  dnf module disable nodejs -y &>>${LOG}
  dnf module enable nodejs:18 -y &>>${LOG}
  status_check

  print_head "Install nodejs"
  dnf install nodejs -y
  status_check

  print_head "add roboshop user"
  id roboshop &>>${LOG}
  if [ $? -ne 0 ]; then
    useradd roboshop &>>${LOG}
  fi
  status_check

  print_head "make app dir"
  mkdir -p /app
  status_check


  print_head "download app dir and unzip"
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${LOG}
  cd /app
  rm -rf /app/* &>>${LOG}
  unzip /tmp/${component}.zip &>>${LOG}
  status_check

  print_head "npm install"
  npm install &>>${LOG}
  status_check

  print_head "copy config file"
  cp ${script_location}/files/${component}.service /etc/systemd/system/${component}.service &>>${LOG}
  status_check
}

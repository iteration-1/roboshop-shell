LOG = /tmp/roboshop.log
script_location = $(pwd)

print_head(){
  echo -e "\e[35m $1 \e[0m"
}

status_check(){
  if [&? -eq 0 ]; then
    echo -e "\e[35m SUCCESS \e[0m"
    else
     echo -e "\e[32m SUCCESS \e[0m"
}
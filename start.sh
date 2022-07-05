#!/bin/sh
export LANG=en_US.UTF-8

mkdir -p /etc/hysteria
version=`wget -qO- -t1 -T2 --no-check-certificate "https://api.github.com/repos/HyNetwork/hysteria/releases/latest" | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g'`

wget -q -O /etc/hysteria/hysteria --no-check-certificate https://github.com/HyNetwork/hysteria/releases/download/$version/hysteria-linux-amd64

chmod 755 /etc/hysteria/hysteria

IP=$(curl -s6m8 ip.sb) || IP=$(curl -s4m8 ip.sb)

if [[ -n $(echo $IP | grep ":") ]]; then
    IP="[$IP]"
    echo -e "$IP"
    echo -e "$PORT"
fi


ufw disable


cat <<EOF > /etc/hysteria/config.json
{
  "listen": ":$PORT",
  "cert": "/root/cert.crt",
  "key": "/root/private.key",
  "obfs": "$auth_str"
}
EOF



./etc/hysteria/hysteria -c /etc/hysteria/config.json server

  echo -e "\033[35m↓***********************************↓↓↓copy↓↓↓*******************************↓\033[0m"
  cat ./config.json
  echo -e "\033[35m↑***********************************↑↑↑copy↑↑↑*******************************↑\033[0m"

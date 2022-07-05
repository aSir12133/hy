#!/bin/sh
export LANG=en_US.UTF-8

mkdir -p /etc/hysteria
version=`wget -qO- -t1 -T2 --no-check-certificate "https://api.github.com/repos/HyNetwork/hysteria/releases/latest" | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g'`

wget -q -O /etc/hysteria/hysteria --no-check-certificate https://github.com/HyNetwork/hysteria/releases/download/$version/hysteria-linux-amd64

chmod 755 /etc/hysteria/hysteria


cat <<EOF > /etc/hysteria/config.json
{
  "listen": ":$PORT",
  "cert": "",
  "key": "",
  "obfs": "$auth_str"
}
EOF

./etc/hysteria/hysteria -c /etc/hysteria/config.json server

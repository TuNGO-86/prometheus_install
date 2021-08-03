#!/bin/bash
#Use with user root
sudo mkdir /var/lib/node_exporter
cat  > /etc/systemd/system/node_exporter.service <<"EOF"
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter \
        --collector.textfile.directory=/var/lib/node_exporter

[Install]
WantedBy=multi-user.target


EOF
sudo systemctl daemon-reload
sudo systemctl restart node_exporter.service
sudo cd /usr/local/bin/
sudo wget https://raw.githubusercontent.com/TuNGO-86/prometheus_install/main/apt.sh
sudo chmod +x apt.sh
cat > /etc/cron.d/prom-apt <<"EOF"
*/30 * * * * root /usr/local/bin/apt.sh >/var/lib/node_exporter/apt.prom.new && mv /var/lib/node_exporter/apt.prom.new /var/lib/node_exporter/apt.prom

EOF
echo "DONE!"

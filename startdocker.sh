#!/bin/bash

sudo systemctl start docker
sudo docker start [CONTAINER NAME]
echo "$USER started container [CONTAINER NAME] $(date)" >> /home/azureuser/dockerstarttimes.txt
sudo docker exec [CONTAINER NAME] ansible-playbook /path/to/dvwa-playbook.yml
sudo docker exec [CONTAINER NAME] ansible-playbook /path/to/install-elk.yml
sudo docker exec [CONTAINER NAME] ansible-playbook /path/to/filebeat-playbook.yml
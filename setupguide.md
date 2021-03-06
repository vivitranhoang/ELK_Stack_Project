<h1><p align="center">Set-Up Guide</p></h1>
<br />
<p align="left">This is a step-by-step guide on ELK stack deployment with Azure. First and foremost, please keep the following in mind:</p>
<br />
<h1>Update and Upgrade Virtual Machines</h1>
<br />
<p align="left">As stated above, always be sure to update -- <em>sudo apt update</em> -- and upgrade -- <em>sudo apt upgrade</em> -- <strong>all</strong> virtual machines first! 
This includes the VMs hosting DVWA and ELK containers. This should be the first step in VM creation and maintenance in general, 
but it is particularly vital in this case as it will interfere with package installation and playbook execution should the systems be out of date.</p>
<br />
<li>
<ol>
<li><a href="#initial-azure-config">Initial Azure Configurations</a></li>
<li><a href="#ansible-config-jumpbox">Ansible Configuration in Jumpbox</a></li>
<li><a href="#creating-dvwa-vms">Creating New Virtual Machines for DVWA Containers</a></li>
<li><a href="#dvwa-playbook">Configuring and Executing Playbook to Launch DVWA in VMs</a></li>
<li><a href="#lb-setup">Setting Up Load Balancer</a></li>
<li><a href="#elk-vm">Preparing New Virtual Machine for ELK</a></li>
<li><a href="#elk-playbook">Configuring and Executing Playbooks to Launch ELK Stack</a></li>
<li><a href="#filebeatcon">Filebeat Configuration and Installation</a></li>
<li><a href="#monitoring">Adding and Monitoring Log Files through Kibana</a></li>
<li><a href="#after">Afterword</a></li>
<br />
<p align="center"><h2><a id="initial-azure-config">1. Initial Azure Configurations</a></h2></p>
<br />
<p align="left"><strong>a.) Create a Resource Group</strong></p>
<br />By having all or most of our resources in one Virtual Network, the webservers and jumpbox virtual machines will be a part of the same subnet. 
Placing all resources in one Resource Group is simply good housekeeping and easier to manage. It is best to keep the names consist to avoid confusion
(e.g. EXAMPLE-resource-group and EXAMPLE-vnet).
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/11.PNG?raw=true" alt="Image of the Azure portal, on the page 'Resource Group.' There is a blue button with the word 'Create' on it. Clicking it will allow you to create a resource group.">
<br />
<br />Simply type in the type of resource intended to create -- for example, "resource group" -- in the search bar. 
More often than not the top search result will be the right resource. Click on the link and then click "Create."
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/10.PNG?raw=true" alt="This image shows an example of the 'Create a resource group' page. In the first box you will choose subscription, then your resource group name, then your preferred region.">>
<br /> 
<br /> It is necessary to enter a Resource Group name and to select a region. From there you may select "Reviwe + create" at the bottom of the page, 
or click "Next: Tags >" to label the Resource Group for further organization (in the case there are multiple Resource Groups). 
<br />
<br />
<p align="left"><strong>b.) Create a Corresponding Virtual Network & Network Security Group</strong></p>
<br />
<br />Create a Virtual Network and place it in the Resource Group made in step a. No changes were made to the default settings. Then create a Network Security Group for the network.
<br />
<br /><strong>c.) Create a "Jumpbox" Virtual Machine </strong>
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/12.PNG?raw=true" alt="Image displays the page to create a new virtual machine. Second box (first box is subscription, but it is not pictured): Resource group. Third: Virtual machine name. This should be some variation of Your Resource Group and Jumpbox. Fourth box: Region, preferably the same as your resource group. Fourth: Availability options: leave as default. Fifth: Image. Leave as default. Azure Spot instance - leave as default. Size: pick any appropriate size for your needs. 
In this case we chose Standard_B2ms - 2 vcpus, 8GiB memory. Authentication type: SSH public key. Username: azureuser. SSH public key source: Use existing public key. SSH public key: paste the public key here.">
<br />
<br />Create a Virtual Machine and place it in the Resource Group made prior. This first VM is the jumpbox VM where ansible will be managed. 
It should have a Private IP Address, which falls under the Virtual Network's address space, as well as a Public IP Address.
<br />
<br />In the examples, the jumpbox VM if configured to have a 2 vcpus & 8 GiB memory size (Standard_B2ms). This is ideal for VMs running dockers for 2-3 other VMs, as smaller sizes will cause docker to crash. 
It may be necessary to select a larger size should there be more than 3 or 4 webserver VMs.
<br />
<br />Because it is an Ubuntu and not a Windows OS, RDP is not available. In the examples, SSH public keys on local machines were used. 
Keep in mind that SSH keys with passphrases may cause errors with playbooks in later steps.
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/14.PNG?raw=true" alt="Image of the Disk category when making a virtual machine. For OS disk type, we chose Standard SSD.">
<br />
<br />For Disks, select Standard SSD to avoid possible extra charges.
<br />
<br />Nothing is required to be changed in regards to the VM's Networking, Management, or Tags. 
Azure will issue a warning prior to finalizing the creation of the VM about the dangers of exposing the 22 port, but it will not stop the creation of the machine.
<br />
<br /> 
<p align="center"><h2><a id="ansible-config-jumpbox">2. Ansible Configuration in Jumpbox Virtual Machine</a></h2></p>
<br /><em>ssh</em> into the Jumpbox from the folder in your local machine containing the public key, 
with the command <em>ssh -i [private-key] azureuser@[VM public IP address]</em>. Azure also has a Key Vault service for an additional cost, 
but for this exercise we will be utilizing our own keys.
<br />
<br />
<p align="left"><strong>a.) <em>sudo apt update && sudo apt upgrade</em></strong>
<br />
<br />As mentioned earlier, it is important to update & upgrade VMs so docker can be installed. This may take a few minutes.
<br />
<br /><strong>b.) <em>sudo apt install docker.io</em></strong>
<br />
<br />Adding <em>-y</em> to the command will bypass having to input yes or no by automatically inputting yes to the use of additional memory. Otherwise simply type Y or yes when prompted.
<br />
<br /><strong>c.) <em>sudo systemctl start docker</em></strong>
<br />
<br />More often than not, installing docker does not automatically start it. <em>systemctl start</em> ensures that docker starts. 
If the command fails, remove and install docker, and try again. 
<br />
<br /><strong>d.) <em>sudo docker pull cyberxsecurity/ansible</em></strong>
<br />
<br />This command pulls the latest version of an ansible image. The output should look like this:
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/15.PNG?raw=true" alt="Image of how your terminal will look after running the sudo docker pull cyberxsecurity/ansible command.">
<br />
<br /><strong>e.) <em>sudo docker run -ti cyberxsecurity/ansible:latest bash</em></strong>
<br />
<br />This command will start and attach (connect) you to the new ansible container. Instead of <em>azureuser@[VM-name]</em>, it will now show <em>root@[container-ID]</em>. 
Be aware of where you are in the network. It may sound obvious, but connecting and exiting repeatedly into different VMs and containers may cause some confusion. 
If a command does not work, it may be because you are in the incorrect container or VM. In some lightweight containers, certain commands and services may not be available.
<br />
<br /><strong>f.) <em>ifconfig</em></strong>
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/17.PNG?raw=true" alt="Image of output of the ifconfig command. Shows that the IP address does not match our Resource Group's Virtual Network's subnet.">
<br />
<br />As you can see, the IP address of this container does not fall within our Virtual Network's address pool. We will need to configure it with a .json file so that it does.
<br />
<br /><strong>g.) <em>exit</em></strong>
<br />
<br />Exits out of the container, back into the Jumpbox.
<br />
<br /><strong>h.) <em>sudo nano /etc/docker/daemon.json</em></strong>
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/16.PNG?raw=true alt="Image of the contents of the daemon file.">
<br />
<br />Be sure to place the <em>daemon.json</em> file, which is available in this repository, in the <em>/etc/docker</em> folder. 
Be sure to type the correct address space that matches your Virtual Network, and be mindful of spaces/tabs.
<br />
<br />CTRL + O to save, CTRL + X to exit.
<br />
<br /><strong>i.) <em>sudo systemctl restart docker</em></strong>
<br />
<br />Restart the docker service so that it can reconfigure itself using the newly created <em>daemon.json</em> file. Should an error occur, double check the <em>daemon.json</em> file for typos, check to see if docker is running (and if so, stop it), and try to restart the service again.
<br />
<br /><strong>j.) <em>sudo docker container list -a</em></strong>
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/18.PNG?raw=true">
<br />
<br />This command lists all containers made. The newly created container should be listed and be given a randomized, sometimes nonsensical name.
<br />
<br /><strong>k.) <em>sudo docker start [container-name or container-id]</em></strong>
<br />
<br />Starts the container. All running containers will be listed as an output for the command <em>sudo docker ps</em> 
(not to be confused with <em>sudo docker container list -a</em>, which lists all containers regardless of state). Use it to double-check if the container is in fact running.
<br />
<br /><strong>l.) <em>sudo docker exec -it [container-name] bash</em></strong>
<br />
<br />The command <em>sudo docker exec -it [container] bash</em> connects you to a new bash instance of the container. 
With <em>exec</em>, you can have multiple terminals open without affecting that instance, as opposed to using <em>sudo docker attach [container]</em>.  
Also note that exiting from an <em>attach</em> session will result in the container stopping, unlike <em>exec -it</em>. 
<br />Now that you are in the new container, it is a good time to remind you to:
<br />
<br /><h3>m.) apt update && apt upgrade!</h3>
<br />
<br />Because this is a container, it will take less time than updating a full VM.
<br />
<br /><strong>n.) <em>ifconfig</em></strong>
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/19.PNG?raw=true">
<br />
<br />The container should now have an appropriate IP address. If not, double-check to make sure there are no typos in <em>daemon.json</em>, 
and try to restart the docker service or the container itself (<em>sudo docker restart [container]</em>) again. 
Remember that if you restart the docker service you will have to start the container again.
<br />
<br /><strong>o.) <em>ssh-keygen</em></strong>
<br />
<br />While still inside of the ansible container, create an ssh key. Be sure to create a key without a password, 
as having a password may result in fatal errors when running the playbooks in later steps 
(although it may be fixed by adding additional syntax and such to the scripts, doing so could lead to even more errors and troubleshooting).
<br />
<p align="center"><h2><a id="creating-dvwa-vms">2. Creating New Virtual Machines for DVWA Containers</a></h2></p>
<br />Go back to the Azure portal and create new Virtual Machines which will act as our vulnerable webservers. 
The steps should be similar to the creation of the Jumpbox VM, save two steps:
<br />
<br /><strong>First</strong>, instead of the public key from your local machine, it will be using the new public key made from inside the ansible container. 
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/20.PNG?raw=true">
<br />
<br /><strong>Second</strong>, these VMs should <strong>not</strong> have public IP addresses. For Public IP, select "None," shown in the screenshot above. 
The servers should only be publically accessed through the Load Balancer's IP address, which will be created in later steps.
<br />
<br />Should you accidentally create a VM with a public IP address, you can simply disassociate it by clicking the public IP address on the VM's main resource page, clicking "Dissociate" and then "Delete."
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/21.PNG?raw=true">
<br />
<br />Repeat these steps for as many webservers you would like (within reason). 2-3 is adequate for testing and demonstration purposes.
<br />
<br />Additionally, you may want to change the SSH rule under Networking (only after the VM has been created) to only allow ssh connection from the jumpbox's ansible container. 
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/27.PNG?raw=true">
<br />
<p align="center"><h2><a id="dvwa-playbook">Configuring and Executing Playbook to Launch DVWA in VMs</a></h2></p>
<br /><strong>a.) <em>ssh</em> into the new Virtual Machine(s)</strong>
<br />
<br />From your ansible container, ssh into your newly created VM.
<br />
<br /><h3>b.) <em>sudo apt update && sudo apt upgrade</em></h3>
<br />
<br /><strong>c.) <em>exit</em></strong>
<br />
<br />Repeat steps <strong>a-c</strong> for all Virtual Machines intended to be used as webservers.
<br />
<br /><strong>d.) <em>nano /etc/ansible/hosts</em></strong>
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/22.PNG?raw=true">
<br />
<br />In this <em>hosts</em> file, unhash the [webservers] line and add new lines consisting of your webserver VMs' private IP address followed by 
<em>ansible_python_interpreter=/usr/bin/python3 ansible_private_key_file=[/path/to/private/key]</em>. 
<br />
<br /><img src=https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/23.PNG?raw=true">
<br />
<br />CTRL + O to save, CTRL + X to exit.
<br />
<br /><strong>e.) <em>nano /etc/ansible/ansible.cfg</em></strong>
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/28.PNG?raw=true">
<br />
<br />Find #inventory     = /etc/ansible/hosts and unhash it. It should be on the first page of the file.
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/25.PNG?raw=true">
<br />
<br />Locate #remote_user = root, unhash it, and change it to remote_user = azureuser, or the appropriate username for your VM. This selects the default user for the playbooks. 
If you are having difficulty locating it, use CTRL + W and search "remote_user."
<br />
<br /><strong>f.) <em>nano dvwa-playbook.yml</em></strong>
<br />
<br />Copy+paste the text of or download the <a href="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/dvwa-playbook.yml"><em>dvwa-playbook.yml</em></a> file, 
available in this repository. When running the playbook, you will need to be in the same folder as this file, so remember where you created or saved the file.
<br />
<br /><strong>g.) <em>ansible-playbook dvwa-playbook.yml</em></strong>
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/30.PNG?raw=true"> 
<br />
<br />The command runs the DVWA playbook, which installs docker and DVWA containers in the webserver VMs. This may take a few minutes. 
[WARNING] does not mean the command or task failed -- if all tasks end in ok: [IP address] or changed [IP address], as shown above, it means the playbook as run successfully and a DVWA module should be launched inside your webservers.
Should there be any <strong>fatal</strong> errors, double check your path, your private key, the <em>ansible.cfg</em> file, the <em>hosts</em> file, the VMs through Azure (in case they have been stopped). 
There are a multitude of factors which can cause errors, so be sure to pay close attention to what the errors are telling you. For example: 
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/26.PNG?raw=true">
<br />
<br />The above shows a fatal output that tells us the VM is unreachable due to key permissions. There may be an error with the key when inputted into Azure, a network security group rule conflict, 
the path of the key in the <em>hosts</em> file (or the <em>ansible.cfg</em> file, if you made changes and placed the key path there), 
or perhaps an error due to a password on the key.
<br />
<br /><strong>g.) <em>ansible -m ping all</em></strong>
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/31.PNG?raw=true"
<br />
<br />This command pings our containers to let us know if they are running properly. Alternatively, you can <em>ssh</em> into the webservers and check using the <em>sudo docker ps</em> command. 
If the containers are not up, double check with <em>sudo docker container list -a</em> and start the container.
<br />
<p align="center"><h2><a id="lb-setup">Setting Up Load Balancer</a></h2></p>
<br />In Azure, create a Load Balancer associated with the same Resource Group.
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/32.PNG?raw=true">
<br />
<br />Select "Standard" for SKU, and "Zone-redundant" for Availablity zone. Review and create.
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/33.PNG?raw=true">
<br />
<br />Go to the newly created resource, then to Backend Pools, and add the virtual machines containing the DVWA containers.
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/34.PNG?raw=true">
<br />
<br />Under Health Probes, add a new TCP health probe for port 80.
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/35.PNG?raw=true">
<br />
<br />Add a load balancing rule that utilizes the newly made health probe. 
For Session Persistence, select "Client IP and protocol" if you wish users to be able to retain their cache when visiting the site. 
It may help exchanges and requests run more smoothly. 
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/37.PNG?raw=true">
<br />
<br />Under the corresponding Virtual Network's Security Group, add a new rule that allows traffic from any source to VirtualNetwork, through port 80.
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/03.PNG?raw=true">
<br />
<br />Test your DVWA application by  entering your Load Balancer's front-end IP address in your browser. It should look like the above image. If not, 
try adding a networking rule allowing traffic from any source to the destination of your Virtual Network through port 80 on each individual VM that is acting as a webserver.
<br />
<p align="center"><h2><a id="elk-vm">Preparing New Virtual Machine for ELK</a></h2></p>
<br />Create a new virtual machine -- give it an ssh key from your ansible container, but unlike the DVWA servers, allow it to have a public IP address. 
We will be utilizing that IP address to access the Kibana application's GUI through an internet browser.
<br />
<br />Do not forget to <strong>update & upgrade</strong> your new machine!
<br />
<br />Although it must be in the same resource group, you may place it in a new Virtual Network according to your preferences. 
If so, be sure to connect the two networks together through Peering. 
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/42.PNG?raw=true">
<br />
<br />Add a networking security inbound rule (under "Networking") to allow TCP connection through port 5601. 
For security purposes it may be best to change the Source to your IP address.
<br />
<p align="center"><h2><a id="elk-playbook">Configuring and Executing Playbooks to Launch ELK Stack</a></h2></p>
<br />Jump back into your ansible container inside of the Jumpbox virtual machine.
<br />
<br /><strong>a.) <em>nano /etc/ansible/hosts</em></strong>
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/40.PNG?raw=true">
<br />
<br />Edit the <em>hosts</em> file inside of the <em>/etc/ansible</em> directory to include the new virtual machine's internal IP address, followed by <em>ansible_python_interpreter=/usr/bin/python3 ansible_private_key_file=/path/to/private/key</em>.  
Write it under a new category <em>[elk]</em> below [webservers] so that the playbook can understand that the new VM will be the host server of the ELK container. 
<br />
<br /><strong>b.) <em>nano /etc/ansible/install-elk.yml</em></strong>
<br />
<br />Create or download/copy the <a href="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/install-elk.yml"><em>install-elk.yml</em></a> file. The file's path 
does not affect the outcome as long as you remember to execute <em>ansible-playbook</em> in the same directory. 
<br />
<br /><strong>c.) <em>ansible-playbook install-elk.yml</em></strong>
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/41.PNG?raw=true">
<br />
<br />Run the playbook in the directory containing the <em>install-elk.yml</em> file.
<br />
<br /><strong>d.) Check Kibana in an internet browser</strong>
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/43.PNG?raw=true">
<br />
<br />Open a new browser in your preferred internet browsing application and type in your ELK server's public IP address, followed by :5601 (e.g. 20.188.255.46:5601).
 If it is working properly, the address should automatically change to http://[IP address]/app/kibana#/home and the browser will look similar to the image above. 
 If it is not connecting to Kibana, doublecheck the networking security inbound rules, the playbook file, or the configuration files.
<br />
<p align="center"><h2><a id="filebeatcon">Filebeat Configuration and Installation</a></h2></p>
<br />
<br /><strong>a.) Create or download <em>filebeat-config.yml</em></strong>
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/44.PNG?raw=true" alt="This is a screenshot of the first page of the filebeat-config.yml file.">
<br />
<br />Download, create, or copy the <em><a href="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/filebeat-config.yml">filebeat-config.yml</a></em> file and the 
<em><a href="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/filebeat-playbook.yml">filebeat-playbook.yml</a></em> file from the repository. 
Keep in mind that <em>filebeat-playbook.yml</em> references to <em>filebeat-config.yml</em> and its absolute path (/etc/ansible/file/filebeat-config.yml). Therefore, you must take precaution to either save/create the 
<em>filebeat-config.yml</em> in the same path (making a <em>files</em> directory before downloading/creating), or you must change the path inside of the playbook.
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/45.PNG?raw=true" alt="This is a screenshot of the portion of the filebeat-config.yml file that defines the ELK server host.">
<br />
<br />Using CTRL + w, search for "setup.kibana:" -- in the line below, replace the IP with the internal IP address of your ELK server, followed by :5601 (e.g. 10.3.0.7:5601).
<br /> 
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/46.PNG?raw=true" alt="This is a screenshot of the portion of the filebeat-config.yml file that defines where the elasticsearch output will be sent to (the ELK server).">
<br />
<br />Using CTRL + w, search for "output.elasticsearch:" -- in the line starting with "hosts:" below, replace the IP address with your ELK server's internal IP address followed by :9200 (e.g. 10.3.0.7:9200).
<br />
<br />Save (CTRL + o) and exit (CTRL + x).
<br />
<br /><strong>b.) Create or download <em>filebeat-playbook.yml</em></strong>
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/48.PNG?raw=true" alt="Screenshot of the filebeat-playbook.yml file.">
<br />
<br />The default entry should be fine, but should there be errors in downloading the filebeat .deb file, it may help to change the curl command to wget.
<br />
<br /><strong>c.) <em>ansible-playbook filebeat-playbook.yml</em></strong>
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/47.PNG?raw=true" alt="This is a screenshot of the output of a successful filebeat playbook run.>
<br />
<br />Run the playbook with the command <em>ansible-playbook filebeat-playbook.yml</em>, making sure to be in the same directory as the playbook file. 
If it is successful, then Filebeat should be sending log files to Kibana for monitoring. 
<br />
<br /><p align="center"><h2><a id="#monitoring">Adding and Monitoring Log Files through Kibana</a></h2></p>
<br />
<br />Now that we have run the filebeat playbook and have successfully launched filebeat modules, go back in your internet browser, and go to the Kibana homepage.
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/49.PNG?raw=true" alt="This is a screenshot of the web browser on Kibana's homepage. Near the center is an 'Add log data' button.">
<br />
<br />Click on "Add log data."
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/50.PNG?raw=true" alt="This is a screenshot of the various log data you can add to Kibana to keep track of. The second to last option on the bottom is 'System logs'.">
<br />
<br />Click on "System logs."
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/51.PNG?raw=true" alt="This is an image of a section on the 'Add System Logs' page. There is a button that says 'Check data' and 'System logs dashboard'.">
<br />
<br />Click on "Check data."
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/52.PNG?raw=true" alt="This is an image of how it should look after clicking 'Check data' if you have properly configured filebeat."
<br />
<br />If Filebeat is properly configured and launched, the result of clicking "Check data" should look similar to above--"Data successfully received from this module." 
It means Filebeat is working properly and is sending data from the DVWA servers to ELK. For more information, click on "System logs dashboard"!
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/53.PNG?raw=true" alt="This is a screenshot of our Filebeat System ECS dashboard -- it shows some logs of our webserver machines, our filebeat module, and more.">
<p align="center"><h2><a id="#after">Afterword & Troubleshooting</a></h2></p>
<br />Congratulations on creating a webserver and monitoring it with Filebeat and Kibana! Utilizing these ideas, you can create other ELK servers with different types of modules.

<br />
<br />
<br />
<br />
<br />If you find that the container in your ELK server does not run or stops running even after using the <em>sudo docker start elk</em>, edit the <em>install-elk.yml</em> file to include 
more memory and re-run the playbook.  
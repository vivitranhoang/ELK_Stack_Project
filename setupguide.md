<h1><p align="center">Set-Up Guide</p></h1>
<br />
<p align="left">This is a step-by-step guide on ELK stack deployment with Azure. First and foremost, please keep the following in mind:</p>
<br />
<h1>Update and Upgrade Virtual Machines</h1>
<br />
<p align="left">As stated in the title, always be sure to update [<em>sudo apt update</em>] and upgrade [<em>sudo apt upgrade</em>] <strong>all</strong> virtual machines first! 
This includes the VMs hosting DVWA and ELK containers. This should be the first step in VM creation and maintenance in general, 
but it is particularly vital in this case as it will interfere with package installation and playbook execution should the systems be out of date.</p>
<br />
<li>
<ol>
<li>Initial Azure Configurations</li>
<li>Ansible Configuration in Jumpbox</li>
<li>Creating New Virtual Machines for DVWA Containers</li>
<li>Configuring and Executing Playbook to Launch DVWA in VMs</li>
<li>Setting Up Load Balancer</li>
<li>Preparing New Virtual Machine for ELK</li>
<li>Configuring and Executing Playbooks to Launch ELK Stack</li>
<li>Kibana and Server Maintenance</li>
<br />
<p align="center"><h2>1. Initial Azure Configurations</h2></p>
<br />
<p align="left"><strong>a.) Create a Resource Group</strong></p>
<br />By having all or most of our resources in one Virtual Network, the webservers and jumpbox virtual machines will be a part of the same subnet. 
Placing all resources in one Resource Group is simply good housekeeping and easier to manage. It is best to keep the names consist to avoid confusion
(e.g. EXAMPLE-resource-group and EXAMPLE-vnet).
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/11.PNG?raw=true">
<br />
<br />Simply type in the type of resource intended to create -- for example, "resource group" -- in the search bar. 
More often than not the top search result will be the right resource. Simply click on the link and then click "Create."
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/10.PNG?raw=true">
<br /> 
<br /> It is necessary to enter a Resource Group name and to select a region. From there you may select "Reviwe + create" at the bottom of the page, 
or click "Next: Tags >" to label the Resource Group for further organization (in the case there are multiple Resource Groups). 
<br />
<br />
<p align="left"><strong>b.) Create a Corresponding Virtual Network</strong></p>
<br />
<br />Create a Virtual Network and place it in the Resource Group made in step a. No changes were made to the default settings.
<br />
<br />
<br /><strong>c.) Create a "Jumpbox" Virtual Machine </strong>
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/12.PNG?raw=true">
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
<br /><img src="14.PNG">
<br />
<br />For Disks, select Standard SSD to avoid extra charges.
<br />
<br />Nothing is required to be changed in regards to the VM's Networking, Management, or Tags. 
Azure will issue a warning prior to finalizing the creation of the VM about the dangers of exposing the 22 port, but it will not stop the creation of the machine.
<br />
<br /> 
<p align="center"><h2>2. Ansible Configuration in Jumpbox</h2></p>
<br /><em>ssh</em> into the Jumpbox from your local machine from the folder containing the public key. 
<br />
<p align="left"><strong>a.) <em>sudo apt update && sudo apt upgrade</em></strong>
<br />
<br />As mentioned earlier, it is important to update & upgrade VMs so docker can be installed. This may take a few minutes.
<br />
<br /><strong>b.) <em>sudo apt install docker.io</em></strong>
<br />
<br />Adding <em>-y</em> to the command will bypass having to input yes or no by automatically inputting yes to the use of additional memory. Otherwise simply type Y or yes when prompted.
<br />
<br /><strong>c.) <em>sudo systemctl start docker</em>
<br />
<br />More often than not, installing docker does not automatically start it. <em>systemctl start</em> ensures that docker is running.
<br />
<br /><strong>d.) <em>sudo docker pull cyberxsecurity/ansible</em>
<br />
<br />This command pulls the latest version of an ansible image. The output should look like this:
<br />
<br /><img src="15.PNG">
<br />
<br /><strong>e.) <em>sudo docker run -ti cyberxsecurity/ansible bash</em>
<br />
<br />This command will start and attach (connect) you to the new ansible container. Instead of <em>azureuser@VM-name</em>, it will now show <em>root@container-number</em>. Keep in mind that as root you no longer need to use sudo, as a lightweight container, some commands and services may not be available.
<br />
<br /><strong>f.) <em>ifconfig</em></strong>
<br />
<br /><img src="17.PNG">
<br />
<br />As you can see, the IP address of this container does not fall within our Virtual Network's address pool.
<br />
<br /><strong>g.) <em>exit</em></strong>
<br />
<br />Exits out of the container, back into the Jumpbox.
<br />
<br /><strong>h.) <em>sudo nano /etc/docker/daemon.json</em></strong>
<br />
<br /><img src="16.PNG"
<br />
<br />Be sure to place the <em>daemon.json</em> file, which is available in this repository, in the <em>/etc/docker</em> folder. 
Be sure to type the correct address space that matches your Virtual Network, and be mindful of spaces/tabs.
<br />
<br /><strong>i.) <em>sudo systemctl restart docker</em></strong>
<br />
<br />Restart the docker service so that it can reconfigure itself using the newly created <em>daemon.json</em> file. Should an error occur, double check the <em>daemon.json</em> file for typos, check to see if docker is running (and if so, stop it), and try to restart the service again.
<br />
<br /><strong>j.) <em>sudo docker container list -a</em></strong>
<br />
<br /><img src="18.PNG">
<br />
<br />This command lists all containers made. Do not confuse it with <em>sudo docker ps</em>, which lists all <strong>running</strong> containers.
<br />
<br /><strong>k.) <em>sudo docker start [container-name or container-id]</em></strong>
<br />
<br /><strong>l.) <em>sudo docker exec -it [container-name] bash</em>
<br />
<br />The command <em>sudo docker exec -it [container] bash</em> connects you to a new bash instance of the container. 
With <em>exec</em>, you can have multiple terminals open without affecting that instance, as opposed to using <em>sudo docker attach [container]</em>.  
Also note that exiting from an <em>attach</em> session will result in the container stopping, unlike <em>exec -it</em>. 
<br />Now that you are in the new container, it is a good time to remind you to:
<br />
<br /><h3>m.) apt update && apt upgrade!</h3>
<br />
<br />Because this is a container, it will take less time than updating the jumpbox.
<br />
<br /><strong>n.) <em>ifconfig</em></strong>
<br />
<br /><img src="19.PNG">
<br />
<br />The container should now have an appropriate IP address. If not, double-check to make sure there are no typos in <em>daemon.json</em>, 
and try to restart the docker service or the container itself (<em>sudo docker restart [container]</em>) again.
<br />
<br /><strong>o.) <em>ssh-keygen</em></strong>
<br />
<br />While still inside of the ansible container, create a key. Be sure to create a key without a password, 
as having a password may result in fatal errors when running the playbooks in later steps 
(though it may be fixed by adding additional syntax and such to the scripts, it creates the possibility of even more errors).
<br />
<p align="center"><h2>2. Creating New Virtual Machines for DVWA Containers</h2></p>
<br />Go back to the Azure portal and create new Virtual Machines which will act as our vulnerable webservers. The steps should be similar to the creation of the Jumpbox VM, but for two steps
<br />
<br />First, instead of the public key made from your local machine, it will be using the new public key made inside of the ansible container. 
<br />
<br /><img src="20.PNG">
<br />
<br />Second, these VMs should <strong>not</strong> have public IP addresses. For Public IP, select "None," shown in the screenshot above. 
The servers should only be publically accessed through the Load Balancer's IP address, which will be created in later steps.
<br />
<br />Should you accidentally create a VM with a public IP address, you can simply disassociate it by clicking the public IP address on the VM's main resource page, clicking "Dissociate" and then "Delete."
<br />
<br /><img src="21.PNG">
<br />
<br />Repeat these steps for as many webservers you would like (within reason). 2-3 is adequate for testing and demonstration purposes.
<br />
<p align="center"><h2>Configuring and Executing Playbook to Launch DVWA in VMs</h2></p>
<br />
<br /><strong>a.) ssh into the new Virtual Machine</strong>
<br />
<br />From your ansible container, ssh into your newly created VM.
<br />
<br /><h3>b.) <em>sudo apt update && sudo apt upgrade</em></h3>
<br />
<br /><strong>c.) <em>exit</em></strong>
<br />
<br />Repeat steps <strong>a-c</strong> for all Virtual Machines intended to be used as webservers.
<br />
<br /><strong>d.) 
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

<p align="center"><h2>Setting Up Load Balancer</h2></p>
<br />
<br />
<p align="center"><h2>Preparing New Virtual Machine for ELK</h2></p>
<br />
<br />
<p align="center"><h2>Configuring and Executing Playbooks to Launch ELK Stack</h2></p>
<br />
<br />
<p align="center"><h2>Kibana and Server Maintenance</h2></p>

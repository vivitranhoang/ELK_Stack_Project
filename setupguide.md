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
<li>Preparing Virtual Machines for DVWA Containers</li>
<li>Configuring and Executing Playbook to Launch DVWA in VMs</li>
<li>Setting Up Load Balancer</li>
<li>Preparing New Virtual Machine for ELK</li>
<li>Configuring and Executing Playbooks to Launch ELK Stack</li>
<li>Kibana and Server Maintenance</li>
<br />
<p align="center"><h2>1. Initial Azure Configurations</h2></p>
<br />
<p align="left"><strong>a.) Create a Resource Group and a corresponding Virtual Network</strong></p>
<br />
<br />By having all or most of our resources in one Virtual Network, the webservers and jumpbox virtual machines will be a part of the same subnet. Having our resources in one Resource Group is simply good housekeeping and easier to manage.
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/11.PNG?raw=true">
<br />
<br />Simply type in the type of resource you would like to create -- for example, "resource group" -- in the search bar. More often than not the top search result will be the right resource. Simply click on the link and then click "Create."
<br />
<br /><img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/10.PNG?raw=true">
<br /> 
<br />Simply 
<br />
<br /><strong>b.) 
<br />
<br />
<br />
<p align="center"><h2>2. Ansible Configuration in Jumpbox</h2></p>
<br />
<p align="left"><strong>a.) <em>sudo apt update && sudo apt upgrade</em></strong>
<br />
<br />As mentioned earlier, it is important to update & upgrade VMs so docker can be installed.
<br />
<br /><strong>b.) <em>sudo apt install docker.io</em></strong>
<br />
<br /><strong>c.) <em>sudo systemctl start docker</em>
<br />
<br />
<br /><strong>d.) <em>sudo docker pull cyberxsecurity/ansible</em>
<br />
<br />
<br />
<br /><strong>e.) Create or upload daemon.json file
<br />
<br />Be sure to place this in the <em>/etc/docker</em> folder.
<br />
<br />

<br />
<br />f) <em>
<br />
<br />g)
<br />
<br />h)
<br />
<br />i)
<br />
<br />j)
<br />
<br />k)
<br />
<br />l)
<br />
<br />
<br /></p>
<p align="center"><h2>Preparing Virtual Machines for DVWA Containers</h2></p>
<br />
<br />
<p align="center"><h2>Configuring and Executing Playbook to Launch DVWA in VMs</h2></p>
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

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
<p align="center">Initial Azure Configurations</p>
<br />
<p align="left">First, create a Resource Group and a corresponding Virtual Network so that the webservers and jumpbox virtual machines will have the same subnet. </p>
<br />
<p align="center">Ansible Configuration in Jumpbox</p>
<br />
<p align="left"><strong>1. <em>sudo apt update && sudo apt upgrade</em></strong>
<br />As mentioned earlier, it is important to update & upgrade VMs so docker can be installed.
<br /><strong>2. <em>sudo apt install docker.io</em></strong>
<br />
<br /><strong>3. 
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br /></p>
<p align="center">Preparing Virtual Machines for DVWA Containers</p>
<br />
<br />
<p align="center">Configuring and Executing Playbook to Launch DVWA in VMs</p>
<br />
<br />
<p align="center">Setting Up Load Balancer</p>
<br />
<br />
<p align="center">Preparing New Virtual Machine for ELK</p>
<br />
<br />
<p align="center">Configuring and Executing Playbooks to Launch ELK Stack</p>
<br />
<br />
<p align="center">Kibana and Server Maintenance</p>

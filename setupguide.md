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
<li>1. Initial Azure Configurations</li>
<li>2. Ansible Installation in Jumpbox</li>
<li>3. Preparing Virtual Machines for DVWA Containers</li>
<li>4. Configuring and Executing Playbook to Launch DVWA in VMs</li>
<li>5. Setting Up Load Balancer</li>
<li>6. Preparing New Virtual Machine for ELK</li>
<li>7. Configuring and Executing Playbooks to Launch ELK Stack</li>
<li>8. Kibana and Server Maintenance</li>
<br />


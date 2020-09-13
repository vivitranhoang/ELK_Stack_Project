<h1><p align="center">Set-Up Guide</p></h1>
<br />
<p align="left">This is a step-by-step guide on ELK stack deployment with Azure. First and foremost, please keep the following in mind:</p>
<br />
<h1>Update and Upgrade Virtual Machines</h1>
<br />
<p align="left">As stated in the title, always be sure to update [<em>sudo apt update</em>] and upgrade [<em>sudo apt upgrade</em>] <strong>all</strong> virtual machines first! This includes the VMs hosting DVWA and ELK containers.
This should be the first step in VM creation and maintanence in general, but it is particularly vital in this case as it will interfere with package installation and playbook execution should the systems by out of date.</p>
<br />

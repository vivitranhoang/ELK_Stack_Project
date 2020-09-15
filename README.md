# ELK_Stack_Project
UCI's Cyber Security Bootcamp Summer-Fall 2020 ELK Stack Project

<p style="text-align: center;"><span style="text-decoration: underline;"><strong><h1>ELK Stack Deployment Report</h1></strong></span></p>
<p style="margin-bottom: 0in; line-height: 100%;">If you are recreating a network consisting of virtual machines with ansible and ELK, please also refer to the 
<strong><a href="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/setupguide.md" target="_blank" rel="nofollow">Set-Up Guide</a> </strong>for a step-by-step explanation, as well as possible troubleshooting solutions.<span style="font-weight: normal;"><br /></span></p>
<p style="margin-bottom: 0in; line-height: 100%;">&nbsp;</p>

<p style="margin-bottom: 0in; line-height: 100%;">This document contains the following details:</p>
<ol>
<li style="margin-bottom: 0in; line-height: 100%;"><a href="#network-diagram">Network Diagram</a></li>
<li style="margin-bottom: 0in; line-height: 100%;"><a href="#important-files">Important Files</a></li>
<li style="margin-bottom: 0in; line-height: 100%;"><a href="#topology">Description of the Topology</a></li>
<li style="margin-bottom: 0in; line-height: 100%;"><a href="#access-policies">Access Policies</a></li>
<li style="margin-bottom: 0in; line-height: 100%;"><a href="#elk-config">ELK Configuration</a></li>
<li style="margin-bottom: 0in; line-height: 100%;"><a href="#beats">Beats in Use</a></li>
</ol>
<p style="margin-bottom: 0in; line-height: 100%;" align="center">&nbsp;</p>
<br />
<p style="margin-bottom: 0in; line-height: 100%;" align="center"><h2><a id="network-diagram">1. Network Diagram</a></h2></p>
<p style="margin-bottom: 0in; line-height: 100%;" align="center"><br />&nbsp; <br clear="left" /> <img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/NetworkDiagram.png?raw=true" alt="" /></p>
<p style="margin-bottom: 0in; line-height: 100%;">&nbsp;</p>
<p style="margin-bottom: 0in; line-height: 100%;">&nbsp;</p>
<p style="margin-bottom: 0in; line-height: 100%; text-align: center;"><h2><a id="important-files">2. Important Files</a></h2></p>
<p style="margin-bottom: 0in; line-height: 100%;">The files available in this repository have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above, or, alternatively, select portions of these files may be used to install only certain pieces of it, such as Filebeat. However, there are also a few files already present in the machine once the appropriate containers are made, and some changes are necessary for successful deployment. Please refer to the&nbsp;<a href="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/setupguide.md"><strong>Set-Up Guide</strong></a> for more details.</p>
<p style="margin-bottom: 0in; line-height: 100%;">&nbsp;</p>
<p style="margin-bottom: 0in; line-height: 100%;">&nbsp;</p>
<table width="100%" cellspacing="0" cellpadding="4">
<tbody>
<tr style="height: 35px;" valign="top">
<td style="border-color: #000000 currentcolor #000000 #000000; border-style: solid none solid solid; border-width: 1px medium 1px 1px; padding: 0.04in 0in 0.04in 0.04in; height: 35px; width: 18.4698%;">
</br><p align="center"><strong>File Name</strong></p>
</td>
<td style="border-color: #000000 currentcolor #000000 #000000; border-style: solid none solid solid; border-width: 1px medium 1px 1px; padding: 0.04in 0in 0.04in 0.04in; height: 35px; width: 31.5302%;">
<br /><p align="center"><strong>Description &amp; Notes</strong></p>
</td>
</tr>
<tr style="height: 35px;" valign="top">
<td style="border-color: #000000 currentcolor #000000 #000000; border-style: solid none solid solid; border-width: 1px medium 1px 1px; padding: 0.04in 0in 0.04in 0.04in; height: 35px; width: 18.4698%;">
<p>&nbsp;</p>
<p><em><strong>/etc/ansible/hosts</strong></em></p>
</td>
<td style="border-color: #000000 currentcolor #000000 #000000; border-style: solid none solid solid; border-width: 1px medium 1px 1px; padding: 0.04in 0in 0.04in 0.04in; height: 35px; width: 31.5302%;"><em>&nbsp;</em>
<p style="margin-bottom: 0in; font-style: normal; font-weight: normal; line-height: 100%;" align="left">This file will already exist in your <strong>ansible</strong> folder inside of your jumpbox&rsquo;s ansible container. It is important to include the private IP addresses of your webservers in this file under [webservers], as well as the private IP address of your ELK server under [elk]. Be sure to unhash properly.</p>
</td>
</tr>
<tr style="height: 35px;" valign="top">
<td style="border-color: #000000 currentcolor #000000 #000000; border-style: solid none solid solid; border-width: 1px medium 1px 1px; padding: 0.04in 0in 0.04in 0.04in; height: 35px; width: 18.4698%;">
<p><em><strong>&nbsp;</strong></em></p>
<p><em><strong>/etc/ansible/ansible.cfg</strong></em></p>
</td>
<td style="border-color: #000000 currentcolor #000000 #000000; border-style: solid none solid solid; border-width: 1px medium 1px 1px; padding: 0.04in 0in 0.04in 0.04in; height: 35px; width: 31.5302%;">&nbsp;
<p style="margin-bottom: 0in; line-height: 100%;"><span style="font-style: normal;"><span style="font-weight: normal;">This file will already exist in your ansible folder inside of your jumpbox&rsquo;s ansible container. </span></span><span style="font-style: normal;"><span style="font-weight: normal;">It is important to include the private IP addresses of your webservers in this file.</span></span></p>
</td>
</tr>
<tr style="height: 35px;" valign="top">
<td style="border-color: #000000 currentcolor #000000 #000000; border-style: solid none solid solid; border-width: 1px medium 1px 1px; padding: 0.04in 0in 0.04in 0.04in; height: 35px; width: 18.4698%;">
<p><strong>&nbsp;</strong></p>
<p><strong><em>daemon.json</em></strong></p>
</td>
<td style="border-color: #000000 currentcolor #000000 #000000; border-style: solid none solid solid; border-width: 1px medium 1px 1px; padding: 0.04in 0in 0.04in 0.04in; height: 35px; width: 31.5302%;">&nbsp;
<p style="margin-bottom: 0in; font-style: normal; font-weight: normal; line-height: 100%;" align="left">By putting this in the <em>/etc/docker</em> folder inside of the jumpbox VM, the IP address of the ansible container will be changed so that it will match the subnet of our virtual network.</p>
</td>
</tr>
<tr style="height: 35px;" valign="top">
<td style="border-color: #000000 currentcolor #000000 #000000; border-style: solid none solid solid; border-width: 1px medium 1px 1px; padding: 0.04in 0in 0.04in 0.04in; height: 35px; width: 18.4698%;">
<p><strong>&nbsp;</strong></p>
<p><strong><em>dvwa-playbook.yml</em></strong></p>
</td>
<td style="border-color: #000000 currentcolor #000000 #000000; border-style: solid none solid solid; border-width: 1px medium 1px 1px; padding: 0.04in 0in 0.04in 0.04in; height: 35px; width: 31.5302%;">
<p style="margin-bottom: 0in; line-height: 100%;">&nbsp;<span style="font-weight: normal;">The file </span><em><span style="font-weight: normal;">dvwa-playbook.yml </span></em><span style="font-style: normal;"><span style="font-weight: normal;">is used, from the ansible container in the jumpbox, to launch a DVWA container in the virtual machines being used as webservers. Please be sure to include the appropriate IP address under the [webservers] line if another machine/container is being made.</span></span></p>
</td>
</tr>
<tr style="height: 35px;" valign="top">
<td style="border-color: #000000 currentcolor #000000 #000000; border-style: solid none solid solid; border-width: 1px medium 1px 1px; padding: 0.04in 0in 0.04in 0.04in; height: 35px; width: 18.4698%;">
<p><strong>&nbsp;</strong></p>
<p><strong><em>install-elk.yml</em></strong></p>
</td>
<td style="border-color: #000000 currentcolor #000000 #000000; border-style: solid none solid solid; border-width: 1px medium 1px 1px; padding: 0.04in 0in 0.04in 0.04in; height: 35px; width: 31.5302%;">&nbsp;
<p style="margin-bottom: 0in; line-height: 100%;" align="left"><span style="font-style: normal;"><span style="font-weight: normal;">The file </span></span><em><span style="font-weight: normal;">install-elk.yml </span></em><span style="font-style: normal;"><span style="font-weight: normal;">is used, from the ansible container in the jumpbox, to install and launch ELK in the ELK </span></span><span style="font-style: normal;"><span style="font-weight: normal;">VM</span></span><span style="font-style: normal;"><span style="font-weight: normal;">. </span></span><span style="font-style: normal;"><span style="font-weight: normal;">Take special note of the published ports at the bottom of the files&mdash;by adding &ldquo;:5601&rdquo; to the public IP address of the ELK VM, the user can access Kibana, assuming everything is installed correctly.</span></span></p>
</td>
</tr>
<tr style="height: 35px;" valign="top">
<td style="border-color: #000000 currentcolor #000000 #000000; border-style: solid none solid solid; border-width: 1px medium 1px 1px; padding: 0.04in 0in 0.04in 0.04in; height: 35px; width: 18.4698%;">
<p><strong>&nbsp;<em>/etc/ansible/files/filebeat-config.yml</em></strong></p>
</td>
<td style="border-color: #000000 currentcolor #000000 #000000; border-style: solid none solid solid; border-width: 1px medium 1px 1px; padding: 0.04in 0in 0.04in 0.04in; height: 35px; width: 31.5302%;">
<p>&nbsp;<span style="font-style: normal;"><span style="font-weight: normal;">This </span></span><span style="font-style: normal;"><span style="font-weight: normal;">is the configuration file for Filebeat. Please take note of the path of this file -- /</span></span><span style="font-style: normal;"><span style="font-weight: normal;">etc/ansible/files/filebeat-config.yml &ndash; </span></span><span style="font-style: normal;"><span style="font-weight: normal;">as it is referenced to inside of the </span></span><em><span style="font-weight: normal;">filebeat-playbook.yml</span></em><span style="font-style: normal;"><span style="font-weight: normal;"> file. It is necessary to create the <em>files </em>folder prior to downloading this file.</span></span></p>
</td>
</tr>
<tr style="height: 35px;" valign="top">
<td style="border-color: #000000 currentcolor #000000 #000000; border-style: solid none solid solid; border-width: 1px medium 1px 1px; padding: 0.04in 0in 0.04in 0.04in; height: 35px; width: 18.4698%;">
<p>&nbsp;</p>
<p><em><strong>filebeat-playbook.yml</strong></em></p>
</td>
<td style="border-color: #000000 currentcolor #000000 #000000; border-style: solid none solid solid; border-width: 1px medium 1px 1px; padding: 0.04in 0in 0.04in 0.04in; height: 35px; width: 31.5302%;">&nbsp;
<p style="margin-bottom: 0in; line-height: 100%;" align="left"><span style="font-style: normal;">This is the playbook that will install and launch the Filebeat shipper in the vulnerable webserver. Filebeat will send logs to ELK for analysis.<br /></span></p>
</td>
</tr>
<tr style="height: 35px;" valign="top">
<td style="border-color: #000000 currentcolor #000000 #000000; border-style: solid none solid solid; border-width: 1px medium 1px 1px; padding: 0.04in 0in 0.04in 0.04in; height: 35px; width: 18.4698%;">
<br />
<p style="text-align: left;"><em><strong>startdocker.sh</strong> </em></p>
</td>
<td style="border-color: #000000 currentcolor #000000 #000000; border-style: solid none solid solid; border-width: 1px medium 1px 1px; padding: 0.04in 0in 0.04in 0.04in; height: 35px; width: 31.5302%;">
<p style="text-align: left;">&nbsp;This is a script that will be referenced in the crontab in order to have our container and playbooks run upon startup. It may take a minute or two for the playbooks to finish running, so Kibana will not start right away in the browser.</p>
</td>
</tr>
</tbody>
</table>
<p style="margin-bottom: 0in; line-height: 100%;"><br /> </p>
<p style="margin-bottom: 0in; line-height: 100%; text-align: center;"><h2><a id="topology">3. Description of the Topology</a></h2></p>
<p style="margin-bottom: 0in; line-height: 100%;"><br /> The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application. By utilizing one virtual machine as the "jumpbox," the containers in other VMs can be easily modified if needed without having to login and go through each VM or container individually. Automated and simplified maintenance is key.<br /> <br /> Load balancing ensures that the application will be highly efficient, in addition to keeping traffic in the network running smoothly. By distributing HTTP traffic between webservers, the webservers and the network will not be overwhelmed by hundreds or even thousands of user requests; this is why load balancers are so crucial in cyber security, as they not only help in applications running smoothly, but also help prevent attacks such as DoS attacks.<br /><br /> By intergrating an ELK server and using applications such as Filebeat, the DVWA application and webservers can be easily monitored for further analysis, which will be useful in mitigating or spotting an attack.<br /> <br /> The configuration details of each machine may be found below. When recreating a similar network, the number of virtual machines holding the DVWA containers is up to the creator's discretion--however, it may be necessary to change the virtual memory size of the ELK container accordingly to keep up with the extra resources being monitored.<br />&nbsp;</p>
<p style="margin-bottom: 0in; line-height: 100%;">&nbsp;</p>
<table width="100%" cellspacing="0" cellpadding="4">
<tbody>
<tr style="height: 35px;" valign="top">
<td style="border-color: #000000 currentcolor #000000 #000000; border-style: solid none solid solid; border-width: 1px medium 1px 1px; padding: 0.04in 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center"><strong>Name</strong></p>
</td>
<td style="border-color: #000000 currentcolor #000000 #000000; border-style: solid none solid solid; border-width: 1px medium 1px 1px; padding: 0.04in 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center"><strong>Function</strong></p>
</td>
<td style="border-color: #000000 currentcolor #000000 #000000; border-style: solid none solid solid; border-width: 1px medium 1px 1px; padding: 0.04in 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center"><strong>IP Address</strong></p>
</td>
<td style="border: 1px solid #000000; padding: 0.04in; height: 35px;" width="25%">
<p align="center"><strong>Operating System</strong></p>
</td>
</tr>
<tr style="height: 35px;" valign="top">
<td style="border-color: currentcolor currentcolor #000000 #000000; border-style: none none solid solid; border-width: medium medium 1px 1px; padding: 0in 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center">Jumpbox</p>
</td>
<td style="border-color: currentcolor currentcolor #000000 #000000; border-style: none none solid solid; border-width: medium medium 1px 1px; padding: 0in 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center">Gateway</p>
</td>
<td style="border-color: currentcolor currentcolor #000000 #000000; border-style: none none solid solid; border-width: medium medium 1px 1px; padding: 0in 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center">10.10.0.4</p>
</td>
<td style="border-color: currentcolor #000000 #000000; border-style: none solid solid; border-width: medium 1px 1px; padding: 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center">Linux</p>
</td>
</tr>
<tr style="height: 35px;" valign="top">
<td style="border-color: currentcolor currentcolor #000000 #000000; border-style: none none solid solid; border-width: medium medium 1px 1px; padding: 0in 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center">&nbsp;Target-One VM</p>
</td>
<td style="border-color: currentcolor currentcolor #000000 #000000; border-style: none none solid solid; border-width: medium medium 1px 1px; padding: 0in 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center">&nbsp;DVWA Webserver</p>
</td>
<td style="border-color: currentcolor currentcolor #000000 #000000; border-style: none none solid solid; border-width: medium medium 1px 1px; padding: 0in 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center">&nbsp;10.10.0.5</p>
</td>
<td style="border-color: currentcolor #000000 #000000; border-style: none solid solid; border-width: medium 1px 1px; padding: 0in 0.04in 0.04in; height: 35px;" width="25%"><p align="center">Linux</p></td>
</tr>
<tr style="height: 35px;" valign="top">
<td style="border-color: currentcolor currentcolor #000000 #000000; border-style: none none solid solid; border-width: medium medium 1px 1px; padding: 0in 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center">&nbsp;Target-Two VM</p>
</td>
<td style="border-color: currentcolor currentcolor #000000 #000000; border-style: none none solid solid; border-width: medium medium 1px 1px; padding: 0in 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center">DVWA Webserver</p>
</td>
<td style="border-color: currentcolor currentcolor #000000 #000000; border-style: none none solid solid; border-width: medium medium 1px 1px; padding: 0in 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center">10.10.0.6</p>
</td>
<td style="border-color: currentcolor #000000 #000000; border-style: none solid solid; border-width: medium 1px 1px; padding: 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center">&nbsp;Linux</p>
</td>
</tr>
<tr style="height: 35px;" valign="top">
<td style="border-color: currentcolor currentcolor #000000 #000000; border-style: none none solid solid; border-width: medium medium 1px 1px; padding: 0in 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center">&nbsp;Load Balancer</p>
</td>
<td style="border-color: currentcolor currentcolor #000000 #000000; border-style: none none solid solid; border-width: medium medium 1px 1px; padding: 0in 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center">Balances traffic between webservers</p>
</td>
<td style="border-color: currentcolor currentcolor #000000 #000000; border-style: none none solid solid; border-width: medium medium 1px 1px; padding: 0in 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center">40.91.81.104</p>
</td>
<td style="border-color: currentcolor #000000 #000000; border-style: none solid solid; border-width: medium 1px 1px; padding: 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center">&nbsp;Linux</p>
</td>
</tr>
<tr style="height: 35px;" valign="top">
<td style="border-color: currentcolor currentcolor #000000 #000000; border-style: none none solid solid; border-width: medium medium 1px 1px; padding: 0in 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center">&nbsp;ELK Server VM</p>
</td>
<td style="border-color: currentcolor currentcolor #000000 #000000; border-style: none none solid solid; border-width: medium medium 1px 1px; padding: 0in 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center">ELK Server</p>
</td>
<td style="border-color: currentcolor currentcolor #000000 #000000; border-style: none none solid solid; border-width: medium medium 1px 1px; padding: 0in 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center">&nbsp;10.1.0.4</p>
</td>
<td style="border-color: currentcolor #000000 #000000; border-style: none solid solid; border-width: medium 1px 1px; padding: 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center">&nbsp;Linux</p>
</td>
</tr>
</tbody>
</table>
<p style="margin-bottom: 0in; line-height: 100%;">&nbsp;</p>
<p style="margin-bottom: 0in; line-height: 100%; text-align: center;"><h2><a id="access-policies">4. Access Policies</a></h2></p>
<p style="margin-bottom: 0in; line-height: 100%;"><br /> <br />The machines on the internal network are not exposed to the public Internet. Our webservers can only be accessed through the public IP address of our load balancer. It may be necessary to reconfigure the Network Security Group settings to allow for HTTP traffic for access.<br /> <br />The webservers and ELK server can be accessed from the jumpbox VM via port 22 and SSH keys, though it may be necessary to create an inbound rule in their Security Group Settings. However, whereas the webservers's DVWA application is accessed via port 80 of the load balancer's public IP address, the ELK server's Kibana application can be accessed via port 5601 through its own public IP address (subject to change if not reserved). Through Kibana's GUI in the browser, logs can be easily monitored in a readable format.<br /> <br /> A summary of the access policies in place can be found in the table below.</p>
<p style="margin-bottom: 0in; line-height: 100%;">&nbsp;</p>
<table width="100%" cellspacing="0" cellpadding="4">
<tbody>
<tr style="height: 35px;" valign="top">
<td style="border-color: #000000 currentcolor #000000 #000000; border-style: solid none solid solid; border-width: 1px medium 1px 1px; padding: 0.04in 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center"><strong>Name</strong></p>
</td>
<td style="border-color: #000000 currentcolor #000000 #000000; border-style: solid none solid solid; border-width: 1px medium 1px 1px; padding: 0.04in 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center"><strong>IP Address</strong></p>
</td>
<td style="border: 1px solid #000000; padding: 0.04in; height: 35px;" width="25%">
<p align="center"><strong>Publicly Accessible?</strong></p>
</td>
</tr>
<tr style="height: 35px;" valign="top">
<td style="border-color: currentcolor currentcolor #000000 #000000; border-style: none none solid solid; border-width: medium medium 1px 1px; padding: 0in 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center">Jumpbox</p>
</td>
<td style="border-color: currentcolor currentcolor #000000 #000000; border-style: none none solid solid; border-width: medium medium 1px 1px; padding: 0in 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center">10.10.0.4</p>
</td>
<td style="border-color: currentcolor #000000 #000000; border-style: none solid solid; border-width: medium 1px 1px; padding: 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center">No</p>
</td>
</tr>
<tr style="height: 35px;" valign="top">
<td style="border-color: currentcolor currentcolor #000000 #000000; border-style: none none solid solid; border-width: medium medium 1px 1px; padding: 0in 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center">&nbsp;Target-One VM</p>
</td>
<td style="border-color: currentcolor currentcolor #000000 #000000; border-style: none none solid solid; border-width: medium medium 1px 1px; padding: 0in 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center">&nbsp;10.10.0.5</p>
</td>
<td style="border-color: currentcolor #000000 #000000; border-style: none solid solid; border-width: medium 1px 1px; padding: 0in 0.04in 0.04in; text-align: center; height: 35px;" width="25%"><br /><p align="center">No</p></td>
</tr>
<tr style="height: 35px;" valign="top">
<td style="border-color: currentcolor currentcolor #000000 #000000; border-style: none none solid solid; border-width: medium medium 1px 1px; padding: 0in 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center">&nbsp;Target-Two VM</p>
</td>
<td style="border-color: currentcolor currentcolor #000000 #000000; border-style: none none solid solid; border-width: medium medium 1px 1px; padding: 0in 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center">10.10.0.6</p>
</td>
<td style="border-color: currentcolor #000000 #000000; border-style: none solid solid; border-width: medium 1px 1px; padding: 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center">&nbsp;No</p>
</td>
</tr>
<tr style="height: 35px;" valign="top">
<td style="border-color: currentcolor currentcolor #000000 #000000; border-style: none none solid solid; border-width: medium medium 1px 1px; padding: 0in 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center">&nbsp;Load Balancer</p>
</td>
<td style="border-color: currentcolor currentcolor #000000 #000000; border-style: none none solid solid; border-width: medium medium 1px 1px; padding: 0in 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center">40.91.81.104</p>
</td>
<td style="border-color: currentcolor #000000 #000000; border-style: none solid solid; border-width: medium 1px 1px; padding: 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center">&nbsp;Yes</p>
</td>
</tr>
<tr style="height: 35px;" valign="top">
<td style="border-color: currentcolor currentcolor #000000 #000000; border-style: none none solid solid; border-width: medium medium 1px 1px; padding: 0in 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center">&nbsp;ELK Server VM</p>
</td>
<td style="border-color: currentcolor currentcolor #000000 #000000; border-style: none none solid solid; border-width: medium medium 1px 1px; padding: 0in 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center">&nbsp;10.1.0.4</p>
</td>
<td style="border-color: currentcolor #000000 #000000; border-style: none solid solid; border-width: medium 1px 1px; padding: 0in 0.04in 0.04in; height: 35px;" width="25%">
<p align="center">&nbsp;No</p>
</td>
</tr>
</tbody>
</table>
<p style="margin-bottom: 0in; line-height: 100%;">&nbsp;</p>
<p style="margin-bottom: 0in; line-height: 100%; text-align: center;"><br /><h2><a id="elk-config">5. ELK Configuration</a></h2></p>
<p style="margin-bottom: 0in; line-height: 100%;"><br /> Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which limits the possibility of human error. However, it should be noted that the syntax or commands within configuration files and playbooks may need to be changed to better suit particular virtual machines or needs. For example, the command&nbsp;<em><strong>curl</strong></em> in the file <em>filebeat-playbook</em><em>.yml </em>may need to be changed from to <em><strong>wget</strong></em>. <br /> <br /> The <em>install-elk.yml </em>playbook implements the following tasks:</p>
<ol>
<li style="margin-bottom: 0in; line-height: 100%;">Installs docker.io - It references the IP address listed under [elk] in ansible's <em>hosts</em> file to install docker on the target VM.</li>
<li style="margin-bottom: 0in; line-height: 100%;">Increases virtual memory - A standard container does not have enough virtual memory to run an ELK container. For 3 DVWA machines, the suggested amount is 262144.</li>
<li style="margin-bottom: 0in; line-height: 100%;">Installs python3 -- the Docker module uses python.</li>
<li style="margin-bottom: 0in; line-height: 100%;">Installs docker module</li>
<li style="margin-bottom: 0in; line-height: 100%;">Downloads and launches web container - Downloads and launches the ELK container, and lists the ports needed to access said container/application.</li>
</ol>
<p style="margin-bottom: 0in; line-height: 100%;">&nbsp;</p>
<p style="margin-bottom: 0in; line-height: 100%; text-align: center;"><h2><a id="beats">6. Beats in Use</a></h2></p>
<p style="margin-bottom: 0in; line-height: 100%;">This ELK server is configured to monitor "Target-One VM" (10.10.0.5) and "Target-Two VM" (10.10.0.6); both VMs have Filebeat installed in order to send syslogs and auditd logs to Kibana for easy monitoring, but by simply editing or creating new playbooks, more modules (such as kafka or apache) or shippers (such as Metricbeat) can be installed to monitor other types of logs or data. Below are examples of how Kibana will look as it monitors a webserver.<br /> <br /><br /></p>
<p style="margin-bottom: 0in; line-height: 100%;" align="center"><br />&nbsp; <br clear="left" /> <img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/06.PNG?raw=true" alt="Syslog monitoring through Filebeat and Kibana" /></p>
<p style="margin-bottom: 0in; line-height: 100%;" align="center"><br />&nbsp; <br clear="left" /> <img src="https://github.com/vivitranhoang/ELK_Stack_Project/blob/master/images/07.PNG?raw=true" alt="Auditd monitoring through Filebeat and Kibana" /></p>
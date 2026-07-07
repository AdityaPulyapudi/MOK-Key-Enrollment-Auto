# MOK-Key-Enrollment-Auto
MOK ( Machine Override Key ) enrollment is a task where you need to import the keys and enroll them during the Grub boot. I have created an expect automation script that will enter the key strokes. POC done on Red Hat OpenShift VM


For MOK key enrollment script to work. I need to get the console of a VM or a Physical server during bootup.
MOK menu comes up before the GRUB kernel menu, so setting a cron job script that will run on boot, i.e., (@reboot) cron jobs don't work as they need a shell.

Pre req:

1. Have a way to access the VM or Physical server's console via the CLI. For Vsphere, it is govc, ipmitool for physical servers.

2. For my POC ( Proof of Concept ), I used a Red Hat OpenShift virtualization VM and a bastion node that will provide be the console access via virtcl commands.

3. The VM on which you will take console needs to have some boot parameters set up ( serial tty ). This will facilitate console access.

My playbook, which is executed in a control node that has ssh access to my Red Hat VM and bastion node, is divided into three parts.

i: Adding the grubby parameters to my OpenShift VM that will allow the bastion to take console access
ii: Executing the Key enroll expect script on the bastion node
iii: Removing the added grubby parameters as they are not safe and might leave an attack surface. 
       ( A good admin will make the least amount of changes needed in a functioning environment ) 

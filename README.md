## Terraform

## Using Terraform Dynamic Blocks and Built-in Functions to Deploy to AWS

1. Created EC2 Instance

2. Created a role with EC2 FULL ACCESS(attaching a policy) and the ROLE is attached to the EC2   instance to get an access to the root account.

3. Connected with putty

4. Download the appropriate Terraform binary package for the provided lab server VM (Linux   64-bit) using the wget command:
     
     wget -c https://releases.hashicorp.com/terraform/0.13.4/terraform_0.13.4_linux_amd64.zip

5. Unzip the downloaded file:
     
     unzip terraform_0.13.4_linux_amd64.zip

6. Place the Terraform binary in the PATH of the VM operating system so the binary is accessible system-wide to all users:
     
     sudo mv terraform /usr/sbin/

7. Check the Terraform version information:
     
     terraform version

     Since the Terraform version is returned, we have validated that the Terraform binary is installed and working properly.

8. Create a providers directory:
     
     mkdir providers

9. Move into the providers directory:
     
     cd providers/

10. The files in the directory should include main.tf, README.md, and setup.tf. The main.tf file contains the code used to spin up an AWS EC2 instance (virtual machine) and the setup.tf contains the code for the resources that support the creation of the VM.

## fmt command

    Notice that the code in the file is pretty messy and improperly formatted, with issues like inconstent indentation, which is making it hard to read.

11. Use the terraform fmt command to format the code in any file in the directory in which Terraform finds formatting issues:

    terraform fmt

     Once the command has completed, note that Terraform returns the output main.tf, which means that Terraform found formatting issues in that file and has gone ahead and fixed those formatting issues for you.

12. View the contents of the the main.tf file again:

     cat main.tf

    Notice that the code has now been formatted cleanly and consistently.

13. Initialize the Terraform working directory and fetch any required providers:

     terraform init

14. Deploy the code:

     terraform apply

15. When prompted, type yes and press Enter.

16. When complete, it will output the public IP for the EC2 instance that is hosting the webserver as the Webserver-Public-IP value.

## Use the taint Command to Replace a Resource

17. Modify the Provisioner Code for the aws_instance.webserver Resource

     Using Vim, open the main.tf file:

     vim main.tf

    Note the name of the resource that is created by this code; in this case, it would be aws_instance.webserver as configured.

18. Inside the provisioner block, find the following line of code that outputs the content on a webpage, which currently displays Version 1:

     echo '<h 1><cen ter>My Website via Terraform Version 1< /center>< /h1>'
     In this line of code, change Version 1 to Version 2.

     Press Escape and enter :wq to save and exit the file.

19. Taint the Existing aws_instance.webserver Resource
     
     Use the terraform taint command and the name of the resource to tell Terraform to replace that resource and run the provisioner again upon the next deployment:

     terraform taint aws_instance.webserver

20. View the Terraform state file to verify that the resource has been tainted:

     vim terraform.tfstate

     Search for the keyword /taint and notice that the aws_instance resource with the name webserver has a status of tainted.

     Press Escape and enter :q! to exit the file.

21. Deploy the Code to Rerun the Provisioner and Replace the aws_instance.webserver Resource
Deploy the code:

     terraform apply

     In the plan that displays before deployment, note that it will add 1 resource and destroy 1 resource, which is in essence the replacement of the old aws_instance.webserver with the new aws_instance.webserver that is configured with the modified code. Note also that it outputs a change to the public IP of the resource via the Webserver-Public-IP value.

     Type yes and press Enter to deploy the code as planned.

     When complete, it will output the new public IP for the webserver as the Webserver-Public-IP value.

22. Use the curl command to view the contents of the webpage using the IP address provided:

     curl http://<webserver-public-IP>

     In the output that is returned, verify that it returns My Website via Terraform Version 2, validating that the provisioner was successfully run again and the tainted resource (which contained code for Version 1) was replaced with a new resource (which contained code for Version 2).

    Note: Alternately, you could open the IP address in a web browser to view the webpage's contents.

## Use the import Command to Import a Resource

23. Add the VM as a Resource Named aws_instance.webserver2 in Your Code
     
     View the contents of the resource_ids.txt file:

     cat /home/cloud_user/resource_ids.txt
     
     Copy the EC2 instance ID that is displayed in the contents of the file.

24. Open the main.tf file to modify it:

     vim main.tf

     At the bottom of the code, insert a new line and add the associated resource that will be named aws_instance.webserver2 into your main Terraform code:

     resource "aws_instance" "webserver2" {
         
         ami = data.aws_ssm_parameter.webserver-ami.value
        
         instance_type = "t3.micro"
     }
Press Escape and enter :wq to save and exit the file.

## Import the aws_instance.webserver2 Resource to Your Terraform Configuration

25. Use the terraform import command, the name of the resource in your main code, and the EC2 instance ID to tell Terraform which resource to import:

     terraform import aws_instance.webserver2 <COPIED-EC2-INSTANCE-ID>

26. View the Terraform state file to verify that the resource has been imported:

     vim terraform.tfstate
     
     Search for the keyword /webserver2 and notice that the aws_instance resource with the name webserver2 is listed and has a mode of managed.

     Press Escape and enter :q! to exit the file.

27. Modify the aws_instance.webserver2 Resource

     Open the main.tf file to modify it:

     vim main.tf

     At the bottom of the file, replace the existing code for the aws_instance.webserver2 resource with the following:

     resource "aws_instance" "webserver2" {

         ami = data.aws_ssm_parameter.webserver-ami.value
         
         instance_type = "t2.micro"
         
         subnet_id = aws_subnet.subnet.id
     }
    
    Note: Alternately, you could copy/paste the ami, instance_type, and subnet_id values from the aws_instance.webserver resource in the main.tf file and add it to the existing aws_instance.webserver2 resource in the code.

28. As a best practice, format the code before deployment:

     terraform fmt

29. Deploy the updated code:

     terraform apply

     In the plan that displays before deployment, note that it will add 1 resource and destroy 1 resource, which is in essence the replacement of the old aws_instance.webserver2 with the new aws_instance.webserver2 that is configured with the modified code. You can also scroll up in the plan and verify that aws_instance.webserver2 will be replaced.

     Type yes and press Enter to deploy the code as planned.

     In the output that is returned, verify that 1 resource was added and 1 was destroyed, validating that the old aws_instance.webserver2 resource was replaced with the new aws_instance.webserver2 containing your customized code.

30. Tear down the infrastructure you just created before moving on:

     terraform destroy

     When prompted, type yes and press Enter.

## Terraform

## Using Terraform Provisioners to Set Up an Apache Web Server on AWS

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

10. Create the file main.tf:

     vim main.tf

11. Paste in the following code from the provided GitHub repo( TerraformFundamentalsPart2 repository)

12. To save and exit the file, press Escape and enter :wq.

13. Initialize the working directory where the code is located:

     terraform init

14. Review the actions performed when you deploy the Terraform code:
     terraform plan

15. Deploy the code:

     terraform apply

16. When prompted, type yes and press Enter.

## Resource Specifications

We are creating an AWS EC2 instance (virtual machine) named webserver.

We are passing a number of parameters for the resource, such as the AMI that the VM will be spun up as, the instance type, the private key that the instance will be using, the public IP attached to the instance, the security group applied to the instance, and the subnet ID where the VM will be spun up.

Note: All of these resources are actually being created via the setup.tf file, which we can view if desired.

Examine the code in the provisioner block and note the following:

The remote-exec keyword tells us that this is a remote provisioner, which invokes a script on a remote resource after it is created.
The provisioner is using the parameters configured in the embedded connection block to connect to the AWS EC2 instance being created.
The provisioner will then issue the commands configured in the inline block to install Apache webserver on CentOS through the yum package manager, start up the Apache server, create a single web page called My Test Website With Help From Terraform Provisioner as an index.html file, and move that file into the data directory of the webserver to be served out globally.
Deploy the Code and Access the Bootstrapped Webserver
Initialize the Terraform working directory, and download the required providers:

terraform init
Validate the code to look for any errors in syntax, parameters, or attributes within Terraform resources that may prevent it from deploying correctly:

terraform validate
You should receive a notification that the configuration is valid.

Review the actions that will be performed when you deploy the Terraform code:

terraform plan
In this case, it will create 7 resources as configured in the Terraform code.

Deploy the code:

terraform apply
When prompted, type yes, and press Enter.

As the code is being deployed, we will notice that the Terraform provisioner tries to connect to the EC2 instance, and once that connection is established, it will run the bootstrapping that was configured in the provisioner block against the instance.

When complete, it will output the public IP for the Apache webserver as the Webserver-Public-IP value.

Copy the IP address, paste it in a new browser window or tab, and press Enter.

Verify that the web page displays as My Test Website With Help From Terraform Provisioner, validating that the provisioner within your code worked as intended. The commands configured in the provisioner code were issued and executed successfully on the EC2 instance that was created.

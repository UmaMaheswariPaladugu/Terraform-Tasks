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

10. Create the file main.tf:

     vim main.tf

     The main.tf file spins up AWS networking components such as a virtual private cloud (VPC), security group, internet gateway, route tables, and an EC2 instance bootstrapped with an Apache webserver which is publicly accessible.

     We have selected AWS as our provider and our resources will be deployed in the us-east-1 region.
     We are using the ssm_parameter public endpoint resource to get the AMI ID of the Amazon Linux 2 image that will spin up the EC2 webserver.
     We are using the vpc module (provided by the Terraform Public Registry) to create our network components like subnets, internet gateway, and route tables.
     For the security_group resource, we are using a dynamic block on the ingress attribute to dynamically generate as many ingress blocks as we need. The dynamic block includes the var.rules complex variable configured in the variables.tf file.
     We are also using a couple of built-in functions and some logical expressions in the code to get it to work the way we want, including the join function for the name attribute in the security group resource, and the fileexists and file functions for the user_data parameter in the EC2 instance resource.

     vim variables.tf

     The variables.tf file contains the complex variable type which we will be iterating over with the dynamic block in the main.tf file.

     vim scripts.sh

     The script.sh file is passed into the EC2 instance using its user_data attribute and the fileexists and file functions (as you saw in the main.tf file), which then installs the Apache webserver and starts up the service.

     vim outputs.tf

     The outputs.tf file returns the values we have requested upon deployment of our Terraform code.

     The Web-Server-URL output is the publicly accessible URL for our webserver. Notice here that we are using the join function for the value parameter to generate the URL for the webserver.
The Time-Date output is the timestamp when we executed our Terraform code

11. Paste in the following code from the provided GitHub repo)

12. To save and exit the file, press Escape and enter :wq.

     List the files in the directory:

     ls
    
     The files in the directory should include main.tf, outputs.tf, script.sh, and variables.tf.

13. As a best practice, format the code in preparation for deployment:

     terraform fmt

14. Initialize the working directory and download the required providers:

     terraform init

15. Validate the code to look for any errors in syntax, parameters, or attributes within 

     Terraform resources that may prevent it from deploying correctly:

     terraform validate
16. You should receive a notification that the configuration is valid.

17. Review the actions that will be performed when you deploy the Terraform code:

      terraform plan
    
    Note the Change to Outputs, where you can see the Time-Date and Web-Server-URL outputs that were configured in the outputs.tf file earlier.

18. Deploy the code:

     terraform apply --auto-approve

    Note: The --auto-approve flag will prevent Terraform from prompting you to enter yes explicitly before it deploys the code.

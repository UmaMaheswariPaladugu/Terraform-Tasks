## Terraform

## Building and Testing a Basic Terraform Module

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

8. Create a new directory called terraform_project to house your Terraform code:

     mkdir terraform_project

9. Switch to this main project directory:

     cd terraform_project

10. Create a custom directory called modules and a directory inside it called vpc:

     mkdir -p modules/vpc

11. Switch to the vpc directory using the absolute path:

     cd /home/cloud_user/terraform_project/modules/vpc/
     
     Write Terraform VPC Module Code

12. Using Vim, create a new file called main.tf:

     vim main.tf

13. Create a new file called variables.tf:

     vim variables.tf

14. Create a new file called outputs.tf:

     vim outputs.tf

    Note: The code in outputs.tf is critical to exporting values to our main Terraform code, where we'll be referencing this module. Specifically, it returns the subnet and AMI IDs for your EC2 instance.

15. Write our Main Terraform Project Code

16. Switch to the main project directory:

     cd ~/terraform_project

17. Create a new file called main.tf:

     vim main.tf

    Note: The code in main.tf invokes the VPC module that we created earlier. Notice how we're referencing the code using the source option within the module block to let Terraform know where the module code resides.

18. Create a new file called outputs.tf:

     vim outputs.tf

19. Deploy our Code and Test Out our Module

20. Format the code in all of your files in preparation for deployment:

     terraform fmt -recursive

21. Initialize the Terraform configuration to fetch any required providers and get the code being referenced in the module block:

     terraform init

22. Validate the code to look for any errors in syntax, parameters, or attributes within Terraform resources that may prevent it from deploying correctly:

     terraform validate

    we should receive a notification that the configuration is valid.

24. Review the actions that will be performed when you deploy the Terraform code:

     terraform plan
    In this case, it will create 3 resources, which includes the EC2 instance configured in the root code and any resources configured in the module. If you scroll up and view the resources that will be created, any resource with module.vpc in the name will be created via the module code, such as module.vpc.aws_vpc.this.

25. Deploy the code:

     terraform apply --auto-approve
    Note: The --auto-approve flag will prevent Terraform from prompting you to enter yes explicitly before it deploys the code.

     Once the code has executed successfully, note in the output that 3 resources have been created and the private IP address of the EC2 instance is returned as was configured in the outputs.tf file in your main project code.

26. View all of the resources that Terraform has created and is now tracking in the state file:

     terraform state list

     The list of resources should include your EC2 instance, which was configured and created by the main Terraform code, and 3 resources with module.vpc in the name, which were configured and created via the module code.

27. Tear down the infrastructure you just created before moving on:

     terraform destroy

     When prompted, type yes and press Enter.

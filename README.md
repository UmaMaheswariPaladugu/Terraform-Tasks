## Terraform

Terraform configuration files
## Installing Terraform and Working with Terraform Providers

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

11. Paste in the following code from the provided GitHub repo( Terraform fundamentals repository):

12. To save and exit the file, press Escape and enter :wq.

13. Initialize the working directory where the code is located:

       terraform init

14. Review the actions performed when you deploy the Terraform code:

       terraform plan

    Note: Two resources will be created, consistent with the providers that were configured in the provided code snippet.

15. Deploy the code:

       terraform apply
   
       When prompted, type yes and press Enter.

## Verify that the resource was created as per specification in the AWS Management Console:

1. Verify that two resources were created with their corresponding Amazon Resource Name (ARN) IDs in the region in which they were spun up.

2. Optionally, verify that the resources were created in their respective regions within the AWS Management Console:

3. Navigate to the AWS Management Console in your browser.
Verify that you are logged in to the us-east-1 region upon signing in and 
Click Services.
Type SNS in the search bar and select Simple Notification Service from the contextual menu.
In the menu on the left, click Topics.
Verify that the topic-us-east resource appears in the list.
At the top-right, click N. Virginia and select us-west-2.
Verify that the topic-us-west resource appears in the list.
4. Tear down the infrastructure you just created before moving on:

   terraform destroy --auto-approve

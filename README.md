## Terraform

Terraform configuration files

# Terraform

## DEPLOYING A VM IN AWS USING THE TERRAFORM WORKFLOW

1. Create a Directory and Write Your Terraform Code (Write)

   In the CLI, create a new directory in the cloud_user's home directory called terraform_code to house our Terraform code:mkdir terraform_code
   
   Switch to the new directory: cd terraform_code
2. Using vi, creating a new file called main.tf where we will write our code: vi main.tf
   
   Press Escape and enter :wq to save and exit the file.
3. Plug the specified AMI and Subnet ID Values Into our Code in main.tf file.
   
   Press Escape and enter :wq to save and exit the file.

4. terraform init:-Review the actions that will be performed when we deploy our code:
5. terraform plan:-In this case, it will create 1 resource: the EC2 instance we configured in our code.

6. If we scroll up, we will notice that only the ami, instance_type, subnet_id, and tags properties are configured, as that was included in our code.

7. Everything else, denoted with a + sign, will be created from scratch or will be populated when Terraform creates the resource upon deployment of our code.

8. Deploy Your Terraform Code (Apply), Verify our Resources, and Clean Up
   
   Deploy the code:terraform apply

   When prompted, type yes and press Enter.

   Once the code has executed successfully, note in the output that 1 resource has been created.

Note: we could also use the terraform output command at any time in the CLI to view the output on demand.

## Verify that the resource was created correctly in the AWS Management Console:

Navigate to the AWS Management Console in our browser.
Type EC2 in the search bar and select EC2 from the contextual menu.
On the Resources page, click Instances (running).
Verify that the instance, named my-first-tf-node (as configured in our code), appears in the list.
Back in the CLI, remove the infrastructure we just created:

9. terraform destroy
In the plan output, notice that it will destroy 1 resource: the EC2 instance you just created.

Note: we can also scroll through the rest of the plan output and view the properties of the resource that will be destroyed, if desired.

When prompted, type yes and press Enter.

In the notifications displayed in the CLI, note that the aws_instance.vm resource we created is now being destroyed.

10. In the AWS Management Console, click the refresh button inside the Instances page and verify that the my-first-tf-node instance no longer appears in the list.



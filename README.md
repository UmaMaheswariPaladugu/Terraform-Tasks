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

11. Paste in the following code from the provided GitHub repo)

12. To save and exit the file, press Escape and enter :wq.

     List the files in the directory:

     ls
    
     The files in the directory should include main.tf, outputs.tf, script.sh, and variables.tf.

13. Initialize the working directory where the code is located:

     terraform init

14. Review the actions performed when you deploy the Terraform code:
     terraform plan

15. Deploy the code:

     terraform apply

16. When prompted, type yes and press Enter.

## Resource Specifications

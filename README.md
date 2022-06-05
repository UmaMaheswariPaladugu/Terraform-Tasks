## Terraform

1. Created EC2 Instance

2. Created a role with EC2 FULL ACCESS(attaching a policy) and the ROLE is attached to the EC2   instance to get an access to the root account.

3. Connected with putty

4. Create Access Key and Secret Key; Discover Subnet
        Navigate to IAM > Users.
        Click on the provided cloud_user.
        Click the Security credentials tab.
        Click Create access key.
        Copy the Access key ID and Secret access key, and paste them into a text file.
        Navigate to VPC > Subnets.
        Copy the subnet ID, and paste it into the same text file.
        Write Template Based on Provided Instructions
        In the terminal, change to the packer/booksite directory:

5. cd packer/booksite/

6. Create a packer.json file:

7. vim packer.json

     Enter the following template, updating the aws_access_key, aws_secret_key, and aws_subnet_id with the values

## Test the Build

8. Validate the file:

9. packer validate packer.json

10. Build the image:

11. packer build packer.json

It may take several minutes for it to finish. 

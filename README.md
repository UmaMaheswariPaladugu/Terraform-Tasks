## Terraform

## Exploring Terraform State Functionality

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

    Note: If you receive a notification that there is a newer version of Terraform available, you can ignore it — the lab will run safely with the version installed on the VM.

Check the Minikube Status

minikube status
The minikube status command should return host,kubelet, and apiserver in Running state and kubeconfig in Configured state. It will look something similar to this:

minikube
type: Control Plane
host: Running
kubelet: Running
apiserver: Running
kubeconfig: Configured

8. Create a providers directory:
     
     mkdir providers

9. Move into the providers directory:
     
     cd providers/

10. Create the file main.tf:

     vim main.tf

     The code is configured with Kubernetes as the provider, allowing Terraform to interact with the Kubernetes API to create and destroy resources. Within the kubernetes_deployment resource, the replicas attribute controls the number of deployments, which in turn controls the number of pods being deployed.

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


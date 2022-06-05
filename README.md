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

11. Paste in the following code from the provided GitHub repo

12. To save and exit the file, press Escape and enter :wq.

13. Initialize the working directory where the code is located:

     terraform init

14. Review the actions performed when you deploy the Terraform code:
     
     terraform plan

     In this case, it will create 2 resources as configured in the Terraform code.

15. List the files in the directory:

     ls
     
     Notice that the list of files does not include the terraform.tfstate at this time. You must deploy the Terraform code for the state file to be created.

16. Deploy the code:

     terraform apply

16. When prompted, type yes and press Enter.

## Observe How the Terraform State File Tracks Resources

Once the code has executed successfully, list the files in the directory:

     ls
     
     Notice that the terraform.tfstate file is now listed. This state file tracks all the resources that Terraform has created.

Optionally, verify that the pods required were created by the code as configured using kubectl:

     kubectl get pods

     There are currently 2 pods in the deployment.

List all the resources being tracked by the Terraform state file using the terraform state command:

     terraform state list

There are two resources being tracked: kubernetes_deployment.tf-k8s-deployment and kubernetes_service.tf-k8s-service.

View the replicas attribute being tracked by the Terraform state file using grep and the kubernetes_deployment.tf-k8s-deployment resource:

terraform state show kubernetes_deployment.tf-k8s-deployment | egrep replicas

There should be 2 replicas being tracked by the state file.

Open the main.tf file to edit it:

      vim main.tf

Change the integer value for the replicas attribute from 2 to 4.

Press Escape and enter :wq to save and exit the file.

Review the actions that will be performed when you deploy the Terraform code:

     terraform plan

In this case, 1 resource will change: the kubernetes_deployment.tf-k8s-deployment resource for which we have updated the replicas attribute in our Terraform code.

Deploy the code again:

     terraform apply

When prompted, type yes and press Enter.

Optionally, verify that the pods required were created by the code as configured:

     kubectl get pods

There are now 4 pods in the deployment.

View the replicas attribute being tracked by the Terraform state file again:

terraform state show kubernetes_deployment.tf-k8s-deployment | egrep replicas
There should now be 4 replicas being tracked by the Terraform state file. It is accurately tracking all changes being made to the Terraform code.

#Tear Down the Infrastructure

Remove the infrastructure you just created:

     terraform destroy

When prompted, type yes and press Enter.

List the files in the directory:

     ls

Notice that Terraform leaves behind a backup file — terraform.tfstate.backup — in case we need to recover to the last deployed Terraform state.


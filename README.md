# AzureProj


Documentation for 2-Layered Custom Machine Image and its Workflow:

This is a custom machine image that consists of two layers: Prerequisite layer and Application layer. The prerequisite layer installs .NET Core SDK on a Windows Server 2019 virtual machine, while the application layer installs Git and clones a .NET Core application from a GitHub repository. The virtual machine image is created using Packer and is stored as a managed image in Azure.

Here are the steps involved in creating this custom machine image:

Define Variables: The variable block defines the input variables used in the Packer template. These variables are used to store the subscription ID, client ID, client secret, and tenant ID of the Azure service principal.

Define Azure Resource: The source block defines the Azure resource to be created, which is a Windows Server 2019 virtual machine. The managed_image_resource_group_name and managed_image_name fields specify the name of the managed image that will be created. The os_type, image_publisher, image_offer, and image_sku fields define the version of the operating system to be used. The vm_size and location fields define the size and location of the virtual machine. The communicator field specifies that the WinRM protocol will be used to communicate with the virtual machine. The winrm_use_ssl, winrm_insecure, winrm_timeout, winrm_username, and winrm_password fields specify the WinRM settings to use when communicating with the virtual machine.

Define Build Block: The build block defines the build process for the Packer template. The sources field specifies the source for the build, which is the source.azure-arm.prerequisite_layer or source.azure-arm.application_layer block, depending on whether the prerequisite or application layer is being built. The provisioner block specifies the steps to be executed during the build process. In this case, the PowerShell provisioner is used to execute PowerShell commands on the virtual machine.

Workflow: The workflow defines the jobs that are executed when changes are pushed to the main branch. The build job runs on an Ubuntu virtual machine and consists of several steps. First, the repository is checked out. Next, the Azure CLI is installed. Then, Packer is set up using the hashicorp/setup-packer action. The azure/login action is used to log in to Azure using the service principal credentials stored as GitHub secrets. Finally, the packer build command is executed to create the prerequisite and application layers using the Packer templates.

Note that the var options in the packer build commands pass the input variables defined in the variable block to the Packer template using GitHub secrets. These secrets are securely stored and encrypted by GitHub.

Overall, this custom machine image is useful for creating a virtual machine image that can be used as a base for deploying .NET Core applications in Azure. The two layers allow for customization and reusability of the image, while Packer simplifies the process of creating and managing the image. The GitHub workflow automates the build process, making it easy to maintain and update the custom machine image.

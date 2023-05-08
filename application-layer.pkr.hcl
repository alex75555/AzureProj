variable "subscription_id" {
  type    = string
  sensitive = true
}

variable "client_id" {
  type    = string
  sensitive = true
}

variable "client_secret" {
  type    = string
  sensitive = true
}

variable "tenant_id" {
  type    = string
  sensitive = true
}




source "azure-arm" "application_layer" {
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id

  managed_image_resource_group_name = "MainGroup"
  managed_image_name                = "windows-server-2019-dotnet-core-app"

  os_type         = "Windows"
  image_publisher = "MicrosoftWindowsServer"
  image_offer     = "WindowsServer"
  image_sku       = "2019-Datacenter"

  vm_size = "Standard_DS1_v2"
  location = "SwedenCentral"

  communicator = "winrm"
  winrm_use_ssl = true
  winrm_insecure = true
  winrm_timeout = "3m"
  winrm_username = "packer"
  winrm_password = "Test1234"
}

build {
  sources = ["source.azure-arm.application_layer"]

  provisioner "powershell" {
    inline = [
      "Set-ExecutionPolicy Bypass -Scope Process -Force",
      "[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072",
      "iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))",
      "choco install git -y",
      "cmd.exe /c '\"C:\\Program Files\\Git\\bin\\git.exe\" clone https://github.com/alex75555/NetCoreAppSolution'"
    ]
  }
}


variable "subscription_id" {
  type = string
}

variable "client_id" {
  type = string
}

variable "client_secret" {
  type = string
}

variable "tenant_id" {
  type = string
}

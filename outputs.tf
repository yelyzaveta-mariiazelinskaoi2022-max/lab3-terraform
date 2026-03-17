output "vm_public_ip" {
  description = "Public IP address of the virtual machine"
  value       = aws_instance.web.public_ip
}

output "vm_name" {
  description = "Name of the virtual machine"
  value       = aws_instance.web.tags["Name"]
}

output "ami_image_name" {
  description = "Name of the AMI image used"
  value       = data.aws_ami.ubuntu.name
}

output "website_url" {
  description = "Full URL to access the web service"
  value       = "http://${aws_instance.web.public_ip}:${var.web_port}"
}

output "ssh_command" {
  description = "SSH command to connect to the VM"
  value       = "ssh -i ${local.name_prefix}-key.pem ubuntu@${aws_instance.web.public_ip}"
}
variable "tage-name"{
    description= "ec2 name "
    type= string 
}
resource "aws_instance" "my-ec2"{
    ami="ami-06b6c7fea532f597e"
    instance_type="t2.micro"
   ## vpc_security_group_ids = [aws_security_group.allow_tls.id]
    
    tags = {
        "Name" = var.tage-name
  }
}

resource  "aws_eip" "my-eip"{
    vpc = true
}

resource "aws_eip_association" "associate"{
    instance_id=aws_instance.my-ec2.id
    allocation_id=aws_eip.my-eip.id

}

output "eip_value_public" {
    description = "VMs Public IP"
    value= aws_instance.my-ec2.public_ip

}
output "eip_value_private" {
    description = "VMs Private IP"
    value= aws_instance.my-ec2.private_ip

}
output "id" {
    description = "VMs Private IP"
    value= aws_instance.my-ec2.id

}
##output "security_groups" {
  ##  description = "VMs Private IP"
    ##value= aws_security_group.allow_tls

##}
terraform {
    backend "s3" {
    bucket = "kiro-bucket"
    key    = "tfstate"
    region = "eu-north-1"
  }
}
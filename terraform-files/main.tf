resource "aws-instance" "test-server" {
  ami = "ami-0e86e20dae9224db8"
  instance_type = "t2.micro"
  key_name = "Utkarshkey"
  vpc_security_group_ids = ["sg-03d32bf60d66083fc"]
  connection {
     type = "ssh"
     user = "ubuntu"
     private_key = file("./Utkarshkey.pem")
     host = self.public_ip
     }
  provisioner "remote-exec" {
     inline = ["echo 'wait to start the instance' "]
     }
  tags = {
     Name = "test-server"
     }
  provisioner "local-exec" {
     command = "echo ${aws_instance.test-server.public_ip} > inventory"
     }

  provisioner "local-exec" {
     command = "ansible-playbook /var/lib/jenkins/workspace/FinanceMe/terraform-files/ansibleplaybook.yml"
     }
  }

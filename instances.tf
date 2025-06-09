# This Terraform configuration creates 10 EC2 instances in AWS with a specific security group for RDP access.
resource "aws_instance" "ec2_instances" {
  count                       = 10
  ami                         = "ami-070f90bab72874c6f"
  instance_type               = "t3.medium"
  subnet_id                   = aws_subnet.darweesh_subnet.id
  vpc_security_group_ids      = [aws_security_group.darweesh_sg.id]
  associate_public_ip_address = true
  key_name                    = "windows-key"
  tags = {
    Name = "darweesh-${count.index + 1}"
  }
}
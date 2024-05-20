resource "aws_instance" "node-aws-tf-ec2" {
  ami           = "ami-"
  instance_type = "t3.micro"
  key_name      = "devops"
  subnet_id     = aws_subnet.private-us-east-1a.id

  vpc_security_group_ids = [aws_security_group.node-aws-tf-ec2.id]

  tags = {
    Name = "node-aws-tf-ec2"
  }
}
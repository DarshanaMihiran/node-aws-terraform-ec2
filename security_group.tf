// Create a security group with the same app name
 resource "aws_security_group" "node-aws-tf-ec2" {
  name        = "node-aws-tf-ec2"
  description = "Allow API Access"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow Health Checks"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  // open egress traffic - [-1] for all protocols
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }  
}
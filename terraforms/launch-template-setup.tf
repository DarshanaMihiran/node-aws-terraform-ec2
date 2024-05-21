resource "aws_launch_template" "node-aws-tf-sample-app" {
  name                   = "node-aws-tf-sample-app"
  image_id               = "ami-0d5482f3cb962780f"
  key_name               = "devops"
  vpc_security_group_ids = [aws_security_group.node-aws-tf-sample-app.id]
}
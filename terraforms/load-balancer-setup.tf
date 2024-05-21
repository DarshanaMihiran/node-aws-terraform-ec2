resource "aws_lb_target_group" "node-aws-tf-sample-app" {
  name     = "node-aws-tf-sample-app"
  port     = 8080
  protocol = "TCP"
  vpc_id   = aws_vpc.main.id

  health_check {
    enabled  = true
    protocol = "TCP"
  }
}

resource "aws_lb" "node-aws-tf-sample-app" {
  name               = "node-aws-tf-sample-app"
  internal           = true
  load_balancer_type = "network"

  subnets = [
    aws_subnet.private-us-east-1a.id,
    aws_subnet.private-us-east-1b.id
  ]
}

resource "aws_lb_listener" "node-aws-tf-sample-app" {
  load_balancer_arn = aws_lb.node-aws-tf-sample-app.arn
  port              = "8080"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.node-aws-tf-sample-app.arn
  }
}
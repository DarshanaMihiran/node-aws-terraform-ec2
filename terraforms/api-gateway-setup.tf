resource "aws_apigatewayv2_api" "node-aws-tf-sample-app" {
  name          = "node-aws-tf-sample-app"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "dev" {
  api_id = aws_apigatewayv2_api.node-aws-tf-sample-app.id

  name        = "dev"
  auto_deploy = true
}

resource "aws_apigatewayv2_vpc_link" "node-aws-tf-sample-app" {
  name               = "node-aws-tf-sample-app"
  security_group_ids = [aws_security_group.node-aws-tf-sample-app.id]
  subnet_ids = [
    aws_subnet.private-us-east-1a.id,
    aws_subnet.private-us-east-1b.id
  ]
}

resource "aws_apigatewayv2_integration" "node-aws-tf-sample-app" {
  api_id = aws_apigatewayv2_api.node-aws-tf-sample-app.id

  integration_uri    = aws_lb_listener.node-aws-tf-sample-app.arn
  integration_type   = "HTTP_PROXY"
  integration_method = "ANY"
  connection_type    = "VPC_LINK"
  connection_id      = aws_apigatewayv2_vpc_link.node-aws-tf-sample-app.id
}

resource "aws_apigatewayv2_route" "node-aws-tf-sample-app" {
  api_id = aws_apigatewayv2_api.node-aws-tf-sample-app.id

  route_key = "ANY /{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.node-aws-tf-sample-app.id}"
}
resource "aws_apigatewayv2_api" "node-gw" {
  name          = "node-gw"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "prod" {
  api_id = aws_apigatewayv2_api.node-gw.id
  name        = "prod"
  auto_deploy = true
}

resource "aws_apigatewayv2_integration" "node-gw" {
  api_id = aws_apigatewayv2_api.node-gw.id

  integration_type   = "HTTP_PROXY"
  integration_uri    = "http://${aws_instance.node-gw.public_ip}:8080/{proxy}"
  integration_method = "ANY"
  connection_type    = "INTERNET"
}

resource "aws_apigatewayv2_route" "node-gw" {
  api_id = aws_apigatewayv2_api.node-gw.id

  route_key = "ANY /{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.node-gw.id}"
}

output "api_gw_example_1_health_url" {
  value = "${aws_apigatewayv2_stage.prod.invoke_url}/health"
}
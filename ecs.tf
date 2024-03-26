resource "aws_ecs_cluster" "ecs_workload" {
  name = "ecs-${terraform.workspace}"

  tags = merge(
    {
      "Name" : "ECS-cluster-${terraform.workspace}"
  }, var.default_tags)
}

resource "aws_ecs_task_definition" "ecs_td_nginx" {
  family                   = "nginx-td-${terraform.workspace}"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.ecsTaskExecutionRole.arn
  container_definitions = jsonencode([{
    name      = var.container_name
    image     = "nginx:latest"
    essential = true
    portMappings = [{
      containerPort = 80
      hostPort      = 80
    }]
  }])


  tags = merge(
    {
      "Name" : "nginx-ecs-taskdef-${terraform.workspace}"
  }, var.default_tags)
}

resource "aws_ecs_service" "ecs_sd_nginx" {
  name            = "nginx-${terraform.workspace}"
  cluster         = aws_ecs_cluster.ecs_workload.id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.ecs_td_nginx.arn
  desired_count   = var.replicas

  network_configuration {
    security_groups  = [aws_security_group.ecssg.id]
    subnets          = aws_subnet.ecssubnets.*.id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.maintg.id
    container_name   = var.container_name
    container_port   = var.container_port
  }

  enable_ecs_managed_tags = true
  propagate_tags          = "SERVICE"

  depends_on = [aws_alb_listener.listener_http]

  tags = merge(
    {
      "Name" : "nginx-ecs-service-${terraform.workspace}"
  }, var.default_tags)
}

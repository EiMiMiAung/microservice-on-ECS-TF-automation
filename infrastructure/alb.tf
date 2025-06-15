resource "aws_lb" "bookinfo_alb" {
  name               = "bookinfo-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [for subnet in aws_subnet.public_subnet : subnet.id]
  security_groups    = [aws_security_group.alb_sg.id]

  tags = {
    Name = "bookinfo-alb"
  }
}

resource "aws_lb_target_group" "productpage_tg" {
  name        = "productpage-tg"
  port        = 9080
  protocol    = "HTTP"
  vpc_id      = aws_vpc.bookinfo_vpc.id
  target_type = "ip"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
  }

  tags = {
    Name = "productpage-tg"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.bookinfo_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.productpage_tg.arn
  }
}

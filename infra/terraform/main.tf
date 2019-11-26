provider "aws" {
  profile = "default"
  regiton = "eu-central-1"
}

locals {
  name        = "my-blog"
  environment = "dev"
  # This is the convention we use to know what belongs to each other
  ec2_resources_name = "${local.name}-${local.environment}"
}

#----- VPC -----
# module "vpc" {
#   source  = "terraform-aws-modules/vpc/aws"
#   version = "~> 2.0"

#   name    = local.name
#   cidr    = "10.1.0.0/16"

#   azs             = ["eu-central-1a", "eu-central-1b"]
#   private_subnets = ["10.1.1.0/24", "10.1.2.0/24"]
#   public_subnets  = ["10.1.11.0/24", "10.1.12.0/24"]

#   enable_nat_gateway = true # this is faster, but should be "true" for real

#   tags = {
#     Environment = local.environment
#     Name        = local.name
#   }
# }

#----- ECS --------
resource "aws_ecs_cluster" "my-blog" {
  name = local.name
}

resource "aws_ecs_service" "my-blog" {
  name            = local.name
  cluster         = "${aws_ecs_cluster.my-blog.id}"
  task_definition = "${aws_ecs_task_definition.my-blog.arn}"
  desired_count   = 1
  # iam_role        = "${aws_iam_role.my-blog.arn}"
  # depends_on      = ["aws_iam_role_policy.my-blog"]

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  # load_balancer {
  #   target_group_arn = "${aws_lb_target_group.foo.arn}"
  #   container_name   = "mongo"
  #   container_port   = 8080
  # }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [eu-central-1a, eu-central-1b]"
  }
}

resource "aws_ecs_task_definition" "my-blog" {
  family                = "my-blog"
  container_definitions = "${file("task-definitions/blog.json")}"

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [eu-central-1a, eu-central-1b]"
  }
}

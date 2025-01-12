# Titles our Application
resource "aws_elastic_beanstalk_application" "my_web_app" {
  name = "my-web-app"
  description = "My Web App"

  tags = {
    Project = "EBSDeploymentProject"
  }
}

# Creates the App Enviroment
resource "aws_elastic_beanstalk_environment" "nextjs_env" {
    name                = "nextjs-env"
    application         = aws_elastic_beanstalk_application.my_web_app.name
    solution_stack_name = "64bit Amazon Linux 2023 v6.4.1 running Node.js 18"
    wait_for_ready_timeout = "20m"
    version_label = aws_elastic_beanstalk_application_version.nextjs_app_version.name
    tier = "WebServer"

    setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name = "DisableIMDSv1"
        value = "true"
    }

    setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name      = "IamInstanceProfile"
        value     = var.instance_profile
    }

    setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name      = "InstanceType"
        value     = "t2.micro"
    }

    setting {
        namespace = "aws:ec2:vpc"
        name      = "VPCId"
        value     = var.vpc_id
    }

    setting {
        namespace = "aws:ec2:vpc"
        name      = "Subnets"
        value     = var.subnet_id
    }

    tags = {
        Project = "EBSDeploymentProject"
    }
}

# Creates App Version
resource "aws_elastic_beanstalk_application_version" "nextjs_app_version" {
    name = "nextjs-app-version-V1.0.0"
    application = aws_elastic_beanstalk_application.my_web_app.name
    bucket = var.s3_bucket
    key = var.s3_key

    lifecycle {
        create_before_destroy = true
    }
}
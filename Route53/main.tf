# Create Route53 Zone
resource "aws_route53_zone" "app_zone" {
  name = "ebsdeploymentproject.com"

  tags = {
    Name = "EBSRoute53Zone"
    Project = "EBSDeploymentProject"
  }
}

# Attach Zone to Beanstalk 
resource "aws_route53_record" "alias" {
  zone_id = aws_route53_zone.app_zone.id
  name    = "ebsdeploymentproject.com" # Replace with your domain name
  type    = "A"

  alias {
    name                   = "awseb-e-y-AWSEBLoa-DJ1P48UJFA7G-1629739763.us-east-1.elb.amazonaws.com"
    zone_id                = "Z35SXDOTRQ7X7K"
    evaluate_target_health = false
  }
}

# Create WWW Record
resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.app_zone.id
  name    = "www.ebsdeploymentproject.com"
  type    = "CNAME"
  ttl     = 300
  records = ["ebsdeploymentproject.com"]
}
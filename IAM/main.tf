# Creates a role
resource "aws_iam_role" "ebs_instance_role" {
  name = "ebs-instance-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Effect    = "Allow"
      }
    ]
  })

  tags = {
    Project = "EBSDeploymentProject"
  }
}

# Add S3 Read Policy to Role 
resource "aws_iam_role_policy" "s3_read_access" {
  name = "s3-read-access-policy"
  role = aws_iam_role.ebs_instance_role.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:ListBucket"

        ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:s3:::archived-app",      # Allow listing the bucket
          "arn:aws:s3:::archived-app/*"     # Allow accessing objects in the bucket
        ]
      }
    ]
  })
}

# Attaches role to a policy
resource "aws_iam_role_policy_attachment" "ebs_instance_policy" {
  role       = aws_iam_role.ebs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"  # Attach a predefined policy for EB instances
}

# Creates instance profile with rules
resource "aws_iam_instance_profile" "ebs_instance_profile" {
  name = "ebs-instance-profile"
  role = aws_iam_role.ebs_instance_role.name
 
  tags = {
    Project = "EBSDeploymentProject"
  }
}

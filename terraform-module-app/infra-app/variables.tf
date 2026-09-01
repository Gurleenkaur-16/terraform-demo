variable env {
  description = " This is the Environment for my infra"
  type = string
}

variable bucket_name {
  description = "This is the name of the S3 bucket"
  type = string
}

variable instance_count {
  description = "This is the number of EC2 instances to be created"
  type = number
}

variable instance_type {
  description = "This is the type of EC2 instance to be created"
  type = string
}

variable ec2_ami_id {
  description = "This is the AMI ID for the EC2 instance"
  type = string
}

variable hash_key {
  description = "This is the hash key for the DynamoDB table"
  type = string
}

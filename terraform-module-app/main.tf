module "dev-infra" {
  source = "./infra-app"
  env = "dev"
  bucket_name = "gurleen-infra-app-bucket"
  instance_count = 1
  instance_type = "t2.micro"
  ec2_ami_id = "ami-06468be052a4195a6"
  hash_key = "studentId"

}

module "prod-infra" {
  source = "./infra-app"
  env = "prod"
  bucket_name = "gurleen-infra-app-bucket"
  instance_count = 2
  instance_type = "t2.medium"
  ec2_ami_id = "ami-06468be052a4195a6"
  hash_key = "studentId"

}

module "stag-infra" {
  source = "./infra-app"
  env = "stag"
  bucket_name = "gurleen-infra-app-bucket"
  instance_count = 1
  instance_type = "t2.small"
  ec2_ami_id = "ami-06468be052a4195a6"
  hash_key = "studentId"

}

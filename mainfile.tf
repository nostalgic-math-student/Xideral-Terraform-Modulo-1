provider "aws" {
  region = "us-east-1"
}

module "s3_bucket" {
  source       = "./modules/s3_uploader"
  local_folder = "./data"
  bucket_name  = "josuexideralterraformmodule1"

  bucket_policy = <<EOT
  {
    "Version": "2012-10-17",
    "Id": "HTTP referer policy example",
    "Statement": [
        {
            "Sid": "Allow only GET requests originating from www.example.com and example.com.",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject",
                "s3:GetObjectVersion"
            ],
            "Resource": "arn:Bucket-ARN-HERE/*"
        }
    ]
}
  EOT
}

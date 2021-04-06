resource "aws_kms_key" "alias" {
  description = var.kms_key_description
  tags = var.tags
  deletion_window_in_days = var.kms_deletion_window_in_days
}

resource "aws_kms_alias" "description" {
  name = "alias/${lower(var.kms_key_alias)}"
  target_key_id = aws_kms_key.alias.key_id
}

resource "aws_s3_bucket" "log_bucket" {
  bucket = "log-${var.s3_bucket}"
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket" "app_bucket" {
  bucket = var.s3_bucket
  acl    = "private"
  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "log/"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.alias.key_id
        sse_algorithm     = "aws:kms"
      }
    }
  }

  lifecycle_rule {
    id = "demo"

    prefix = "demo/"

    enabled = true

    expiration {
      days = 7
    }
  }
  tags = var.tags   

}

resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket                  = aws_s3_bucket.app_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "demo-policy" {
  bucket = aws_s3_bucket.app_bucket.id

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "Policy1357935677554",
    "Statement": [
        {
            "Sid": "Stmt1357935647218",
            "Effect": "Allow",
            "Principal": {
                "AWS": "${data.aws_caller_identity.current.arn}"
            },
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::${var.s3_bucket}"
        },
        {
            "Sid": "Stmt1357935676138",
            "Effect": "Allow",
            "Principal": {
                "AWS": "${data.aws_caller_identity.current.arn}"
            },
            "Action": [
                "s3:GetObject",
                "s3:PutObject"
            ],
            "Resource": "arn:aws:s3:::${var.s3_bucket}/*"
        }
    ]
}
POLICY
}
resource "aws_kms_key" "alias" {
  description = var.kms_key_description
  tags = {
      Name = var.s3_bucket
      Env = var.s3_prefix
  }
  deletion_window_in_days = var.kms_deletion_window_in_days
}

resource "aws_kms_alias" "description" {
  name = "alias/${lower(var.kms_key_alias)}"
  target_key_id = aws_kms_key.alias.key_id
}

resource "aws_s3_bucket" "log_bucket" {
  bucket = var.s3_logbucket
  acl    = "log-delivery-write"
}
resource "aws_s3_bucket_object" "folder" {
  bucket = var.s3_logbucket
  acl = "bucket-owner-full-control"
  key =  var.s3_prefix
  content_type = "application/x-directory"
  kms_key_id = aws_kms_key.alias.arn
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.s3_bucket
  acl    = "private"
  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = var.s3_prefix
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
  tags = {
      Name = var.s3_bucket
      Env = var.s3_prefix
  }  

}

resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket                  = aws_s3_bucket.bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

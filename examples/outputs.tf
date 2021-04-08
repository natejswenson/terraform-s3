output "kms_key_arn" {
    value = aws_kms_key.alias.arn
}

output "kms_key_id" {
    value = aws_kms_key.alias.key_id
}

output "kms_key_alais_arn" {
    value = aws_kms_alias.description.arn
}

output "kms_key_alias_name" {
    value = aws_kms_alias.description.name
}
output "s3_logbucket" {
     value = aws_s3_bucket.log_bucket.id
}


output "s3_prefix" {
  value = tolist(aws_s3_bucket.bucket.logging)[0]
}

output "s3_bucket" {
    value = aws_s3_bucket.bucket.id
}

output "region" {
    value = var.aws_region
}
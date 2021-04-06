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

output "name" {
    value = var.s3_bucket
}

output "region" {
    value = var.aws_region
}
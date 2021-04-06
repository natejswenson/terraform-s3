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

output "account_id" {
    value = data.aws_caller_identity.current.account_id
}

output "caller_user" {
    value = data.aws_caller_identity.current.user_id
}

output "caller_arn" {
    value = data.aws_caller_identity.current.arn
}
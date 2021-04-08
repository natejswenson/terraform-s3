########################################################################################
#KMS KEYS
#########################################################################################
variable "kms_key_alias" {
    type = string
    description = "short alias for kms key"
    default = "dev-natekms"
}
variable "kms_key_description" {
    type = string
    description = "same as kms_key_alias in our example"
    default = "dev-nate-kms"
}
variable "kms_deletion_window_in_days" {
    description = "days to keep kms keys ( 7-30 )"
    default = "7"
}

########################################################################################
#S3 BUCKET
#########################################################################################
variable "s3_bucket" {
    description = "s3 bucket name"
    default = "nate-test-dev"
}
variable "s3_prefix" {
    description = "prefix location to store log files in log bucket"
    default = "dev/"
}
variable "s3_logbucket" {
    description  = "bucket where log files are stored"
    default = "nate-test-log"
}

########################################################################################
#AWS CREDS
#########################################################################################
variable "aws_region" {
    description = "aws region to create s3 bucket"
    default = ""
}
variable "aws_access_key"{
    description = "aws_access_key associated with your cli-user"
    default = ""
}
variable "aws_secret_key"{
    description = "aws_secrect_key associated with your cli-user"
    default = ""
    }


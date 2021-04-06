########################################################################################
#KMS KEYS
#########################################################################################
variable "kms_key_alias" {
    description = "short alias for kms key"
}

variable "kms_key_description" {
    description = "same as kms_key_alias in our example"
}

variable "kms_deletion_window_in_days" {
    description = "days to keep kms keys ( 7-30 )"
}

########################################################################################
#S3 BUCKET
#########################################################################################
variable "s3_bucket" {
    description = "s3 bucket name"
}
variable "tags" {
    type = map(string)  
}
########################################################################################
#AWS CREDS
#########################################################################################
variable "aws_region" {
    description = "aws region to create s3 bucket"
}

variable "aws_access_key"{
    description = "aws_access_key associated with your cli-user" 
}
variable "aws_secret_key"{
    description = "aws_secrect_key associated with your cli-user"
}

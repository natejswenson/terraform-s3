########################################################################################
# in general i frown upon defaults in most cased but for ease setup and to ensure
# we are all working with the same env  i have set a few things for you
#########################################################################################
variable "kms_key_alias" {
    description = "REQUIRED, name given to kms key"
    default = "wellnatekms"
}

variable "kms_key_description" {
    description = "OPTIONAL, self explanitory"
    default = "wellnatekms"
}

variable "kms_deletion_window_in_days" {
    description = "REQUIRED,days until kms key goes bye-bye"
    default = "7"
}

variable "s3_bucket" {
    description = "REQUIRED, name used for both app bucket and log bucket"
    default = "natejswenson-well-interview"
}

# set in tfvars 
variable "tags" {
    type = map(string)  
}
########################################################################################
# for security i would use vault or some other secret manager to store this 
# for demo purposed  region, key and secret must be entered at execution via cli
# for test purposed you can use values found locally at ~/.aws/credentials
#########################################################################################
variable "aws_region" {
    description = "REQURIED, aws region you want your bucket created in"
    default = "us-east-1"
}

variable "aws_access_key"{
    description = "REQUIRED, aws_access_key associated with your cli-user" 
    default = "AKIATE6YQ3LAAQZF66FC"
}
variable "aws_secret_key"{
    description = "REQUIRED, aws_secrect_key associated with your cli-user"
    default = "HHDmhX2GjN2pwfkPDUY0B/hPy4atC5ye3Ca3IRYt"
}

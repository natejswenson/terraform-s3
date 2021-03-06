########################################################################################
#KMS KEYS
#########################################################################################
kms_key_alias = "kms"
kms_key_description = "kms"
kms_deletion_window_in_days = "7"

########################################################################################
#S3 BUCKET
########################################################################################
s3_bucket = ["dev-well-interview", "stage-log-well-interview", "prod-log-well-interview"]

tags = {
    "purpose" = "interview-assignment",
    "app_name" = "test_app"
}
s3_logbucket = "well-interview-log"
folder = ["dev/", "stage/","prod/"]


########################################################################################
#AWS
########################################################################################
#aws_region = ""
#aws_access_key = ""
#aws_secret_key = ""

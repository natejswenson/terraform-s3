## s3-terraform
This terraform module will create an s3 bucket with kms encryption with an attached policy and also create a log-{{ bucket_name }} bucket for logging.

### Assumptions:
1. we are created a empty bucket 
3. the bucket does not need access to other aws services
4. the bucket will be versioned
5. logging to /log in the log bucket
6. this is a prototype - this should be launched via a pipeline or some other automated means where credentials can be pulled from vault
7. policy should be attached via a var for simplicity sake it was included in main.

### Usage
#### Clone this repo locally to yoru machine
 ```sh
git clone git@github.com:natejswenson/terraform-s3.git
cd terraform-s3
```
#### Input Variables (main.auto.tfvars):
```yml
kms_key_alias: "short alias for kms key"
kms_key_description: "same as kms_key_alias in our example"
kms_deletion_window_in_days:"days to keep kms keys ( 7-30 )"
s3_bucket: "s3 bucket name"
aws_region: "aws region to create s3 bucket"
aws_access_key: "aws_access_key associated with your cli-user" 
aws_secret_key: "aws_secrect_key associated with your cli-user"
```
#### Output Variables (output.tf
```yml
kms_key_arn: "arn for kms key"
name: "s3 bucket name"
region: "aws region where named bucket was created"
```
#### Bucket Policy (main.tf)
```yml
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
```
5. From terminal:
```sh
terraform init
terraform plan
```
before continuing verify that your plan includes the creation of 2 buckets with attached policy, and kms keys in the correct region Output should look similar to this:
```yml
Changes to Outputs:
  + kms_key_alais_arn  = (known after apply)
  + kms_key_alias_name = "alias/wellkms"
  + kms_key_arn        = (known after apply)
  + kms_key_id         = (known after apply)
  + name               = "natejswenson-well-interview"
  + region             = "us-east-1"
```
```sh
terraform apply
```



## s3-terraform
This module will create s3 bucket(s) with kms encryption as well as a bucket with seprate prefixes for storing logs.
### Expected Inputs 
| var                           | default           | description                               |
|-------------------------------|-------------------|-------------------------------------------|
| **kms_key_alias**             | kms               | short alias for kms key                   |
| **kms_key_description**       | kms               | same as kms_key_alias in our example      |
|**kms_deletion_window_in_days**|7                  | days to keep kms keys ( 7-30 )            |
|**s3_logbucke**                |well-interview-log | name for the log bucket 
|**folder**                     |dev/,stage/,prod/  | name used as prefix for buckets {dev-well-interview} as well as folder structure within the log bucket |
|**aws_region**                 | *user defined*    |aws region where buckets will be created |
|**aws_access_key**             | *user defined*    |aws access key for which the buckets will be created |
|**aws_secret_key**             | *user defined*    |aws secret key for which the buckets will be created |

### Expected Outputs 
 var                            | description     |
|-------------------------------|-----------------|
|**kms_key_arn**                |arn for kms key  |
|**name**                       |s3 bucket names  |
|**log_name**                   |s3 log bucket name|
|**region**                     |aws region|

### Assumptions:
1. create buckets which are created at will share common kms key and security
2. logging will be done in a single bucket regardless of number of buckets being created.
3. buckets *will not* have access to other aws resources however could be configured
4. buckets will be versioned
6. **prototype only** credentials should eventually be pulled from vault

### Usage
 ```sh
git clone git@github.com:natejswenson/terraform-s3.git
cd terraform-s3
terraform init
terraform plan
```
#### Example .tvars inputs:
```js
kms_key_alias = "kms"
kms_key_description = "kms"
kms_deletion_window_in_days = "7"
s3_bucket = ["dev-well-interview", "stage-log-well-interview", "prod-log-well-interview"]
tags = {"purpose" = "interview-assignment","app_name" = "test_app"}
s3_logbucket = "well-interview-log"
folder = ["dev/", "stage/","prod/"]
aws_region = "us-east-1"
aws_access_key = "xxx-xxxx-xxx-xxx"
aws_secret_key = "xxx-xxx-xxx-xxx-xxx-xxx"
```
### Example CLI Outputs:
```sh
Apply complete! Resources: 12 added, 0 changed, 0 destroyed.

kms_key_alais_arn = "arn:aws:kms:us-east-1:**************:alias/kms"
kms_key_alias_name = "alias/kms"
kms_key_arn = "arn:aws:kms:us-east-1:**************:key/86bf585b-1bd2-45fb-91d4-89d3003495c7"
kms_key_id = "86bf585b-****-****-****-89d3003495c7"
name = tolist([
  "dev-well-interview",
  "stage-log-well-interview",
  "prod-log-well-interview",
])
region = "us-east-1"
```
### Example Console Views
If you log into the aws console and go to the s3 bucket section you should see somethign like this:
![GitHub Logo](/images/s3.png)

When you click on the log bucket you should see a structure that looks something like this:
![test](/images/s3-log.png)



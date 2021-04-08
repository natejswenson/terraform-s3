package test
import (
	"fmt"
	"strings"
	"testing"
	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)
func TestTerraformAwsS3Example(t *testing.T) {
	t.Parallel()
	expectedS3Name := fmt.Sprintf("natetest-%s", strings.ToLower(random.UniqueId()))
	expectedPrefix := fmt.Sprintf("%s/", strings.ToLower(random.UniqueId()))
	expectedS3LogName := fmt.Sprintf("natetest-%s-log", strings.ToLower(random.UniqueId()))
	awsRegion := "us-east-1"
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../examples/",
		Vars: map[string]interface{}{
			"s3_bucket": expectedS3Name, 
			"s3_prefix": expectedPrefix,
			"s3_logbucket": expectedS3LogName,
			"aws_region": awsRegion,
		},
	})

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	s3bucket := terraform.Output(t, terraformOptions, "s3_bucket")
	s3prefix := terraform.Output(t, terraformOptions, "s3_prefix")
	s3logbucket:= terraform.Output(t, terraformOptions, "s3_logbucket")
	
	// Verify that our Bucket has versioning enabled
	expectedStatus := "Enabled"
	actualStatus := aws.GetS3BucketVersioning(t, awsRegion, s3bucket)
	assert.Equal(t, expectedStatus, actualStatus)

	//very correct log bucket
	expectedLogsTargetBucket := s3logbucket
	loggingTargetBucket := aws.GetS3BucketLoggingTarget(t, awsRegion, s3bucket)
	assert.Equal(t, expectedLogsTargetBucket, loggingTargetBucket)
	
	//verify correct log prefix
	expectedLogsTargetPrefix := s3prefix
	loggingObjectTargetPrefix := aws.GetS3BucketLoggingTargetPrefix(t, awsRegion, s3bucket)
	assert.Equal(t, expectedLogsTargetPrefix, loggingObjectTargetPrefix)




}
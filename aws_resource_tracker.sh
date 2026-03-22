#!/bin/bash

###########################
# Author : Snehendu
# Date : 22/03/26
# Version : v1
# This script reports AWS resource usage
###########################

set -x

OUTPUT_FILE="resourceTracker.txt"

# Clear file first
> $OUTPUT_FILE

# List S3 Buckets
echo "===== S3 Buckets =====" >> $OUTPUT_FILE
aws s3 ls >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

# List EC2 Instances
echo "===== EC2 Instances =====" >> $OUTPUT_FILE
aws ec2 describe-instances --query "Reservations[].Instances[].InstanceId" --output text >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

# List Lambda Functions
echo "===== Lambda Functions =====" >> $OUTPUT_FILE
aws lambda list-functions --query "Functions[].FunctionName" --output text >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

# List IAM Users
echo "===== IAM Users =====" >> $OUTPUT_FILE
aws iam list-users --query "Users[].UserName" --output text >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

echo "Report generated in $OUTPUT_FILE"

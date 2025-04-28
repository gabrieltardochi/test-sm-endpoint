#!/bin/bash
set -e

push_tags_csv=latest
account=247599465422
region=us-east-1
image=test-sm-endpoint
base_tag=build

# Get the login command from ECR in order to pull down the SageMaker PyTorch image
# aws ecr get-login-password --region ${region} | docker login -u AWS --password-stdin 763104351884.dkr.ecr.${region}.amazonaws.com

# Get the login command from ECR in order to push the new built image
aws ecr get-login-password --region ${region} | docker login -u AWS --password-stdin https://${account}.dkr.ecr.${region}.amazonaws.com

# Build the docker image locally and then push it to ECR
docker build -t ${image}:${base_tag} .

# Use IFS (Internal Field Separator) to set the delimiter
IFS=',' read -ra target_tags <<< "$push_tags_csv"

# Iterate over target tags
for target_tag in "${target_tags[@]}"; do
    fullname=${account}.dkr.ecr.${region}.amazonaws.com/${image}:${target_tag}
    docker tag ${image}:${base_tag} ${fullname}
    docker push ${fullname}
done
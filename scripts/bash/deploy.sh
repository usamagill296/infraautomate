#!/bin/bash
set -e
set -o pipefail
# Configuration
AWS_REGION="eu-central-1"
AWS_ACCOUNT_ID="501410019406"
ECR_REPOSITORY="infraautomate-dev"
ECS_CLUSTER="infraautomate-cluster-dev"
ECS_SERVICE="infraautomate-dev"
IMAGE_TAG=$(git rev-parse --short HEAD)
ECR_URL="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"

echo "🚀 Starting deployment..."
echo "Image tag: ${IMAGE_TAG}"
echo "📦 Step 1: Authenticating to ECR..."
aws ecr get-login-password --region ${AWS_REGION} | \
    docker login --username AWS --password-stdin ${ECR_URL}

echo "🔨 Step 2: Building Docker image..."
docker build -t ${ECR_REPOSITORY}:${IMAGE_TAG} .
docker tag ${ECR_REPOSITORY}:${IMAGE_TAG} \
    ${ECR_URL}/${ECR_REPOSITORY}:${IMAGE_TAG}

echo "⬆️ Step 3: Pushing image to ECR..."
docker push ${ECR_URL}/${ECR_REPOSITORY}:${IMAGE_TAG}
echo "🚀 Step 4: Updating ECS service..."
aws ecs update-service \
    --cluster ${ECS_CLUSTER} \
    --service ${ECS_SERVICE} \
    --force-new-deployment \
    --region ${AWS_REGION}

echo "⏳ Step 5: Waiting for deployment..."
aws ecs wait services-stable \
    --cluster ${ECS_CLUSTER} \
    --services ${ECS_SERVICE} \
    --region ${AWS_REGION}

echo "✅ Deployment successful!"
echo "Image deployed: ${ECR_URL}/${ECR_REPOSITORY}:${IMAGE_TAG}"

echo "📊 Deployment Summary:"
echo "  Cluster:    ${ECS_CLUSTER}"
echo "  Service:    ${ECS_SERVICE}"
echo "  Image tag:  ${IMAGE_TAG}"
echo "  Region:     ${AWS_REGION}"
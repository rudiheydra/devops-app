PROJECT_ID=devops-app-384609
ENV=staging
ZONE=us-central1-c


GITHUB_SHA?=latest
LOCAL_TAG=devops-app:$(GITHUB_SHA)


run-local:
	docker run -p 3000:3000 devops-app

build: 
	docker build -t $(LOCAL_TAG) .

create-tf-backend-bucket:
	gsutil mb -p $(PROJECT_ID) gs://$(PROJECT_ID)-terraform-state

terraform-create-workspace:
	cd terraform && \
		terraform workspace new $(ENV)

terraform-init:
	cd terraform && \
		terraform workspace select $(ENV) && \
		terraform init

TF_ACTION?=plan
terraform-action:
	cd terraform && \
	  terraform workspace select $(ENV) && \
	  terraform $(TF_ACTION) \
	  -var-file="./environments/common.tfvars" \
	  -var-file="./environments/$(ENV)/config.tfvars" \
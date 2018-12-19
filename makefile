APP_NAME = test-hello-world
AWS_ACCOUNT = $(shell aws sts get-caller-identity | jq '.Account')
REPO_NAME = repo-name

create-stack:
	aws cloudformation create-stack --stack-name $(APP_NAME) \
		--template-body file://./aws/cloudformation.yml \
		--parameters ParameterKey=RepoName,ParameterValue=$(APP_NAME) \
			ParameterKey=AccountId,ParameterValue=$(AWS_ACCOUNT) \
			ParameterKey=RoleName,ParameterValue=test-lambda-execution-role \
			ParameterKey=LambdaName,ParameterValue=test-hello-world-lambda \
		--capabilities CAPABILITY_NAMED_IAM

delete-stack:
	aws cloudformation delete-stack --stack-name $(APP_NAME)

update-stack:
	aws cloudformation update-stack --stack-name $(APP_NAME) \
		--template-body file://./aws/cloudformation.yml \
		--parameters ParameterKey=RepoName,ParameterValue=$(APP_NAME) \
			ParameterKey=AccountId,ParameterValue=$(AWS_ACCOUNT) \
			ParameterKey=RoleName,ParameterValue=test-lambda-execution-role \
			ParameterKey=LambdaName,ParameterValue=test-hello-world-lambda \
		--capabilities CAPABILITY_NAMED_IAM

validate-template:
	aws cloudformation validate-template \
		--template-body file://./aws/cloudformation.yml

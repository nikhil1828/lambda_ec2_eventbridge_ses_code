PRE-REQUISITE:

1. An AWS account with required permissions to create the required resource which we are creating through this terraform code.

2. An AWS AMI with pre-configured Monogo DB and Postfix installed, you can use [this](https://github.com/nikhil1828/ansible-playbook-for-mongodb-and-postfix.git) Ansible Playbook to install mongo DB and postfix server in your ec2 and create an AMI of that EC2 instance.


STEPS TO RUN THIS CODE:

1. Export your AWS account credentials in your terminal like this :
```
    export AWS_ACCESS_KEY_ID=XXXXXXXXXXXXXXXXXXXX
    export AWS_SECRET_ACCESS_KEY=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    export AWS_DEFAULT_REGION=us-west-2
```

2. Switch to the home directory of this repository and modify "terraform.tfvars" file as per your AWS environment.

    Modify variable "ami_id" with your configured AMI-id at line no. 1.
    Modify variable "key_name" with your AWS Key pair name at line no. 3.
    Modify variable "ses_email" with your email id at line no. 44.

3. Run "terraform init", "terraform plan" and "terraform apply -auto-approve" command to create all resources.

4. After all the resources are created, open your mails which you have provided in step 2, there will be a email from AWS SES service regarding your confirmation to use this email id for sending mails through SES, confirm that mail to use SES service.
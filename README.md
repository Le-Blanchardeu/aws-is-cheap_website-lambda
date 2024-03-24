# MAKE YOUR STATIC WEBSITE DYNAMIC WITH AWS LAMBDAS

This mini-project aims to show that you can easily implement some backend functionalities to your static website with AWS Lambdas.  

IMPORTANT NOTE: Do not use this technique in a production environment. If you do so, implement proper authentication and it would be preferable to call AWS API Gateway (which will then trigger the Lambda) instead of the Lambdas directly.

## Pre-requisites

- An AWS Account
- Terraform installed and AWS credentials set up (API keys in Environment variables or any other technique)
- A custom domain name on AWS Route53

## Automatic Deployment

```sh
terraform init
terraform apply
```

The `terraform apply` command will automatically generate a `contactform_example.html` file with your Lambda endpoint integrated into it. Just open it in a browser, send a message, and your Lambda function will process it by returning what it received.

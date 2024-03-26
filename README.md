# IaC

This guide explains how to use the IaC pipeline set up in GitHub include the process of initializing, validating, planning, and applying Terraform configurations.

## Prerequisites

- AWS and credential
- Configure secrets as below (I removed secrets but you can verify in GitHub action history)

## Setup GitHub Secrets

1. Add 2 secrets
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`

## Understanding the Workflow

The `.github/workflows/terraform.yml` file defines following key steps:

- **Terraform Init:** Prepares the Terraform working directory.
- **Terraform Validate:**  Verify Terraform scripts.
- **Terraform Plan:** Shows the changes that will be applied.
- **Terraform Apply:** Applies the changes.

## Items can be improve

- Terraform code shall include ECR for continues deployment.
- Terraform apply can be manual action.
- Terraform code can be categorize as modules for big project.
- Pipeline shall conduct scanning stage for Terraform source code.
- etc...

===================================
CICERAI img2table Deployment Guide
===================================

After making changes to the repository, you can deploy img2table to Artifact Registry using the provided Makefile. The Makefile is configured with three environment-specific files (.env) that contain the necessary variables for deploying to different GCP projects.

## Prerequisites

1. Ensure you have the necessary json for each GCP project in a folder named `keys`.

2. Make sure you have the required dependencies installed.

bash
pip install -r requirements-dev.txt

## Environment-specific Configuration y deploy folder
- For dev, use dev.env.
- For pomares, use pomares.env.
- For demo-usa, use demo-usa.env.

In this files must contain the following variables for each project:

PROJECT_ID=<projec_id>
SERVICE_ACCOUNT=<project_service_account>
SA_KEY_FILE=<path to json key> 

## Deployment Steps

Choose the appropriate environment by specifying ENV when calling make release. 
Choose from dev, pomares, or demo-usa.

make release ENV=dev







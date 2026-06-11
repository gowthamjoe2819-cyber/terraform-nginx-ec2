terraform {
  required_version = ">= 1.0"

  # Runs on HCP Terraform (Terraform Cloud) — not on your laptop.
  # Replace organization and workspace name after creating them at https://app.terraform.io
  cloud {
    organization = "gojo_2819"

    workspaces {
      name = "terraform-ai"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  # AWS keys are set in the Terraform Cloud workspace (not in this code).
}

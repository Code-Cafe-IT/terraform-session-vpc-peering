provider "aws" {
  region = var.regions
  access_key = ""
  secret_key = ""
}

module "vpc" {
  source = "../module/vpc"
  cidr-my-vpc = var.cidr-my-vpc
  cidr-hg-vpc = var.cidr-hg-vpc
  project-name = var.project-name
  public-subnet-myvpc-1 = var.public-subnet-myvpc-1
  public-subnet-myvpc-2 = var.public-subnet-myvpc-2
  public-subnet-hgvpc-1 = var.public-subnet-hgvpc-1
  public-subnet-hgvpc-2 = var.public-subnet-hgvpc-2
}
module "ec2" {
  source = "../module/ec2"
  ami                   = var.ami
  cidr-my-vpc           = module.vpc.cidr-my-vpc
  cidr-hg-vpc           = module.vpc.cidr-hg-vpc
  project-name          = var.project-name
  public-subnet-myvpc-1 = module.vpc.public-subnet-myvpc-1
  public-subnet-myvpc-2 = module.vpc.public-subnet-myvpc-2
  public-subnet-hgvpc-1 = module.vpc.public-subnet-hgvpc-1
  public-subnet-hgvpc-2 = module.vpc.public-subnet-hgvpc-2
}
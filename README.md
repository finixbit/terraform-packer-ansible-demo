# terraform-packer-ansible-demo
Deploying a simple flask application using Terraform, Packer and Ansible.

## Design goal 
1. To have an immutable infrastructure
2. To create/modify the infrastructure through an automated repeatable process

## Tools
1. [Ansible](https://www.ansible.com/) - Automates server configuration
2. [Packer](https://www.packer.io/) - Builds images of a configured server, but doesn't actually deploy it
3. [Terraform](https://www.terraform.io/) - Handles deploying an actual server
4. [Docker](https://www.docker.com/) - Build, test, and deploy applications quickly. 

## Roadmap
1. Create Simple Python Flask Application 
2. Using ubuntu base image create aws ami image and configure ansible playbook with ansible using packer
3. Provision and deploy infrastructure with terraform

## Usage
Before running this setup, terraform and packer should be installed.

##### Clone source code
```bash
git clone https://github.com/finixbit/terraform-packer-ansible-demo.git
cd terraform-packer-ansible-demo
```

## Design / Project structure
#### Flask-App
Simple flask application which serves a "hello world" page built on top of `python:2.7-alpine3.8` official image.
see below for more details on how to setup and run application.

##### Setup Requirements
1. [Docker](https://www.docker.com/) - Build, test, and deploy applications quickly. 

##### Development Setup
1. Clone the repo and change directory to flask-app
2. Build container `make build`
3. Launch a dev server in debug mode `make dev`
4. Open application `http://127.0.0.1:8000`
5. Exit application `make stop`

##### Production Setup
1. Clone the repo and change directory to flask-app
2. Build container `make build`
3. Run Docker container `make run`
4. Open application `http://0.0.0.0:8000`

#### Ansible-Roles
Ansible roles to configure server. See below for more details on how to setup,run and test roles.

##### Setup Requirements
1. [Docker](https://www.docker.com/) - Build, test, and deploy applications quickly. 
2. [Vagrant](https://vagrantup.com) - Create and configure lightweight, reproducible, and portable development environments. 
3. [Molecule](https://molecule.readthedocs.io/en/) - Development and testing of Ansible roles

##### Testing Roles Prerequisites
1. `brew install ansible`
2. `brew cask install virtualbox`
3. `brew cask install vagrant`
4. `cd terraform-packer-ansible-demo/ansible && sudo pip install -r requirements.txt`

##### Unit Testing of Roles (using Docker)
Simple ansible roles `ansible/git`, `ansible/nginx` and `ansible/docker` are tested using molecule docker driver because it doesn't require docker in docker permission configuration and can be executed on different platform without changing molecule docker driver permissions.

###### Build and Run test
```bash
cd ansible/git
molecule test

cd ansible/nginx
molecule test

cd ansible/docker
molecule test
```

##### Integration Testing of Roles (Using Vagrant/Virtualbox) 
`ansible/flask-app` role make use of ansible roles `ansible/git`, `ansible/nginx` and `ansible/docker` and to prevent docker in docker problems, vagrant-virtualbox is suitable to fully test `ansible/flask-app` with all roles combined.

###### Build and initialize test   
```bash
cd ansible/flask-app
molecule test --destroy=never

curl http://localhost/
```
###### Cleanup and shutdown test
```bash
molecule destroy
```

#### Packer-Image
Build and configure aws ami image with packer and ansible and store the configured image. This allows consistency in the case of launching multiple instances of the application server. 
Note: copy ami created by packer to be used for terraform.

##### Setup Requirements
1. [Packer](https://www.packer.io/) - Builds images of a configured server, but doesn't actually deploy it

###### Build and configure ami image
```bash
cd terraform-packer-ansible-demo/packer

export AWS_ACCESS_KEY_ID="AWS ACCESS KEY ID HERE"
export AWS_SECRET_ACCESS_KEY="AWS SECRET ACCESS HERE"
export AWS_DEFAULT_REGION="AWS REGION HERE"

packer build template.json
```

#### Terraform
Deploy servers using ami image created from packer on aws infrastructure. 

##### Setup Requirements
1. [Terraform](https://www.terraform.io/) - Handles deploying an actual server

###### Build and deploy 
```bash
cd terraform-packer-ansible-demo/terraform

terraform init

export AWS_ACCESS_KEY_ID="AWS ACCESS KEY ID HERE"
export AWS_SECRET_ACCESS_KEY="AWS SECRET ACCESS KEY HERE"
export AWS_DEFAULT_REGION="AWS REGION HERE"

terraform plan -var 'ami=AMI_ID_FROM_PACKER_HERE'
terraform apply -var 'ami=AMI_ID_FROM_PACKER_HERE'

terraform output public_ip
curl http://<public_ip>
```

###### Cleanup and shutdown
```bash

terraform destroy
```

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
2. Create AMI Image from ubuntu base image configure with ansible using packer
3. Provision and deploy infrastructure with terraform

## Usage
Before running this setup, terraform and packer should be installed.

##### Clone source code
```bash
git clone https://github.com/finixbit/terraform-packer-ansible-demo.git
cd terraform-packer-ansible-demo
```

## Design
#### Flask-App
This is simple flask application which serves a "hello world" page built on top of `python:2.7-alpine3.8` official image.
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
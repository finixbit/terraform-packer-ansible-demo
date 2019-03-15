
variable "ami" { }

variable "server_port" {
  description = "The port the server will use for HTTP requests" 
  default = 80
}

variable "ssh_port" {
  description = "The port the server will use for SSH connection" 
  default = 22
}
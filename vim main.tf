provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "vm" {
  ami           = "ami-06eecef118bbf9259"
  subnet_id     = "subnet-00057dfebe5758943"
  instance_type = "t2.micro"
  tags = {
    Name = "my-first-tf-node"
  }
}

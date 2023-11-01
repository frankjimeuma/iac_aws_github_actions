provider "aws" {}

resource "aws_instance" "example" {
    ami           = "ami-0fc5d935ebf8bc3bc"
    instance_type = "t2.micro"

    tags = {
        Name = "linux_aws_github_actions"
    }
}
# Get latest AMI ID for Amazon Linux2 OS
data "aws_ami" "amzubuntu" {
  most_recent = true
  #owners = [ "424878232361" ]
  filter {
    name = "name"
    values = [ "Recruitment-ubuntu*" ]
  }
  filter {
    name = "root-device-type"
    values = [ "ebs" ]
  }
  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }
  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }
}
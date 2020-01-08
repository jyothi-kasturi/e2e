# Below resource will provision 
resource "aws_instance" "example" {
  count         = "${var.instance_count}"
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = "${aws_subnet.main-public-1.id}"

  # the security group
  vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}"]
  #userdata
  user_data= "../scripts/create_jenkins_usr.sh"

  # the public SSH key
  key_name = "${aws_key_pair.devopsmonks.key_name}"
  #tags
  tags = {
    Name  = "Pub-${count.index + 1}"
    Type = "e2e-hw"
  }
}

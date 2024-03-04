resource "aws_instance" "project-gtak" {
  ami = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"
  key_name = "project_gtak"
  vpc_security_group_ids = [aws_security_group.gtak-sg.id]
  subnet_id = aws_subnet.gtak-public-subnet-01.id

  for_each = toset(["jenkins-master", "jenikns-slave", "ansible"])
  tags = {
    Name = "${each.key}"
  }
}
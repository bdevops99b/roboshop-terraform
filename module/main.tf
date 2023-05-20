resource "aws_instance" "instance" {
  ami      = data.aws_ami.centos.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [ data.aws_security_group.allow-all.id ]
  iam_instance_profile = aws_iam_instance_profile.instance_profile.name
  tags = {
    Name = local.name
  }
}
resource "null_resource" "provisioner" {
  depends_on = [aws_instance.instance,aws_route53_record.records]
  provisioner "remote-exec" {

    connection {
      type     = "ssh"
      user     = "centos"
      password = "DevOps321"
      host     = aws_instance.instance.private_ip
    }
    inline = var.app_type == "db" ? local.db_commands : local.app_commands
  }
}
resource "aws_route53_record" "records" {

  zone_id = "Z09749362E9LBLZIEGY8G"
  #name    = "${each.value["name"]}-dev.pand4u.online"  #getting duplicate of pand4u.online
  #name     = "${var.component_name}-dev.swedev99.online"
  name    = "${var.component_name}-dev" # This is working fine
  type    = "A"
  ttl     = 30
  records = [aws_instance.instance.private_ip]
}

resource "aws_iam_role" "role" {
  name = "${var.component_name}-${var.env }-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "${var.component_name}-${var.env }-role"
  }
}
resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.component_name}-${var.env }-role"
  role = aws_iam_role.role.name
}

resource "aws_iam_role_policy" "ssm-ps-policy" {
  name = "${var.component_name}-${var.env }-ssm-ps-policy"
  role = aws_iam_role.role.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "VisualEditor0",
        "Effect": "Allow",
        "Action": [
          "kms:GetParametersForImport",
          "kms:Encrypt",
          "ssm:GetParameterHistory",
          "ssm:GetParametersByPath",
          "ssm:GetParameters",
          "ssm:GetParameter"
        ],
        "Resource": [
          "arn:aws:kms:us-east-1:278280077392:key/50f72021-fbd2-4087-bb3f-7782291eaff6",
          "arn:aws:ssm:us-east-1:278280077392:parameter/${var.env}.${var.component_name}.*"
        ]
      }
    ]
  })
}

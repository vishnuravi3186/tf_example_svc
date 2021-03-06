data "terraform_remote_state" "aws_vpc" {
  backend = "s3"
  config = {
    bucket  = "${var.aws_s3_prefix}-${var.aws_account}-terraform"
    key     = "aws_vpc.tfstate"
    region  = "${var.aws_region}"
  }
}

data "terraform_remote_state" "aws_iam" {
  backend = "s3"
  config = {
    bucket  = "${var.aws_s3_prefix}-${var.aws_account}-terraform"
    key     = "aws_iam.tfstate"
    region  = "${var.aws_region}"
  }
}

data "template_file" "cloud_init" {
  template = "${file("${path.module}/cloud-init.tpl")}"

  vars {
    domain_net = "${var.domain_net}"
  }
}


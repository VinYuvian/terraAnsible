provider "aws"{
	version = "~> 2.39"
	access_key="${var.AWS_ACCESS_KEY}"
	secret_key="${var.AWS_SECRET_KEY}"
	region="${var.region}"
}

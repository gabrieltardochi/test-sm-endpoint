resource "aws_s3_bucket" "sg_bucket" {
  bucket = "${var.bucket}-${var.region}-${var.account}"
}
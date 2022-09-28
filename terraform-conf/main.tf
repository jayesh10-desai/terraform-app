module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = var.STATIC_BUCKET_NAME

  block_public_acls = true

  force_destroy = true

  attach_policy = true

  policy = data.aws_iam_policy_document.bucket_policy.json

  acl = "private"

  versioning = {
    enabled = true
  }

}

module "cdn" {
  source = "terraform-aws-modules/cloudfront/aws"

  default_root_object = "index.html"

  aliases = var.CLOUDFRONT_ALIASES

  comment = "static cloudfront distribution"

  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "PriceClass_All"
  retain_on_delete    = false
  wait_for_deployment = false

  create_origin_access_identity = true
  origin_access_identities = {
    s3_bucket_one = "assessmentbucketOAI"
  }
/* 
  logging_config = {
    bucket = "logs-my-cdn.s3.amazonaws.com"
  } */
  origin = {
    s3_one = {
      domain_name = module.s3_bucket.s3_bucket_bucket_domain_name
      s3_origin_config = {
        origin_access_identity = "s3_bucket_one"
      }
    }
  }

  default_cache_behavior = {
    target_origin_id           = "s3_one"
    viewer_protocol_policy     = "allow-all"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
    query_string    = true
  }

  custom_error_response = [
    {
    error_code = 404
    response_code         = 200
    response_page_path    = "/404.html"
    }
  ]

}
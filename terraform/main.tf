# Bucket S3 intencionalmente mal configurado para testar o Trivy
resource "aws_s3_bucket" "vulnerable_bucket" {
  bucket = "meu-bucket-com-falhas-de-seguranca-2027"
}

# Falha 1: Tornando o bucket público explicitamente
resource "aws_s3_bucket_public_access_block" "bad_practice" {
  bucket = aws_s3_bucket.vulnerable_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Falha 2: ACL pública (Antiga, mas o Trivy ainda pega)
resource "aws_s3_bucket_acl" "bad_acl" {
  bucket = aws_s3_bucket.vulnerable_bucket.id
  acl    = "public-read"
}
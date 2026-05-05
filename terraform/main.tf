resource "aws_s3_bucket" "example" {
  bucket = "meu-bucket-exemplo-123456"

  tags = {
    Name = "Test_bucket_monti"
  }
}

# CONFIGURAÇÃO INSEGURA PROPOSITAL
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_acls   = false
  block_public_policy = false
}
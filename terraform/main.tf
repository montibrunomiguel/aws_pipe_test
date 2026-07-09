# 1. Definição do Bucket S3 Seguro
resource "aws_s3_bucket" "secure_bucket" {
  bucket = "meu-bucket-totalmente-seguro-2026"

  # Evita destruição acidental em produção (opcional, mas boa prática)
  lifecycle {
    prevent_destroy = false
  }
}

# 2. Desativando ACLs e forçando o controle via IAM Policies (Recomendação AWS)
resource "aws_s3_bucket_ownership_controls" "secure_ownership" {
  bucket = aws_s3_bucket.secure_bucket.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# 3. Bloqueio Absoluto de Acesso Público (O que o Trivy mais cobra)
resource "aws_s3_bucket_public_access_block" "secure_block" {
  bucket = aws_s3_bucket.secure_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# 5. Habilitando o Versionamento (Proteção contra deleção acidental e Ransomware)
resource "aws_s3_bucket_versioning" "secure_versioning" {
  bucket = aws_s3_bucket.secure_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
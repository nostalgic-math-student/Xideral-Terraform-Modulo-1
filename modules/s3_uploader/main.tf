provider "aws" {
  region = "us-east-1"
}

# Creamos recurso de AWS_S3 mediante variables mencionadas en mainfile

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  tags = {
    Name        = var.bucket_name
  }
}

# Extrapolamos los settings para permitir el flujo publico al environment

resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id
  policy = var.bucket_policy
}

# Para cargar archivos creamos un loop con fileset para cargar todos los archivos de la carpeta mencionada en la ruta de variable
# Utilizamos una colección de tipos para cargar archivos dependiendo de la extensión

resource "aws_s3_object" "files" {
  for_each = fileset(var.local_folder, "**")

  bucket       = aws_s3_bucket.bucket.id
  key          = each.value
  source       = "${var.local_folder}/${each.value}"
  content_type = lookup(local.mime_types, split(".", each.value)[length(split(".", each.value)) - 1], "application/octet-stream")
}


locals {
  mime_types = {
    "txt"  = "text/plain"
    "html" = "text/html"
    "json" = "application/json"
    "png"  = "image/png"
    "jpg"  = "image/jpeg"
    "jpeg" = "image/jpeg"
  }
}

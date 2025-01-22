variable "bucket_name" {
  description = "Nombre del bucket"
  type        = string
}

variable "local_folder" {
  description = "Direccion de carpeta de datos a subir"
  type        = string
}
variable "bucket_policy" {
  description = "politica en JSON"
  type        = string
}

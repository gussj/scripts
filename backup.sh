#!/bin/bash

# Ubicación del script y logs
script_dir="/home/caadmin"
log_dir="$script_dir/logs"
log_file="$(basename "$0")_$(date +'%Y-%m-%d_%H-%M-%SZ').log"
log_path="$log_dir/$log_file"

# Validar y crear directorio de logs si no existe
if [ ! -d "$log_dir" ]; then
  mkdir -p "$log_dir"
fi

# Función para registrar logs
function log() {
  echo "$(date +'%Y-%m-%d %H:%M:%S') $1" >> "$log_path"
}

# Registrar inicio de ejecución
log "Inicio del script"

# Ruta de origen y destino
source_dir="/media/data1"
destination_dir="/media/backups"

# Opcional: Archivo con lista de archivos a excluir
exclude_file="$1"
exclude_option=""

# Comprobar si se proporcionó un archivo de exclusión
if [ -n "$exclude_file" ]; then
  exclude_option="--exclude-from=$exclude_file"
fi

# Sincronizar directorios
rsync -avzh --delete $exclude_option "$source_dir/" "$destination_dir/" >> "$log_path" 2>&1

# Registrar fin de ejecución
log "Fin del script"

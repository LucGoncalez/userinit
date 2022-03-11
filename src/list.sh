#!/bin/bash

################################################################################
#
# Script de listagem de arquivo de configuração
#
################################################################################

for file in "$LKS_BASE_DIR/init.d/"*; do
  name="${file##*/}"

  if [ -L "$file" ]; then
    status="Não habilitável (link)"
  elif [ -x "$file" ]; then
    status="Habilitado"
  else
    status="Desabilitado"
  fi

  printf "%s\t%s\n" "$name" "$status"
done | expand -t 50

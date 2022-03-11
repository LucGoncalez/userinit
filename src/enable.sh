#!/bin/bash

################################################################################
#
# Script de habilitação de arquivo de configuração
#
################################################################################

# Verifica se informado o parâmetro
if [ -z "$1" ]; then
  printf "**ERROR** [userinit]: Não foi informado o nome do arquivo de configuração.\n" >&2
  exit 1
fi

# Verifica se o parâmetro está correto
config_file="$LKS_BASE_DIR/init.d/$1"

if [ ! -e "$config_file" ]; then
  printf "**ERROR** [userinit]: O arquivo de configuração informado não existe.\n" >&2
  exit 1
fi

# Verifica se arquivo já está habilitado
if [ -x "$config_file" ]; then
  printf "O arquivo <$1> já está habilitado.\n"
else
  if chmod +x "$config_file" 2> /dev/null; then
    printf "O arquivo <$1> foi habilitado com sucesso.\n"
  else
    printf "Não foi possível habilitar o arquivo <$1>.\n"
  fi
fi

#!/bin/bash

################################################################################
#
# Script de inicialização de configurações do usuário
#
################################################################################

#
# Obs. o diretório <init.d> não deve conter scripts para serem executados
#

# Testando se o script está sendo executado como source do bash
if [ "$0" != 'bash' ]; then
  printf "**ERROR** [userinit]: Este script não está rodando como source do bash.\n" >&2
  exit 1
fi

# Configurando diretório base do LKScript
export LKS_BASE_DIR="${HOME}/.lks"

if [ ! -d "$LKS_BASE_DIR" ]; then
  printf "**ERROR** [userinit]: O diretório base <%s> não existe.\n" "$LKS_BASE_DIR" >&2
else
  # Definindo variáveis
  LKS_BIN_DIR="${LKS_BASE_DIR}/bin"
  LKS_USERINIT_INITDIR="${LKS_BASE_DIR}/init.d"
  LKS_USERINIT_INITFILE="${LKS_BASE_DIR}/init.tmp"

  if [ ! -d "$LKS_USERINIT_INITDIR" ] || ( [ -e "$LKS_USERINIT_INITFILE" ] && [ ! -f "$LKS_USERINIT_INITFILE" ] ); then
    printf "**ERROR** [userinit]: O script não está configurado corretamente.\n"
  else
    # Configura PATH
    PATH="${PATH}:${LKS_BIN_DIR}"

    # Carrega configurações para o arquivo de inicialização temporário
    for file in $ "$LKS_USERINIT_INITDIR"/*; do
      if [ ! -L "$file" ] && [ -x "$file" ]; then
        printf ". %q\n" "$file"
      fi
    done > "$LKS_USERINIT_INITFILE"

    # Carrega arquivo temporário e remove o mesmo
    . "$LKS_USERINIT_INITFILE"
    rm "$LKS_USERINIT_INITFILE"
  fi

  unset LKS_USERINIT_INITDIR LKS_USERINIT_INITFILE LKS_BIN_DIR
fi

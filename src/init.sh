#!/bin/bash

################################################################################
#
# Script de inicialização de configurações do usuário
#
################################################################################

#
# Obs. o diretório <init.d> não deve conter scripts para serem executados
#

# Configurando diretório base do LKScript
LKS_BASE_DIR="${HOME}/.lks"

if [ ! -d "$LKS_BASE_DIR" ]; then
  printf "**ERROR** [userinit]: O diretório base <%s> não existe.\n" "$LKS_BASE_DIR" >&2
else
  # Definindo variáveis
  LKS_USERINIT_INITDIR="${LKS_BASE_DIR}/init.d"
  LKS_USERINIT_INITFILE="${LKS_BASE_DIR}/init.tmp"

  if [ ! -d "$LKS_USERINIT_INITDIR" ] || ( [ -e "$LKS_USERINIT_INITFILE" ] && [ ! -f "$LKS_USERINIT_INITFILE" ] ); then
    printf "**ERROR** [userinit]: O script não está configurado corretamente.\n"
  else
    # Carrega configurações para o arquivo de inicialização temporário
    for file in $ "$LKS_USERINIT_INITDIR"/*; do
      if [ -x "$file" ]; then
        printf ". %q\n" "$file"
      fi
    done > "$LKS_USERINIT_INITFILE"

    # Carrega arquivo temporário e remove o mesmo
    . "$LKS_USERINIT_INITFILE"
    rm "$LKS_USERINIT_INITFILE"
  fi

  unset LKS_USERINIT_INITDIR LKS_USERINIT_INITFILE
fi

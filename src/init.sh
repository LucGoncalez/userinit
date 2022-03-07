#!/bin/bash

################################################################################
#
# Script de inicialização de configurações do usuário
#
################################################################################

# Verificando se parametro é adequado

if [ -z "$1" ]; then
  echo "**ERROR** [userinit]: Não informado o parametro de configuração" >&2
else
  USERINIT_MAINPATH="${1%/}"

  # Definir variáveis
  USERINIT_INITDIR="${USERINIT_MAINPATH}/init.d"
  USERINIT_INITFILE="${USERINIT_MAINPATH}/init.tmp"

  # Testa o diretório de inicialização
  if [ ! -d "$USERINIT_INITDIR" ]; then
    echo "**ERROR** [userinit]: O parametro informado não está correto" >&2
  else
    # Carrega configurações para arquivo temporário
    for file in ${USERINIT_INITDIR}/*; do
      if [ -x "$file" ]; then
        echo ". $file"
      fi
    done > "$USERINIT_INITFILE"

    . "$USERINIT_INITFILE"
    rm "$USERINIT_INITFILE"
  fi
fi

#!/usr/bin/env bash
set -eux
# Elimina el archivo de configuraciones globales del usuario
# (-f No muestra un mensaje de error ni devuelve un estado de error si un archivo especificado no existe.)
rm -f ~/.npmrc | true
# Realiza el inicio de sesión con base en las credenciales registradas en las variables de entorno del sistema
curl -u "${ARTIFACTORY_READER_USER}:${ARTIFACTORY_READER_API_KEY}" 'https://bbogdigital.jfrog.io/bbogdigital/api/npm/auth' >> ~/.npmrc
# or replace ARTIFACTORY_READER_API_KEY by ARTIFACTORY_READER_PASSWORD if not exist
sed -i".backup" 's#_auth#//bbogdigital.jfrog.io/bbogdigital/api/npm/npm-bbta/:_auth#g' ~/.npmrc
sed -i".backup" 's#always-auth#//bbogdigital.jfrog.io/bbogdigital/api/npm/npm-bbta/:always-auth#g' ~/.npmrc
sed -i".backup" 's#email#//bbogdigital.jfrog.io/bbogdigital/api/npm/npm-bbta/:email#g' ~/.npmrc
# Instalación dependencias globales
npm ci || exit 1
# git reset --hard || exit 1

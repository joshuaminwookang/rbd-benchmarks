#!/bin/bash
set -e

git submodule update --init --recursive
mkdir -p ./csv/
mkdir -p ./csv/rbdl/

# https://drive.google.com/u/1/uc?id=1AgACbjUpoWWA47U_RFR-jwIdt4lLTtdW&export=download
fileId=1AgACbjUpoWWA47U_RFR-jwIdt4lLTtdW
fileName=csvs.zip
curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=${fileId}" > /dev/null
code="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${code}&id=${fileId}" -o ${fileName}

unzip "${fileName}" -d ./csv/rbdl/
rm "${fileName}"


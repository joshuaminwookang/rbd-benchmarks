#!/bin/bash
set -e

echo "Initializing submodules..."
git submodule update --init --recursive --remote
mkdir -p ./csv/
mkdir -p ./csv/rbdl/

# Method obtained from https://dev.to/kojikanao/download-files-from-google-drive-with-curl-wget-5e4o
# https://drive.google.com/u/1/uc?id=1AgACbjUpoWWA47U_RFR-jwIdt4lLTtdW&export=download
echo "Downloading CSVs..."
fileId=1AgACbjUpoWWA47U_RFR-jwIdt4lLTtdW
fileName=csvs.zip

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=${fileId}" > /dev/null
code="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${code}&id=${fileId}" -o ${fileName}

unzip -o "${fileName}" -d ./csv/rbdl/
rm "${fileName}"

echo "Building RBDL..."
cd ./libs/
make clean
make rbdl
cd ../

echo "Building Experiments..."
cd ./experiments/rbdl/
./compile_rbdl_time.sh
cd ../../



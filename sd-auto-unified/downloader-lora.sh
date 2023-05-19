#!/bin/bash
BASE_DIR=/workspace
MODEL_DIR=${BASE_DIR}/stable-diffusion-webui/models/Stable-diffusion
LORA_DIR=${BASE_DIR}/stable-diffusion-webui/models/Lora
TI_DIR=${BASE_DIR}/stable-diffusion-webui/embeddings

# Lora
# https://github.com/msarmadi/stable-diffusion-webui-docker/raw/main/lora.list
cd $LORA_DIR
inputList="${BASE_DIR}/lora.list"
while read inputItem inputUrl ; do
    aria2c --summary-interval=1 --console-log-level=error -c -x 16 -s 16 -k 1M $inputUrl -o $inputItem
done < <(cat $inputList)

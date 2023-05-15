#!/bin/bash
BASE_DIR=/workspace
MODEL_DIR=${BASE_DIR}/models/Stable-diffusion
LORA_DIR=${BASE_DIR}/Lora
TI_DIR=${BASE_DIR}/embeddings

# TI
# https://github.com/msarmadi/stable-diffusion-webui-docker/raw/main/textualinversion.list
cd $TI_DIR
inputList="${BASE_DIR}/textualinversion.list"
while read inputItem inputUrl ; do
    aria2c --summary-interval=1 --console-log-level=error -c -x 16 -s 16 -k 1M $inputUrl -o $inputItem
done < <(cat $inputList)

# Lora
# https://github.com/msarmadi/stable-diffusion-webui-docker/raw/main/lora.list
cd $LORA_DIR
inputList="${BASE_DIR}/lora.list"
while read inputItem inputUrl ; do
    aria2c --summary-interval=1 --console-log-level=error -c -x 16 -s 16 -k 1M $inputUrl -o $inputItem
done < <(cat $inputList)

# Model
# https://github.com/msarmadi/stable-diffusion-webui-docker/raw/main/model.list
cd $MODEL_DIR
inputList="${BASE_DIR}/model.list"
while read inputItem inputUrl ; do
    aria2c --summary-interval=1 --console-log-level=error -c -x 16 -s 16 -k 1M $inputUrl -o $inputItem
done < <(cat $inputList)

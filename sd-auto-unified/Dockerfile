#FROM runpod/stable-diffusion:models-1.0.0 AS sd-models
#FROM runpod/stable-diffusion-models:2.1 AS hf-cache

FROM runpod/stable-diffusion:web-automatic-base-6.0.1 AS runtime

RUN mkdir -p /root/.cache/huggingface && mkdir -p /sd-models

#COPY --from=hf-cache /root/.cache/huggingface /root/.cache/huggingface
#COPY --from=sd-models /SDv1-5.ckpt /sd-models/SDv1-5.ckpt
#COPY --from=sd-models /SDv2-768.ckpt /sd-models/SDv2-768.ckpt

RUN apt update && apt install -y --no-install-recommends aria2

WORKDIR /workspace/stable-diffusion-webui

ADD model.list /workspace/
ADD lora.list /workspace/
ADD textualinversion.list /workspace/
ADD downloader.sh /workspace/
#RUN chmod a+x downloader.sh
#RUN downloader.sh

# Extensions
RUN git clone https://github.com/deforum-art/sd-webui-deforum.git /workspace/stable-diffusion-webui/extensions/deforum-for-automatic1111-webui
RUN git clone https://github.com/AlUlkesh/stable-diffusion-webui-images-browser.git /workspace/stable-diffusion-webui/extensions/stable-diffusion-webui-images-browser
#RUN git clone https://github.com/camenduru/stable-diffusion-webui-huggingface /workspace/stable-diffusion-webui/extensions/stable-diffusion-webui-huggingface
RUN git clone -b v2.0 https://github.com/camenduru/sd-civitai-browser.git /workspace/stable-diffusion-webui/extensions/sd-civitai-browser
#RUN git clone https://github.com/Vetchems/sd-civitai-browser
RUN git clone https://github.com/kohya-ss/sd-webui-additional-networks.git /workspace/stable-diffusion-webui/extensions/sd-webui-additional-networks
RUN git clone https://github.com/Mikubill/sd-webui-controlnet.git /workspace/stable-diffusion-webui/extensions/sd-webui-controlnet
RUN git clone https://github.com/camenduru/openpose-editor.git /workspace/stable-diffusion-webui/extensions/openpose-editor
RUN git clone https://github.com/jexom/sd-webui-depth-lib.git /workspace/stable-diffusion-webui/extensions/sd-webui-depth-lib
RUN git clone https://github.com/hnmr293/posex.git /workspace/stable-diffusion-webui/extensions/posex
RUN git clone https://github.com/camenduru/sd-webui-tunnels.git /workspace/stable-diffusion-webui/extensions/sd-webui-tunnels
RUN git clone https://github.com/etherealxx/batchlinks-webui.git /workspace/stable-diffusion-webui/extensions/batchlinks-webui
RUN git clone https://github.com/canisminor1990/sd-web-ui-kitchen-theme.git /workspace/stable-diffusion-webui/extensions/sd-web-ui-kitchen-theme

RUN python -m venv /workspace/venv
ENV PATH="/workspace/venv/bin:$PATH"

RUN mv /workspace/stable-diffusion-webui /stable-diffusion-webui
RUN mv /workspace/venv /venv

RUN pip install -U jupyterlab ipywidgets jupyter-archive gdown
RUN jupyter nbextension enable --py widgetsnbextension

ADD relauncher.py /stable-diffusion-webui/
ADD webui-user.sh /stable-diffusion-webui/
ADD start.sh /start.sh
RUN chmod a+x /start.sh

SHELL ["/bin/bash", "--login", "-c"]
CMD [ "/start.sh" ]

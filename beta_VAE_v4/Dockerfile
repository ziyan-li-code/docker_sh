################################################################################
# 1. Start from a Python base that already has pip & python available
FROM nvcr.io/nvidia/jax:23.08-py3
WORKDIR /workspace

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

RUN pip install --no-cache-dir visdom
RUN mkdir -p /workspace/visdom_static

RUN python3 - << 'EOF'
from visdom.server.build import download_scripts
download_scripts(proxies=None, install_dir="/workspace/visdom_static")
EOF

RUN mkdir -p /usr/local/lib/python3.10/dist-packages/visdom/static \
    && cp -r /workspace/visdom_static/* /usr/local/lib/python3.10/dist-packages/visdom/static/


# ─────────── VENDOR VISDOM STATIC ASSETS HERE ───────────
COPY visdom_static /usr/local/lib/python3.10/dist-packages/visdom/static
ENV VISDOM_STATIC_PATH=/usr/local/lib/python3.10/dist-packages/visdom/static
# ──────────────────────────────────────────────────────────

RUN chmod -R a+rX /usr/local/lib/python3.10/dist-packages/visdom/static

# Bring in your run.sh and code
COPY run.sh /workspace/run.sh
RUN chmod +x /workspace/run.sh
COPY . /workspace

EXPOSE 8097
ENTRYPOINT ["bash","run.sh"]

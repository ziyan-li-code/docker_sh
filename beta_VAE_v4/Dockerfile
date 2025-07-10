################################################################################
# 1. Start from a Python base that already has pip & python available
FROM nvcr.io/nvidia/jax:23.08-py3
WORKDIR /workspace

################################################################################
# 2. Install your code’s dependencies, including visdom, via pip
#    (This runs as root inside the image build, so it's allowed.)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# requirements.txt should include:
# torch==0.3.1.post2
# torchvision
# tqdm
# visdom
# pillow
# numpy
# scipy
# tensorboard

################################################################################
# 2) Pre-download every script into /workspace/visdom_static
RUN mkdir -p /workspace/visdom_static && \
    python3 - << 'EOF'
import os
from visdom.server.build import download_scripts
download_scripts(install_dir="/workspace/visdom_static")
EOF

# 3) Copy the fully-populated static tree into Visdom’s site-packages
RUN mkdir -p /usr/local/lib/python3.10/dist-packages/visdom/static && \
    cp -r /workspace/visdom_static/* \
         /usr/local/lib/python3.10/dist-packages/visdom/static/

# 4) Make sure it’s world-readable (so your non-root entrypoint can serve it)
RUN chmod -R a+rX /usr/local/lib/python3.10/dist-packages/visdom/static


################################################################################
# 5). Copy your code & entrypoint script
COPY . /workspace
# ensure your run.sh is executable
RUN chmod +x /workspace/run.sh

# Expose Visdom’s port
EXPOSE 8097

################################################################################
# 6). Default command: launch your run script, which itself starts Visdom + main.py
ENTRYPOINT ["bash", "run.sh"]


################################################################################
# 1. Start from a Python base that already has pip & python available
FROM nvcr.io/nvidia/jax:23.08-py3

################################################################################
# 2. Install your code’s dependencies, including visdom, via pip
#    (This runs as root inside the image build, so it's allowed.)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt


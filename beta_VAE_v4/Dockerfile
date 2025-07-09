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

################################################################################
# 3. Pre-create Visdom’s “static/fonts” directory *and* make it world-writable
#    so that the non-root user inside the container can write there at runtime.
#    We first discover where pip put visdom, then patch its static folder.

# install visdom, then dynamically discover where it lives
RUN pip install --no-cache-dir visdom && \
    VIS_PATH="$(python3 -c "import visdom, os; print(os.path.join(os.path.dirname(visdom.__file__), 'static'))")" && \
    mkdir -p "$VIS_PATH/fonts" && \
    chmod -R a+rwX "$VIS_PATH"


################################################################################
# 4. Copy your code & entrypoint script
COPY . /workspace
# ensure your run.sh is executable
RUN chmod +x /workspace/run.sh

# Expose Visdom’s port
EXPOSE 8097

################################################################################
# 5. Default command: launch your run script, which itself starts Visdom + main.py
ENTRYPOINT ["bash", "run.sh"]

# Ensure Visdom’s static folder is world-writable
RUN chmod -R a+rwX /usr/local/lib/python3.10/dist-packages/visdom/static

# syntax=docker/dockerfile:1
FROM nvcr.io/nvidia/jax:23.08-py3

# Install system tools and pip
RUN apt-get update && \
    apt-get install -y git python3-pip && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /workspace

# Clone the GMVAE repository
RUN git clone https://github.com/jariasf/GMVAE.git /workspace/GMVAE

# Install Python dependencies using pip
RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install --no-cache-dir torch torchvision numpy scipy matplotlib pillow

# Switch to the training directory
WORKDIR /workspace/GMVAE/pytorch

# Default entrypoint: launch training (override with args as needed)
ENTRYPOINT ["python3", "train.py"]
CMD ["--help"]
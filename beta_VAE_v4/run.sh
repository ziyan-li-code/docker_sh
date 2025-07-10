#!/usr/bin/env bash
export TORCH_HOME=/tmp/torch_cache
export VISDOM_STATIC_PATH=/usr/local/lib/python3.10/dist-packages/visdom/static

# start Visdom in the background, serving from your vendored assets
nohup python3 -m visdom.server \
     --port 8097 \
     --hostname 0.0.0.0 \
     --static-path "$VISDOM_STATIC_PATH" \
  > visdom.log 2>&1 &

sleep 2

# 3) finally, run your training script
#    pass along any args (e.g. dataset name) to main.py
python3 main.py --dataset 3dchairs --seed 1 --lr 1e-4 --beta1 0.9 --beta 0.999 --objective H --model H --batch_size 64 --z_dim 10 --max_iter 4e2 --beta 4 --viz_name 3dchairs_H_beta4_z10

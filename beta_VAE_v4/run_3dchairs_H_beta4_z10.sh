#!/usr/bin/env bash
export TORCH_HOME=/tmp/torch_cache
# Define the list of parameter values you want to try

result=3dchairs_H_beta4_z10

bsub -q subscription \
     -G compute-hiratani-t2 \
     -sla hiratani_t2 \
     -n 4 \
     -M 16GB \
     -R 'gpuhost rusage[mem=16GB]' \
     -gpu "num=1:gmodel=TeslaV100_SXM2_32GB:gmem=16G" \
     -a "docker(dockerzyli/beta_vae:v4)" \
     -o "${result}_%J.out" \
     -e "${result}_%J.err" \
     bash run.sh

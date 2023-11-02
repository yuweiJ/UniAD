#!/usr/bin/env bash
source set_env.sh

T=`date +%m%d%H%M`

# -------------------------------------------------- #
# Usually you only need to customize these variables #
# CFG=$1
# GPUS=$2                                              #
# -------------------------------------------------- #

# GPUS_PER_NODE=$(($GPUS<8?$GPUS:8))
# NNODES=`expr $GPUS / $GPUS_PER_NODE`

# MASTER_PORT=${MASTER_PORT:-28596}
# MASTER_ADDR=${MASTER_ADDR:-"127.0.0.1"}
# RANK=${RANK:-0}

# WORK_DIR=$(echo ${CFG%.*} | sed -e "s/configs/work_dirs/g")/
WORK_DIR="exp/base_track_map_mini_$T"
if [ ! -d ${WORK_DIR} ]; then
    mkdir -p ${WORK_DIR}
fi

LOG_DIR=$WORK_DIR/logs
# Intermediate files and logs will be saved to UniAD/projects/work_dirs/
if [ ! -d ${LOG_DIR} ]; then
    mkdir -p ${LOG_DIR}
fi

PYTHONPATH="$(dirname $0)/..":$PYTHONPATH \
# python -m torch.distributed.launch \
    # --nproc_per_node=${GPUS_PER_NODE} \
    # --master_addr=${MASTER_ADDR} \
    # --master_port=${MASTER_PORT} \
    # --nnodes=${NNODES} \
    # --node_rank=${RANK} \
python \
    tools/train.py \
    projects/configs/stage1_track_map/base_track_map_mini.py \
    --deterministic \
    --work-dir ${WORK_DIR} \
    2>&1 | tee $LOG_DIR/train.$T
    # --launcher pytorch ${@:3} \
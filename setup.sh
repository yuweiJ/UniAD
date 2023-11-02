CONDA_HOME=$HOME/miniconda3/
CONDA_EXEC=$CONDA_HOME/bin/conda
eval "$($CONDA_EXEC shell.bash hook)"

conda create -n uniad python=3.8 -y
conda activate uniad

# pytorch
conda install cudatoolkit=11.1.1 -c conda-forge
# We use cuda-11.1 by default
pip install torch==1.9.1+cu111 torchvision==0.10.1+cu111 torchaudio==0.9.1 -f https://download.pytorch.org/whl/torch_stable.html
# Recommended torch>=1.9
pip install yapf==0.40.1

## If gcc is not installed:
# conda install -c omgarcia gcc-6 # gcc-6.2
# export PATH=YOUR_GCC_PATH/bin:$PATH
## Eg: export PATH=/mnt/gcc-5.4/bin:$PATH

export CUDA_HOME=/usr/local/cuda
pip install mmcv-full==1.4.0
# If it's not working, try:
# pip install mmcv-full==1.4.0 -f https://download.openmmlab.com/mmcv/dist/cu111/torch1.9.0/index.html
pip install mmdet==2.14.0
pip install mmsegmentation==0.14.1

# mmdet
cd ~/workspace
git clone https://github.com/open-mmlab/mmdetection3d.git
cd mmdetection3d
git checkout v0.17.1
pip install scipy==1.7.3
pip install scikit-image==0.20.0
pip install -v -e .

# uniad
cd ~/workspace/UniAD
pip install -r requirements.txt

# pretrained weights
mkdir ckpts && cd ckpts
# Pretrained weights of bevformer
# Also the initial state of training stage1 model
wget https://github.com/zhiqi-li/storage/releases/download/v1.0/bevformer_r101_dcn_24ep.pth
# Pretrained weights of stage1 model (perception part of UniAD)
wget https://github.com/OpenDriveLab/UniAD/releases/download/v1.0/uniad_base_track_map.pth
# Pretrained weights of stage2 model (fully functional UniAD)
wget https://github.com/OpenDriveLab/UniAD/releases/download/v1.0.1/uniad_base_e2e.pth


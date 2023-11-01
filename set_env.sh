CONDA_HOME=$HOME/miniconda3/
CONDA_EXEC=$CONDA_HOME/bin/conda
eval "$($CONDA_EXEC shell.bash hook)"

conda activate uniad

export PYTHONPATH=/home/y/workspace/UniAD:$PYTHONPATH


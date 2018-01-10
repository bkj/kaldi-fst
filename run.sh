#!/bin/bash

# run.sh

export KALDI_HOME="/home/bjohnson/software/kaldi" # path to kaldi installation

# --
# Run examples, in increasing order of complexity

time ./hclg.sh ./_data/3-gram.pruned.3e-7.fst ./_results/3e-7 # 9 minutes


time ./hclg.sh ./_data/3-gram.pruned.1e-7.fst ./_results/1e-7 # ~20 minutes


time ./hclg.sh ./_data/3-gram.pruned.5e-8.fst ./_results/5e-8 # 


time ./hclg.sh ./_data/3-gram.pruned.1e-8.fst ./_results/1e-8


time ./hclg.sh ./_data/3-gram.pruned.5e-9.fst ./_results/5e-9


time ./hclg.sh ./_data/3-gram.fst ./_results/3-gram


time ./hclg.sh ./_data/4-gram.fst ./_results/4-gram
mkdir -p _results/small

# --
# Download model files

mkdir -p ./_data/exp
# ... wget ...

# --
# Run small example

mkdir -p _data/small
# ... wget ...

export KALDI_HOME="/srv/data/kaldi"
export PATH="$KALDI_HOME/tools/openfst/bin:$KALDI_HOME/src/fstbin/:$KALDI_HOME/src/bin/:$PATH"
time ./make-graph.sh ./_data/G.small.fst ./_results/small-2
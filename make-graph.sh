#!/bin/bash

# make-graph.sh
# 
# Adapted from `mkgraph.sh` from KALDI toolkit

set -o pipefail

if [ $# != 2 ]; then
   echo "Usage: make-graph.sh <g-fst> <graphdir>"
   echo "e.g.: make-graph.sh _data/G.small.fst _results/small/"
   exit 1;
fi

langdir=_data/lm
tree=_data/exp/tree
model=_data/exp/final.mdl
N=1
P=0

g_fst=$1
outdir=$2

mkdir -p $outdir
mkdir -p .tmp

# --
# Check arguments

required="$langdir/L.fst $langdir/phones.txt $langdir/words.txt $langdir/phones/silence.csl $langdir/phones/disambig.int $model $tree"
for f in $required; do
  [ ! -f $f ] && echo "mkgraph.sh: expected $f to exist" && exit 1;
done

# --

fsttablecompose $langdir/L_disambig.fst $g_fst |\
  fstdeterminizestar --use-log=true |\
  fstminimizeencoded |\
  fstpushspecial |\
  fstarcsort --sort_type=ilabel > .tmp/LG.fst || exit 1;

# --

clg=.tmp/CLG_${N}_${P}.fst
ilabels=.tmp/ilabels_${N}_${P}

fstcomposecontext --context-size=$N \
  --central-position=$P \
  --read-disambig-syms=$langdir/phones/disambig.int \
  --write-disambig-syms=.tmp/disambig_ilabels_${N}_${P}.int \
  $ilabels < .tmp/LG.fst | fstarcsort --sort_type=ilabel > $clg

# --

make-h-transducer --disambig-syms-out=$outdir/disambig_tid.int \
  --transition-scale=1.0 $ilabels $tree $model > .tmp/Ha.fst || exit 1;

# --

fsttablecompose .tmp/Ha.fst "$clg" |\
  fstdeterminizestar --use-log=true |\
  fstrmsymbols $outdir/disambig_tid.int |\
  fstrmepslocal |\
  fstminimizeencoded > .tmp/HCLGa.fst || exit 1;

add-self-loops --self-loop-scale=0.1 --reorder=true $model < .tmp/HCLGa.fst |\
  fstconvert --fst_type=const > $outdir/HCLG.fst || exit 1;

# --
# Check results

if ! [ $(head -c 67 $outdir/HCLG.fst | wc -c) -eq 67 ]; then
  echo "$0: it looks like the result in $outdir/HCLG.fst is empty"
  exit 1
fi
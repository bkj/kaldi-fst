#### kaldi-fst

#### Installation

```
# Install kaldi
git clone https://github.com/kaldi-asr/kaldi

cd tools
make
cd ..

cd src
./configure --shared
make depend
make
cd ..
```

#### Usage

See `./run.sh` for usage.

__Note:__ Kaldi is a large software package, but we almost exclusively care about the FST operations, as called in `hclg.sh`:

```
    fsttablecompose
    fstdeterminizestar
    fstminimizeencoded
    fstpushspecial
    fstarcsort
    fstcomposecontext
    fstrmsymbols
    fstrmepslocal
```
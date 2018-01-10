

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
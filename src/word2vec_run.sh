#!/bin/bash
ITER_NUM=3
VEC_NUM=100
TRAIN_PATH="../gen_data/citeseer/walks.txt"
MODEL_PATH="../gen_data/model/citeseer.txt"
VOCAB_PATH="../gen_data/model/vocab.1b.01"
./word2vec -train ${TRAIN_PATH} -output ${MODEL_PATH} -save-vocab ${VOCAB_PATH} -size ${VEC_NUM} -window 5 -sample 1e-4 -negative 5 -hs 0 -binary 0 -cbow 1 -iter ${ITER_NUM}

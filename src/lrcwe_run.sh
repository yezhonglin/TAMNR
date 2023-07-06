#!/bin/bash
TYPE=$1
IDX=$2
BINARY=0
ITER_NUM=1  # 1 for citeseer, dblp and sdbp better than 3 by defalut.
VEC_NUM=100
BELTA_ANT=0.1
BELTA_SYN=0.5
BELTA_REL=0.5
BELTA_TREE=0.5
ALPHA_SYN=0.025
ALPHA_ANT=0.005
ALPHA_REL=0.01
ALPHA_TREE=0.01
TRAIN_PATH="../gen_data/dblp/walks.txt"



TRIPLET_PATH="../gen_data/dblp/triplets_one_word.txt"

SYNONYM_PATH="../gen_data/dblp/tongyici.txt"
ANTONYM_PATH="../gen_data/dblp/2.txt"

VOCAB_PATH="../gen_data/sdblp/dblp.vocab.txt"

if [ $# -lt 1 ];then
	echo "Usage:./lrcwe_run.sh SAR 0"
	exit
fi

if [ $TYPE = "S" ];then
	echo "S training ..."
	MODEL_PATH="../gen_data/model/LTNR_dblp_${VEC_NUM}.txt"
	./lrcwe -train ${TRAIN_PATH} -synonym ${SYNONYM_PATH} -output ${MODEL_PATH} -save-vocab ${VOCAB_PATH} -belta-syn ${BELTA_SYN} -alpha-syn ${ALPHA_SYN} -size ${VEC_NUM} -window 5 -sample 1e-4 -negative 5 -hs 0 -binary ${BINARY} -cbow 1 -iter ${ITER_NUM}
	exit
elif [ $TYPE = "A" ];then
	echo "A training ..."
	MODEL_PATH="../gen_data/model/lswe-cbow-${VEC_NUM}-model.a.wd2.${ITER_NUM}.${BELTA_ANT}.${ALPHA_ANT}.${IDX}.bin"
	./lrcwe -train ${TRAIN_PATH} -antonym ${ANTONYM_PATH} -output ${MODEL_PATH} -save-vocab ${VOCAB_PATH} -belta-ant ${BELTA_ANT} -alpha-ant ${ALPHA_ANT} -size ${VEC_NUM} -window 5 -sample 1e-4 -negative 5 -hs 0 -binary ${BINARY} -cbow 1 -iter ${ITER_NUM}
	exit
elif [ $TYPE = "R" ];then
	echo "R training ..."
	MODEL_PATH="../gen_data/model/lswe-cbow-${VEC_NUM}-model.r.wd18.${ITER_NUM}.${BELTA_REL}.${ALPHA_REL}.${IDX}.bin"
	./lrcwe -train ${TRAIN_PATH} -triplet ${TRIPLET_PATH} -output ${MODEL_PATH} -save-vocab ${VOCAB_PATH} -belta-rel ${BELTA_REL} -alpha-rel ${ALPHA_REL} -size ${VEC_NUM} -window 5 -sample 1e-4 -negative 5 -hs 0 -binary ${BINARY} -cbow 1 -iter ${ITER_NUM}
	exit
elif [ $TYPE = "SA" ];then
	echo "SA training ..."
	MODEL_PATH="../gen_data/model/lswe-cbow-${VEC_NUM}-model.sa.${ITER_NUM}.${BELTA_SYN}.${ALPHA_SYN}.${BELTA_REL}.${ALPHA_ANT}.${IDX}.txt"
	./lrcwe -train ${TRAIN_PATH} -synonym ${SYNONYM_PATH} -antonym ${ANTONYM_PATH} -output ${MODEL_PATH} -save-vocab ${VOCAB_PATH} -belta-syn ${BELTA_SYN} -alpha-syn ${ALPHA_SYN} -belta-ant ${BELTA_ANT} -alpha-ant ${ALPHA_ANT} -size ${VEC_NUM} -window 5 -sample 1e-4 -negative 5 -hs 0 -binary ${BINARY} -cbow 1 -iter ${ITER_NUM}
	exit
elif [ $TYPE = "SAR" ];then
	echo "SAR training ..."
	MODEL_PATH="../gen_data/model/SRNR-${VEC_NUM}.txt"
	./lrcwe -train ${TRAIN_PATH} -triplet ${TRIPLET_PATH} -synonym ${SYNONYM_PATH} -antonym ${ANTONYM_PATH} -output ${MODEL_PATH} -save-vocab ${VOCAB_PATH} -belta-rel ${BELTA_REL} -alpha-rel ${ALPHA_REL} -belta-syn ${BELTA_SYN} -alpha-syn ${ALPHA_SYN} -belta-ant ${BELTA_ANT} -alpha-ant ${ALPHA_ANT} -size ${VEC_NUM} -window 5 -sample 1e-4 -negative 5 -hs 0 -binary ${BINARY} -cbow 1 -iter ${ITER_NUM}
	exit
else echo "Type error"
fi

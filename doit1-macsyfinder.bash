#! /bin/bash

. $(dirname ${BASH_SOURCE[0]})/doit-preamble.bash

# ------------------------------------------------------------------------

rm -rf ${MACSYFINDER}
mkdir -p ${MACSYFINDER}

# ------------------------------------------------------------------------
# Run MacSyFinder
# ------------------------------------------------------------------------

echo 1>&2 '# Run MacSyFinder'

for FAA in ${INPUTS}/*.faa ; do
    STRAIN=$(basename $FAA .faa)
    for MODEL_DIR in ${INPUTS}/models/* ; do
	MODEL=$(basename $MODEL_DIR)
	mkdir -p ${MACSYFINDER}/${MODEL}
	(
	    set -x
	    ${HOWTO} macsyfinder \
		     --mute \
		     --models ${MODEL} all \
		     --sequence-db $FAA \
		     --db-type gembase \
		     --replicon-topology circular \
		     --models-dir ${INPUTS}/models/ \
		     --out-dir ${MACSYFINDER}/${MODEL}/${STRAIN} \
		     --index-dir data/tmp \
		     --worker ${THREADS}
	)
    done
done

# ------------------------------------------------------------------------
# Done.
# ------------------------------------------------------------------------

echo 1>&2 '# Done.'


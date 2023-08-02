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
    for PARTIAL_MODEL in ${MODELS} ; do
	SAFE_PARTIAL_MODEL=$(echo $PARTIAL_MODEL | sed -e 's|/|__|g')
	mkdir -p ${MACSYFINDER}/${SAFE_PARTIAL_MODEL}
	(
	    set -x
	    ${HOWTO} macsyfinder \
		     --mute \
		     --models ${PARTIAL_MODEL} all \
		     --sequence-db $FAA \
		     --db-type gembase \
		     --replicon-topology circular \
		     --models-dir ${INPUTS}/models/ \
		     --out-dir ${MACSYFINDER}/${SAFE_PARTIAL_MODEL}/${STRAIN} \
		     --index-dir data/tmp \
		     --worker ${THREADS}
	)
    done
done

# ------------------------------------------------------------------------
# Done.
# ------------------------------------------------------------------------

echo 1>&2 '# Done.'


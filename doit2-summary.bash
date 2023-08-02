#! /bin/bash

. $(dirname ${BASH_SOURCE[0]})/doit-preamble.bash

# ------------------------------------------------------------------------

rm -rf ${SUMMARY}
mkdir -p ${SUMMARY}

# ------------------------------------------------------------------------
# Print summaries
# ------------------------------------------------------------------------

if [ "${REPLICON_NAMES}" ] ; then
    cat "${REPLICON_NAMES}" | sed -e 's|\(.*\)\t\(.*\)|s/\1\t/\2\t/g|' > ${SUMMARY}/names.sed > ${SUMMARY}/names.sed
else
    touch ${SUMMARY}/names.sed
fi

for MODEL_DIR in ${MACSYFINDER}/* ; do
    MODEL=$(basename $MODEL_DIR)
    (
	echo ''
	echo '#' $MODEL
	echo ''
	cat $MODEL_DIR/*/best_solution_summary.tsv \
	    | sed -f ${SUMMARY}/names.sed \
	    | ${PIPELINE}/scripts/collapse-macsyfinder-summary
    ) | tee ${SUMMARY}/${MODEL}.tsv 
    

done

# ------------------------------------------------------------------------
# Done.
# ------------------------------------------------------------------------

echo 1>&2 '# Done.'


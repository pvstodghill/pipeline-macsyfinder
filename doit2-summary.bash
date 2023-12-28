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

for PARTIAL_MODEL in ${MODELS} ; do
    SAFE_PARTIAL_MODEL=$(echo $PARTIAL_MODEL | sed -e 's|/|__|g')
    (
	echo ''
	echo '#' $PARTIAL_MODEL
	echo ''
	cat ${MACSYFINDER}/${SAFE_PARTIAL_MODEL}/*/best_solution_summary.tsv \
	    | sed -f ${SUMMARY}/names.sed \
	    | sed -e "s|${PARTIAL_MODEL}/||g" \
	    | ${PIPELINE}/scripts/collapse-macsyfinder-summary
    ) | tee ${SUMMARY}/${SAFE_PARTIAL_MODEL}.tsv 
done
echo ''

# ------------------------------------------------------------------------
# Done.
# ------------------------------------------------------------------------

echo 1>&2 '# Done.'


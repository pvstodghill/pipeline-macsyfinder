#! /bin/bash

. $(dirname ${BASH_SOURCE[0]})/doit-preamble.bash

# ------------------------------------------------------------------------

rm -rf ${SUMMARY}
mkdir -p ${SUMMARY}

# ------------------------------------------------------------------------
# Print summaries
# ------------------------------------------------------------------------

for MODEL_DIR in ${MACSYFINDER}/* ; do
    MODEL=$(basename $MODEL_DIR)
    echo ''
    echo '#' $MODEL
    echo ''
    first=1
    for STRAIN_DIR in $MODEL_DIR/* ; do
	STRAIN=$(basename $STRAIN_DIR)
	if [ "$first" ] ; then
	    echo -n Strain$'\t'
	    head -n4 ${STRAIN_DIR}/best_solution_summary.tsv | tail -n1
	    first=
	fi
	tail -n+5 ${STRAIN_DIR}/best_solution_summary.tsv \
	     | sed -e "s/^/$STRAIN\t/"

    done
done

# ------------------------------------------------------------------------
# Done.
# ------------------------------------------------------------------------

echo 1>&2 '# Done.'


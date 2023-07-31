#! /bin/bash

. $(dirname ${BASH_SOURCE[0]})/doit-preamble.bash

# ------------------------------------------------------------------------
# Set up
# ------------------------------------------------------------------------

if [ -d ${DATA} ] ; then
    echo 1>&2 "# Removing ${DATA}. Hope that's what you wanted"
    rm -rf ${DATA}
fi

# --------------------------------------------------

echo 1>&2 "# Initializing ${DATA}/..."
rm -rf ${DATA}/tmp
mkdir -p ${DATA}/tmp

# --------------------------------------------------

echo 1>&2 '# Making copies of genomes'
mkdir -p ${INPUTS}
cp --archive ${GENOMES} ${INPUTS}/

# --------------------------------------------------

echo 1>&2 '# Extracting .faa from .gbk'
(
    shopt -s nullglob
    for EXT in gbk gb gbff ; do
	for GBK in ${INPUTS}/*.${EXT} ; do
	    STRAIN=$(basename $GBK .${EXT})
	    if [ -e ${INPUTS}/${STRAIN}.faa ] ; then
		echo 1>&2 "Error - already exists: ${INPUTS}/${STRAIN}.faa"
		exit 1
	    fi
	    ./scripts/gbk2gembase < $GBK > ${INPUTS}/${STRAIN}.faa
	done
    done
)

# --------------------------------------------------

echo 1>&2 '# Downloading models'
mkdir -p ${INPUTS}/models
for MODEL in ${MODELS} ; do
    echo "## $MODEL"
    macsydata install --target ${INPUTS}/models ${MODEL}
done
    
# --------------------------------------------------

if [ "$PACKAGES_FROM" = howto ] ; then
    echo 1>&2 '# Ensuring entries in packages.yaml are downloaded...'
    (
	set -x
	${PIPELINE}/howto/howto -f ${PIPELINE}/packages.yaml -p '*'
    )
fi

# ------------------------------------------------------------------------
# Done.
# ------------------------------------------------------------------------

echo 1>&2 ''
echo 1>&2 '# Done.'


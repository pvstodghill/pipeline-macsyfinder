# directory into which the results are written.
#DATA=.
#DATA=data # default

# ------------------------------------------------------------------------

# # Genomes to process
GENOMES=FIXME

# # Models to download (refer to MacSyFinder documentation)
MODELS=
MODELS+=" TXSScan"
MODELS+=" TFFscan"
MODELS+=" CasFinder"
MODELS+=" CONJScan"

# # Sensible replicon names - needed because Prokka renames all of the
# # replicons
# REPLICON_NAMES=/.../names.txt

# ------------------------------------------------------------------------

# Uncomment to get packages from HOWTO
PACKAGES_FROM=howto

# # Uncomment to use conda
# PACKAGES_FROM=conda
# CONDA_ENV=pipeline-macsyfinder

#THREADS=$(nproc --all)

# ------------------------------------------------------------------------

#!/bin/bash

# This script uses wget(1) to find PDF files on the U.S. Navy instructions
# website and download them into the current directory.
# By LCDR Mike Pyne.

set -e -u

# Location of Navy instructions website (see README.md for how this URL is
# turned into the list of URLs in instructions.txt, deliberately unused here)
INST_URL="https://www.secnav.navy.mil/doni/allinstructions.aspx"

mkdir -p out

wget --output-file=wget.log \
     --quiet                \
     --show-progress        \
     --xattr                \
     --no-config            \
     --tries=5              \
     --wait=0.5             \
     --random-wait          \
     --no-iri               \
     --no-directories       \
     --recursive            \
     --no-parent            \
     --no-clobber           \
     --accept "*.pdf"       \
     --domains=navy.mil     \
     --directory-prefix=out \
     -i instructions.txt    \
        || echo "There was a problem downloading Navy instructions. wget exit status: $?"

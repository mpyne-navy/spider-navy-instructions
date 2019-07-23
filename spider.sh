#!/bin/bash

# This script uses wget(1) to find PDF files on the U.S. Navy instructions
# website and download them into the current directory.
# By LCDR Mike Pyne.

set -e -u

# Location of Navy instructions website
INST_URL="https://www.secnav.navy.mil/doni/allinstructions.aspx"

wget --output-file=wget.log \
     --quiet                \
     --show-progress        \
     --xattr                \
     --no-config            \
     --tries=5              \
     --wait=3               \
     --random-wait          \
     --no-iri               \
     --no-directories       \
     --recursive            \
     --no-parent            \
     --accept "*.pdf"       \
     --domains=navy.mil     \
     "$INST_URL"            \
        || echo "There was a problem downloading Navy instructions. wget exit status: $?"

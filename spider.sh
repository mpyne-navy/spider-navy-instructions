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
     --user-agent="User-Agent: Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; Googlebot/2.1; +http://www.google.com/bot.html) Chrome/W.X.Y.Z Safari/537.36"        \
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

# Some PDFs have spaces in their filename, let's strip those out for ease of use
find out -name '* *.pdf' -type f -print0 | \
    while read -d $'\0' f;                 \
        do mv -n "$f" "${f// /_}";         \
    done

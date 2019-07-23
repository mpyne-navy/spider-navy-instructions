# Navy Instruction Downloader

## Overview

This uses the [GNU wget](https://www.gnu.org/software/wget/) to spider the U.S.
Navy's public instructions website ("[Department of Navy Issuances](https://www.secnav.navy.mil/doni/allinstructions.aspx)") for PDF
files, and downloads them (but no other files) into a dedicated directory.

## Compiling the instruction list

So the Navy's instructions website uses Javascript and wget isn't a big fan of
that.  The quickest way I found was just to use Chrome DevTools and scrape out
the list of URLs after paginating manually, by running this in the console:

```
x = $$("tr a.ms-listlink[href$='.pdf']").flatMap(x => x.href).join("\n");
```

Once run Chrome will prompt if you want to copy to clipboard, which is what I
did (to then paste into the file). At the time I did this, that meant 3 separate
page loads to get the ~1100 instructions in their table, 500 at a time.

The `[href$='.pdf']` part is to ensure that the non-canceled instructions are
chosen only (canceled instructions still have a hyperlink but it seems to
normally go to a .docx file instead explaining that the instruction is
unavailable).

Of course, there are also non-cancelled but still not-public instructions.
These still link to a PDF, but it's a PDF saying that you can't have this
instruction.  Luckily the Navy has adopted a sane naming convention for
instruction filenames, so filtering these out is relatively easy as well.

There's probably an easy way to do this using `sed(1)` but I just ended up
using vim to find and delete lines matching this regex: `\/[CSF][0-9][^/]\+$`.
That is, searching within the last path component of the URL after all other
`/` characters, find filenames starting with C, S or F and then a digit. These
are the instructions that are Confidential (C), Secret (S) or For Official Use
Only (F) respectively.

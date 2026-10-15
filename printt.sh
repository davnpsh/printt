#!/usr/bin/env bash
# 
# Print a test page.
# https://github.com/davnpsh/printt
# 
# Author: daru <me@davnpsh.dev>
# Date: October 15, 2026
# License: GPL-2.0

DEPENDENCIES=(lp)
PDF_PATH=

set -euo pipefail

check_deps()
{
    for cmd in "${DEPENDENCIES[@]}"; do
        command -v "$cmd" >/dev/null 2>&1 || {
            echo "$cmd is required" >&2
            exit 1
        }
    done
}

usage()
{
	cat <<-EOF
	Usage: $(basename "$0") [options]
    
	Print a test page.
    
	Options
	  -h          print this message and exit
	EOF
}

pick_document()
{
    # default for now
    echo "Setting to default printer test page..."
    
    # CHANGE THIS TO A GLOBAL PATH
    PDF_PATH="$HOME/.bin/printt-data/pages/default.pdf"
}

print()
{
    echo "Sending to printer..."
    
    lp "$PDF_PATH" > /dev/null
}

main()
{
	local opt
	while getopts 'h' opt; do
		case "$opt" in
			h) usage; return 0;;
			*) usage >&2; return 1;;
		esac
	done
	
	check_deps
	pick_document
	print
	
	echo "Done!"
}

main "$@"
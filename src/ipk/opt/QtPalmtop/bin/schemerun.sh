#!/bin/sh

# This script is called when a script is clicked on in the 'Documents Tab'
# as well as from the 'TinyScheme - Run Script' icon.


if scheme-qtopiafiletest $2; then
    # via documents
    schemefile=`scheme-qtopiafiletest $2`
else
    # run script

    # no opie-sh?  warn user
    if which opie-sh; then
    else
        opera $QPEDIR/help/tinyscheme/opie-sh.html
        export RUNME=""
        export RUNME_ARGS=""
        rm -f /tmp/qcop-msg-schemerun.sh
        exit 0;
    fi
    find $HOME -name "*.scm" > /tmp/scheme_files.txt
    find /mnt/cf -name "*.scm" >> /tmp/scheme_files.txt
    find /mnt/sd -name "*.scm" >> /tmp/scheme_files.txt
    schemefile=`opie-sh -g -i -l -F /tmp/scheme_files.txt -t "Select script"`
    rm /tmp/scheme_files.txt
fi

if [ -n "$schemefile" ]; then
    schemecon.sh $schemefile
fi

export RUNME=""
export RUNME_ARGS=""
rm -f /tmp/qcop-msg-schemerun.sh

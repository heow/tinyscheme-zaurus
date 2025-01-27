#!/bin/bash
export RUNME=tinyscheme
if [ -z "$2" ]; then 
   export RUNME_ARGS=$@
else
   export RUNME_ARGS=""
fi
embeddedkonsole
export RUNME=""
export RUNME_ARGS=""
rm -f /tmp/qcop-msg-schemecon.sh


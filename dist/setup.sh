#!/usr/bin/env bash

echo "making common lisp directory..."
mkdir ~/common-lisp/ 2>/dev/null

if [ -z "$(which git 2>/dev/null)" ] ; then
    echo "please install git!"
    exit 1
fi

echo "cloning dependencies and project..."
git clone https://github.com/inaimathi/cl-cwd ~/common-lisp/cl-cwd
git clone https://github.com/compufox/silence-cl ~/common-lisp/silence-cl

[[ -z "$(which wish 2>/dev/null)" ]] && echo "dont forget to install tcl/tk toolkit"

#!/usr/bin/env bash

# for each line in truffle-modules
#    invoke test-module.sh line
# 
# xargs
#  --max-args 1: use at most 1 argument per invocation
#  --max-procs: use maximum number of processors available
xargs --max-procs 0 --max-args 1 ./test-module.sh < truffle-modules

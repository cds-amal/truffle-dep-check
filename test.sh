#!/usr/bin/env bash

# for each line in truffle-modules
#    invoke test-module.sh line
# 
# xargs
#  -n 1: use at most 1 argument per invocation
#  -P 0: use maximum number of processors available
xargs -P 0 -n 1 ./test-module.sh < truffle-modules

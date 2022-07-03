#!/usr/bin/env bash

cat truffle-modules | xargs --max-procs 16 -n 1 ./test-module.sh

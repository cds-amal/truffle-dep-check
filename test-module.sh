#!/usr/bin/env bash

pkg="$1"

mkdir $pkg
cd $pkg

# create manifest
npm init -y

# write test script
cat << EOF > index.js 
try {
  require("@truffle/PKG");
  console.log("Success: PKG OK!");
} catch (err) {
  console.log(err);
  console.log("Fail: PKG NOK!");
}

EOF
sed -i "s:PKG:$pkg:g" index.js

START_TIME=$(date +%s)

# install package
npm i --registry http://localhost:4873 "@truffle/$pkg" > npm.out 2>&1

cd -

# run script
GREP_RESULT=$(grep -C 1 "@truffle/${pkg}" "${pkg}/npm.out")
NPM_RESULT=$(node $pkg) 

# perform a task
END_TIME=$(date +%s)

# elapsed time with second resolution
elapsed=$(( END_TIME - START_TIME ))
printf "${GREP_RESULT}\n${NPM_RESULT} ${elapsed} seconds\n\n" >> test-report.out

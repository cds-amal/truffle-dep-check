#!/usr/bin/env bash

pkg="$1"

mkdir "$pkg" && cd "$pkg" > /dev/null || exit

# create manifest
npm init -y > /dev/null

# write test script
cat << EOF > index.js 
try {
  require("@truffle/PKG");
  console.log("Success: @truffle/PKG OK!");
} catch (err) {
  console.log(err);
  console.log("Fail: @truffle/PKG NOK!");
}

EOF
sed -i "s:PKG:$pkg:g" index.js

START_TIME=$(date +%s)
echo "Probing @truffle/${pkg}"

# install package
npm i --registry http://localhost:4873 "@truffle/$pkg" > npm.out 2>&1

cd - > /dev/null || exit

# run script
GREP_RESULT=$(grep -C 1 "@truffle/${pkg}" "${pkg}/npm.out")
NPM_RESULT=$(node "$pkg") 

# calculate time
END_TIME=$(date +%s)
ELAPSED=$(( END_TIME - START_TIME ))

# record summary
printf "%s\n%s %s seconds\n\n" "${GREP_RESULT}" "${NPM_RESULT}" "${ELAPSED}" >> test-report.out

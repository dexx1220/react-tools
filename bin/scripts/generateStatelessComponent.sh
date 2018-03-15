#!/bin/bash

USAGE="Usage: trt generate sc ComponentName"

if [ $# -lt 2 ]; then
  echo $USAGE
  exit 1;
fi

if [ "$1" == "statelessComponent" ]; then
supplied_name=${2//[-.]/} # remove hyphens and periods

# Capitalized version of the Component name
Name="$(tr '[:lower:]' '[:upper:]' <<< ${supplied_name:0:1})${supplied_name:1}"

# Lowercased version of the Component name
name="$(tr '[:upper:]' '[:lower:]' <<< ${supplied_name:0:1})${supplied_name:1}"

mkdir "./$Name"

if [ "$?" -ne "0" ]; then
  exit 1
fi

cat > "./$Name/index.js" <<EOF
import React from 'react'
import css from './style.css'

const $Name = () => (
  <div className={css.$name} />
)

$Name.propTypes = {
}

export default $Name
EOF

cat > "./$Name/style.css" <<EOF
.$name {

}
EOF

cat > "./$Name/index.test.js"<<EOF
/* eslint-env jest */

import React from 'react'
import $Name from './$Name'

describe('$Name', () => {
  <$Name />
})
EOF

echo $Name created ✨

fi

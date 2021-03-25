#!/bin/bash
set -e

mutex_test() { return -23; }

mutex_test

echo $?

echo "Done"

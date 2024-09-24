#!/bin/bash

# Gets called with 3 args: filename, line, column
filename=$1
line=$2
column=$3

# Call Cursor with the expected arguments
cursor -g "${filename}:${line}:${column}"

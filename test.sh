#!/bin/bash

# very simple test script
# runs a couple input files with different delimiters, then sorts each one for each different sort types
# no output means that the test was successful

declare -a SORT_TYPES=(gender birthDate lastName)

for SORT_TYPE in "${SORT_TYPES[@]}"; do
    python read_records.py input1.txt " | " $SORT_TYPE > test_output-1.txt
    python read_records.py input2.txt ", " $SORT_TYPE > test_output-2.txt 
    python read_records.py input3.txt " " $SORT_TYPE > test_output-3.txt
    
    echo "Test 1 $SORT_TYPE:"
    diff test_output-1.txt "output-${SORT_TYPE}.txt" 

    echo "Test 2 $SORT_TYPE:"
    diff test_output-2.txt "output-${SORT_TYPE}.txt" 

    echo "Test 3 $SORT_TYPE:"
    diff test_output-3.txt "output-${SORT_TYPE}.txt" 
    
    rm test_output-1.txt
    rm test_output-2.txt
    rm test_output-3.txt
done
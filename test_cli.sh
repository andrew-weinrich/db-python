#!/bin/bash

# very simple test script
# runs a couple input files with different delimiters, then sorts each one for each different sort types
# no output means that the test was successful

SORT_TYPES=(gender birthdate name)

# different delimiters used, with a placeholder at index 0
DELIMITERS=('zero_placeholder' ' | ' ', ' ' ')
DELIMITER_COUNT=`expr ${#DELIMITERS[@]} - 1`

for SORT_TYPE in "${SORT_TYPES[@]}"; do
    for TEST_ID in `seq 1 $DELIMITER_COUNT`; do
        python read_records.py input${TEST_ID}.txt "${DELIMITERS[$TEST_ID]}" $SORT_TYPE > test_output-${TEST_ID}.txt
    
        echo "Test $TEST_ID $SORT_TYPE:"
        diff test_output-${TEST_ID}.txt "output-${SORT_TYPE}-cli.txt" 
    
        rm test_output-${TEST_ID}.txt
    done
done
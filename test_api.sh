#!/bin/bash

# very simple test script
# runs a couple input files with different delimiters, then sorts each one for each different sort types
# no output means that the test was successful

declare -a SORT_TYPES=(gender birthdate name)


# starts the service, posts data, retrieves it in a sorted order, then terminates the service
post_data() {
    DELIMITER="$1"
    TEST_ID="$2"
    
    python service.py &
    SERVICE_PID=$!
    sleep 10
    
    while read line; do
        curl -X POST -d "$line" "http://localhost:8080/records?delimiter=$DELIMITER"
    done < "input${TEST_ID}.txt"
    
    curl -X GET "http://localhost:8080/records/${SORT_TYPE}" > test_output-${TEST_ID}.txt
    
    kill $SERVICE_PID
}


%20%7C%20


for SORT_TYPE in "${SORT_TYPES[@]}"; do
    post_data '%20%7C%20' 1
    post_data '%2C%20' 2
    post_data '%20' 3
    
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
#!/bin/bash

# very simple test script
# runs a couple input files with different delimiters, then sorts each one for each different sort types
# no output means that the test was successful

# this script is fragile because it depends on the exact formatting of the JSON message -
# needs to be refactored in python

declare -a SORT_TYPES=(gender birthdate name)


# starts the service, posts data, retrieves it in a sorted order, then terminates the service
post_data() {
    DELIMITER="$1"
    TEST_ID="$2"
    
    #python service.py 2>&1 &
    python service.py > /dev/null 2>&1 &
    SERVICE_PID=$!
    sleep 3
    
    while read line; do
        curl -s -X POST -d "$line" "http://localhost:8080/records?delimiter=$DELIMITER"
    done < "input${TEST_ID}.txt"
    
    curl -s -X GET "http://localhost:8080/records/${SORT_TYPE}" > "test_output-${TEST_ID}-${SORT_TYPE}.txt"
    
    kill $SERVICE_PID
    wait $SERVICE_PID > /dev/null 2>&1
}




for SORT_TYPE in "${SORT_TYPES[@]}"; do
    post_data '%20%7C%20' 1  # delimiter ' | '
    post_data '%2C%20' 2     # delimiter ', '
    post_data '%20' 3        # delimiter ' '
    
    echo "Test 1 $SORT_TYPE:"
    diff "test_output-1-${SORT_TYPE}.txt" "output-${SORT_TYPE}-api.txt" 

    echo "Test 2 $SORT_TYPE:"
    diff "test_output-2-${SORT_TYPE}.txt" "output-${SORT_TYPE}-api.txt" 

    echo "Test 3 $SORT_TYPE:"
    diff "test_output-3-${SORT_TYPE}.txt" "output-${SORT_TYPE}-api.txt" 
    
    rm test_output-1-${SORT_TYPE}.txt
    rm test_output-2-${SORT_TYPE}.txt
    rm test_output-3-${SORT_TYPE}.txt
done
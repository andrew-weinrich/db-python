#!/usr/bin/python

from datetime import datetime
import sys
from functools import cmp_to_key

from records import Record, sortMethods







def main():
    if len(sys.argv) != 4:
        raise Exception("Invalid number of parameters: should be read_records.py fileName delimiter sortType")
    
    records = {}
    
    fileName = sys.argv[1]
    delimiter = sys.argv[2]
    sortType = sys.argv[3]
    
    with open(fileName, "r") as inputFile:
        for line in inputFile:
            line = line.strip()
            components = line.split(delimiter)
            
            # assume that input data does not have to be validated
            lastName = components[0]
            firstName = components[1]
            gender = components[2]
            favoriteColor = components[3]
            birthDate = datetime.strptime(components[4], "%Y-%m-%d")
            
            record = Record(firstName, lastName, gender, favoriteColor, birthDate)
            
            records[record.key] = record
    
    # assume that sortType does not have to be validated
    sortedRecords = sorted(records.values(), key = cmp_to_key(sortMethods[sortType]))
    
    for record in sortedRecords:
        print "{0} {1} {2} {3} {4}".format(
            record.lastName,
            record.firstName,
            record.favoriteColor,
            record.gender,
            record.birthDate.strftime("%m/%d/%Y")
        )
    
    


if __name__ == "__main__":
    main()




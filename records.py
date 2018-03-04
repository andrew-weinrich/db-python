#!/usr/bin/python


from datetime import datetime







class Record:
    """Simple person record"""
    firstName = ""
    lastName = ""
    favoriteColor = ""
    gender = ""
    birthDate = None
    key = ""
    
    def __init__(self, firstName, lastName, gender, favoriteColor, birthDate):
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.favoriteColor = favoriteColor
        self.birthDate = birthDate
        self.key = self._createKey()
        
    # private method to create a key for the record
    def _createKey(self):
        return self.lastName + "-" + self.firstName

    def __str__(self):
        return "lastName:'{0}'; firstName:'{1}'; favoriteColor:'{2}'; gender:'{3}'; birthDate:'{4}'".format(
            self.lastName,
            self.firstName,
            self.favoriteColor,
            self.gender,
            self.birthDate
        )


# comparison methods for different kinds of sorts
sortMethods = {
    'birthdate' : lambda a,b : cmp(a.birthDate, b.birthDate),
    'gender' : lambda a,b : 
        cmp(a.gender + "-" + a.lastName + "-" + a.firstName,
            b.gender + "-" + b.lastName + "-" + b.firstName),
    'name' : lambda a,b :
        cmp(b.lastName,
            a.lastName)
}

def parseRecord(line, delimiter):
    components = line.split(delimiter)
    
    # assume that input data does not have to be validated
    lastName = components[0]
    firstName = components[1]
    gender = components[2]
    favoriteColor = components[3]
    birthDate = datetime.strptime(components[4], "%Y-%m-%d")
    
    return Record(firstName, lastName, gender, favoriteColor, birthDate)
    




    
    
    






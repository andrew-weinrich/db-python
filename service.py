#!/usr/bin/python


import web
from records import Record, sortMethods, parseRecord
from functools import cmp_to_key


urls = (
    # takes a parameter ?delimiter= that indicates how the input is delimited
    '/records', 'PostRecords',
  
    '/records/(' + '|'.join(sortMethods.keys()) + ')',  'GetRecords',
)


records = {}


class GetRecords:
    def GET(self, sortMethod):
        web.header('Content-Type', 'text/plain')
        
        # sortType is validated by regex in the records
        sortedRecords = sorted(records.values(), key = cmp_to_key(sortMethods[sortMethod]))
        
        output = ""
        for record in sortedRecords:
            output = output + "{0} {1} {2} {3} {4}".format(
                record.lastName,
                record.firstName,
                record.favoriteColor,
                record.gender,
                record.birthDate.strftime("%m/%d/%Y")
            )
        
        return output


class PostRecords:
    def POST(self):
        data = web.data()
        parameters = web.input(delimiter="")
        
        record = parseRecord(data, parameters.delimiter)
        records[record.key] = record
        
        web.header('Content-Type', 'text/plain')
        return ''



if __name__ == "__main__": 
    app = web.application(urls, globals())
    app.run()

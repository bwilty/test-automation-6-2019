##########################
# This file contains a module with utility functions for step definitions,
# and it sets the World instance to use this module.
##########################

module UtilityFunctions

    # Is the string correctly formatted as currency?
    def isEntryCurrency?(entry)
        # To check if an entry is a currency, we will use a regular
        # expression that says the string must begin with a $, optionally a -,
        # and a number.  It must then be a series of numbers and commas,
        # and it can optionally have a decimal point with one or two numbers after it.
        # This regex doesn't care if commas are correctly placed, so it could be
        # improved on that front, and it requires there are most two decimal
        # points, which I think is iffy as a requirement.
        index = entry =~ /^\$-?[0-9][0-9,]*(\.[0-9][0-9]?)?$/
        return (index != nil)
    end

    # Returns the float associated with the given string if it is a currency.
    # If the given string is not a currency, this returns nil.
    def getCurrencyValue(entry)

        # if entry is formatted as currency
        if isEntryCurrency?(entry)

            # ignore the initial $
            entry = entry[1..]

            # get rid of commas
            entry.gsub!(/,/, "")

            # convert to a number and return.  We will convert everything to 
            # a float for simplicity
            return entry.to_f()

        # if it is not formatted as currency, returns nil as an error value
        else
            return nil        
        end
    end

end

World(UtilityFunctions)

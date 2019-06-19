require_relative '../../pages/values'


# This module will hold any
# utility functions that are used in multiple places
module State

    def newPage()
        return ValuesPage.new()
    end

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

    def getCurrencyValue(entry)
        # Returns the number associated with the currency if it is a currency.
        if isEntryCurrency?(entry)
            # ignore the initial $
            entry = entry[1..]

            # get rid of commas
            entry.gsub!(/,/, "")

            # convert to a number and return.  We will convert everything to 
            # a float for simplicity
            return entry.to_f()

        # if it is not a currency, returns nil as an error value
        else
            return nil        
        end
    end

end



World(State)

#####################
# GIVEN's
#####################

Given("the page is loaded") do
    @page = self.newPage()
    @page.goto("http://localhost/values")
end

Given("the value entries") do
    @valueEntries = @page.getValueEntries()
end

Given("the currency entries") do
    @currencyEntries = @page.getCurrencyEntries()
end

Given("the total balance") do
    @totalBalance = @page.getTotalCurrency()
end

###################
# THEN's
###################

Then("the amount of value and currency entries should be equal") do
    # first ensure that @valueEntries and @currencyEntries have been built
    expect(@valueEntries).not_to be_nil
    expect(@currencyEntries).not_to be_nil

    # then compare their lengths
    expect(@valueEntries.length).to eq(@currencyEntries.length)
end

Then("I should see {int} value entries") do |num|
    # first ensure that @valueEntries is built
    expect(@valueEntries).not_to be_nil

    # then check its length against num
    expect(@valueEntries.length).to eq(num)
end

Then("I should see {int} currency entries") do |num|
    # first ensure that @currencyEntries is built
    expect(@currencyEntries).not_to be_nil

    # then check its length against num
    expect(@currencyEntries.length).to eq(num)
end

Then("each currency entry should be greater than {int}") do |value|
    # first ensure that @currencyEntries is built
    expect(@currencyEntries).not_to be_nil

    # then get the value of each entry (which implicitly includes checking that
    # it is formatted correctly) and ensure the value is greater than
    # the value parameter
    @currencyEntries.each do |currencyEntry|
        currencyValue = self.getCurrencyValue(currencyEntry)
        expect(currencyValue).not_to be_nil
        expect(currencyValue > value).to be_truthy
    end
end

Then("each currency entry is formatted correctly") do
    # first ensure that @currencyEntries is built
    expect(@currencyEntries).not_to be_nil

    # then check that each entry is formatted correctly
    @currencyEntries.each do |currencyEntry|
        isCurrency = self.isEntryCurrency?(currencyEntry)
        expect(isCurrency).to be_truthy
    end
end

Then("the total balance is equal to the sum of the currency entries") do
    # first ensure that @currencyEntries and @totalBalance are built
    expect(@currencyEntries).not_to be_nil
    expect(@totalBalance).not_to be_nil

    # then, convert the total balance to a value (and fail if it is implicitly
    # discovered to not be formatted correctly)
    totalValue = self.getCurrencyValue(@totalBalance)
    expect(totalValue).not_to be_nil

    # next, get the sum of all currency entries.  If any currency entry
    # is not formatted correctly (implicitly discovered through a nil value)
    # then fail immediately.
    sum = 0
    @currencyEntries.each do |currencyEntry|
        currencyValue = self.getCurrencyValue(currencyEntry)
        expect(currencyValue).not_to be_nil
        sum += currencyValue    
    end
    
    # finally, compare the total value to the sum
    expect(totalValue).to eq(sum)
end

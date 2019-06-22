require_relative "../../pages/values"
require_relative "../support/config"

#####################
# GIVEN's - These blocks implement the Given statements in the feature file.
#####################

# Get a page object instance and go to the desired url.
# It uses the correct domain based on the configuration.
Given("the values page is loaded") do
    @page = ValuesPage.new()
    @page.goto(Configuration::DOMAIN + "/values")
end

# Get all the value entry strings on the page
Given("the value entries") do
    @valueEntries = @page.getValueEntries()
end

# Get all the currency entry strings on the page
Given("the currency entries") do
    @currencyEntries = @page.getCurrencyEntries()
end

# Get the string representing the total balance
Given("the total balance") do
    @totalBalance = @page.getTotalCurrency()
end

###################
# THEN's - These blocks implement the Then statements in the feature file.
###################

# The lengths of valueEntries and currencyEntries should match
Then("the amount of value and currency entries should be equal") do
    # first ensure that @valueEntries and @currencyEntries have been built
    expect(@valueEntries).not_to be_nil
    expect(@currencyEntries).not_to be_nil

    # then compare their lengths
    expect(@valueEntries.length).to eq(@currencyEntries.length)
end

# The length of valueEntries should equal some number
Then("I should see {int} value entries") do |num|
    # first ensure that @valueEntries is built
    expect(@valueEntries).not_to be_nil

    # then check its length against num
    expect(@valueEntries.length).to eq(num)
end

# The length of currencyEntries should equal some number
Then("I should see {int} currency entries") do |num|
    # first ensure that @currencyEntries is built
    expect(@currencyEntries).not_to be_nil

    # then check its length against num
    expect(@currencyEntries.length).to eq(num)
end

# The numerical value of each currency entry should be greater than some number.
# This also implies that each currency entry is correctly formatted to enable 
# interpreting a float value from it.
Then("each currency entry should be greater than {int}") do |value|
    # first ensure that @currencyEntries is built
    expect(@currencyEntries).not_to be_nil

    # then get the value of each entry (which implicitly includes checking that
    # it is formatted correctly) and ensure the value is greater than
    # the value parameter
    @currencyEntries.each do |currencyEntry|
        currencyValue = getCurrencyValue(currencyEntry)
        expect(currencyValue).not_to be_nil
        expect(currencyValue > value).to be_truthy
    end
end

# The text of each currency entry is correctly formatted as a currency
Then("each currency entry is formatted correctly") do
    # first ensure that @currencyEntries is built
    expect(@currencyEntries).not_to be_nil

    # then check that each entry is formatted correctly
    @currencyEntries.each do |currencyEntry|
        isCurrency = isEntryCurrency?(currencyEntry)
        expect(isCurrency).to be_truthy
    end
end

# The sum of the floats of currencyEntries is equal to the float
# value for the totalBalance.  This implies that all of these are
# correctly formatted as currencies so that float values can be
# interpreted from them.
Then("the total balance is equal to the sum of the currency entries") do
    # first ensure that @currencyEntries and @totalBalance are built
    expect(@currencyEntries).not_to be_nil
    expect(@totalBalance).not_to be_nil

    # then, convert the total balance to a value (and fail if it is implicitly
    # discovered to not be formatted correctly)
    totalValue = getCurrencyValue(@totalBalance)
    expect(totalValue).not_to be_nil

    # next, get the sum of all currency entries.  If any currency entry
    # is not formatted correctly (implicitly discovered through a nil value)
    # then fail immediately.
    sum = 0
    @currencyEntries.each do |currencyEntry|
        currencyValue = getCurrencyValue(currencyEntry)
        expect(currencyValue).not_to be_nil
        sum += currencyValue    
    end
    
    # finally, compare the total value to the sum
    expect(totalValue).to eq(sum)
end

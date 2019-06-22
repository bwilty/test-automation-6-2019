#######
# This defines the values page as a feature and sets up a set of test scenarios
# to test the page.
########

Feature: The Values Page
    Is the values page correct?

    # This occurs before every scenario and simply says that we want a chrome
    # browser open and the page to be loaded
    Background:
        Given the values page is loaded

    # Verify that the right count of values appears on the screen.
    Scenario: The right count of values appear on the screen
        Given the value entries
        And the currency entries
        Then the amount of value and currency entries should be equal
        And I should see 5 value entries
        And I should see 5 currency entries
        # last one is unneeded, but this makes the requirement explicit
 
    # Verify that the values on the screen are greater than 0.
    # I intrepret the the values in this case to refer to the currency entries
    Scenario: Each value on the screen is greater than 0
        Given the currency entries
        Then each currency entry should be greater than 0

    # Verify that the total balance is correct based on the values listed on the screen,
    # which is equivalent to verifying that the total balance matches the sum of the values
    Scenario: The total balance matches the sum of the values
        Given the total balance
        And the currency entries
        Then the total balance is equal to the sum of the currency entries
    
    # Verify that the values are formatted as currencies.  Note that this occurs implicitly
    # in the previous two scenarios as well.
    Scenario: The values are formatted as currencies
        Given the currency entries
        Then each currency entry is formatted correctly

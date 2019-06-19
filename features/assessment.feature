Feature: The Values Page
    Is the values page correct?

    Background:
        Given the page is loaded

    # Need to verify the right count of values appear on the screen
    Scenario: The right count of values appear on the screen
        Given the value entries
        And the currency entries
        Then the amount of value and currency entries should be equal
        And I should see 5 value entries
        And I should see 5 currency entries
        # last one is unneeded, but this makes the requirement explicit
 
    # Need to verify the values on the screen are greater than 0
    # I intrepret the the "values" in this test case to refer to the currency entries
    Scenario: Each value on the screen is greater than 0
        Given the currency entries
        Then each currency entry should be greater than 0

    # Need to verify the total balance is correct based on the values listed on the screen
    # I interpret this as being the same test as...
    # Need to verify the total balance matches the sum of the values
    Scenario: The total balance matches the sum of the values
        Given the total balance
        And the currency entries
        Then the total balance is equal to the sum of the currency entries
    
    # Need to verify the values are formatted as currencies
    Scenario: The values are formatted as currencies
        Given the currency entries
        Then each currency entry is formatted correctly

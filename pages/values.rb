require 'watir'

######
# This is the page object for the values page under test.  It serves as a
# level of abstraction between the specific implementation of the page
# and conceptually what exists on the page so that implementation details
# need not impact how our feature statement definitions interact with the page.
####

class ValuesPage
    # A class-level browser instance.  We only open one at a time to make it so
    # only one browser is open throughout the testing.  This seems more memory
    # efficient compared to openning a new browser per test case although
    # that would be more pure from a testing perspective and allow for test
    # parallelization.
    @@browser = nil

    # Constructor.  If no browser instance exists, create a new one.
    def initialize()
        if @@browser.nil?
            @@browser = Watir::Browser.new :chrome
        end
    end

    # Browse to a specific url
    def goto(url)
        @@browser.goto url
    end

    # Conceptually: get all the value strings on the page.
    # Technically: Get the text from all the lbl_val_# elements on the page
    def getValueEntries()
        ids = [ "lbl_val_1", "lbl_val_2", "lbl_val_3", "lbl_val_4", "lbl_val_5" ]
        return getTextsOfLIs(ids)
    end

    # Conceptually: get all the currency strings (except the total) on the page.
    # Technically: Get the text from all the text_val_# elements on the page
    def getCurrencyEntries()
        ids = [ "txt_val_1", "txt_val_2", "txt_val_4", "txt_val_5", "txt_val_6"]
        return getTextsOfLIs(ids)
    end

    # Conceptually: get the string associated with the total 
    # Technically: Get the text from the lbl_ttl_val element on the page
    def getTotalLabel()
        return @@browser.div(:id => "lbl_ttl_val").text
    end

    # Conceptualy: get the string associated with the total balance
    # Technically: Get the text from the txt_ttl_val element on the page
    def getTotalCurrency()
        return @@browser.div(:id => "txt_ttl_val").text
    end

    # Helper function that gets the text from li elements that have the
    # id's given as the parameter.  This is used by getValueEntries and
    # getCurrencyEntries
    private def getTextsOfLIs(elementIds)

        # return an array that contains the text value of each li element
        # identified by an id in the parameter.  If the element isn't found,
        # place nil in the array instead.  We do all this by mapping the
        # id array to a new array.
        # Note: need testing to figure out what would happen if the element
        # is found but has no text.  I suspect it either returns an empty
        # string or a nil
        return elementIds.map do |id|
            el = @@browser.element(:tag_name => "li", :id => id)
            (el.nil? ? nil : el.text)
        end
    end
end
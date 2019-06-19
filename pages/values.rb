require 'watir'

class ValuesPage
    @@browser = nil

    def initialize()
        if @@browser.nil?
            @@browser = Watir::Browser.new :chrome
        end
    end

    def goto(url)
        @@browser.goto url
    end

    def getValueEntries()
        ids = [ "lbl_val_1", "lbl_val_2", "lbl_val_3", "lbl_val_4", "lbl_val_5" ]
        return getTextsOfLIs(ids)
    end

    def getCurrencyEntries()
        ids = [ "txt_val_1", "txt_val_2", "txt_val_4", "txt_val_5", "txt_val_6"]
        return getTextsOfLIs(ids)
    end

    def getTotalLabel()
        return @@browser.div(:id => "lbl_ttl_val").text
    end

    def getTotalCurrency()
        return @@browser.div(:id => "txt_ttl_val").text
    end

    private def getTextsOfLIs(elementIds)
        texts = []

        elementIds.each do |id|
            newText = @@browser.element(:tag_name => "li", :id => id).text
            texts.push(newText)
        end

        return texts
    end
end
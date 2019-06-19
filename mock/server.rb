require 'webrick'

#######
# This file runs a simple WEBrick server that mocks an HTTP server
# for the call we want our tests to make.
#######

mockServer = WEBrick::HTTPServer.new(:Port => "80")

mockServer.mount_proc "/values" do |res, rep|
    rep.body = File.new("./mock/values.html")
    rep.content_type = "text/html"
end

mockServer.start

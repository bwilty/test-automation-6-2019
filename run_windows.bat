rem This is a simple Windows batch file for setting the path to the webdriver,
rem starting up a mock http server, and running cucumber.  Similar scripts
rem on other operating systems could be written, or a more sophisticated
rem process could be set up with environment variables, etc.

rem An area for further improvement of this script is to automatically kill
rem the mock server once cucumber has completed.

PATH=%PATH%;.\external
start ruby .\mock\server.rb
cucumber

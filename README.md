This project demonstrates using Cucumber, Watir, and RSpec Expectations in the Ruby
programming language to test a page with values listed on it.  This was created as
part of a job application assessment.

This project was created using ruby version `ruby 2.6.3p62 (2019-04-16 revision 67580) [x64-mingw32]`
and was last run using the latest version of the libraries in Gemfile as of June 22, 2019.  It also
assumes that the user has Google Chrome installed.

- By Bryan Wiltgen
- Last updated on June 22, 2019

Project Structure
=================
- external - holds the Chromedriver file that will be used to manipulate Google Chrome
- features - holds the step definitions, the feature file (containing the test cases), and some utilities in support.
- mock - holds a ruby file that runs a mock HTTP server using WEBrick and serves up a stubbed web page.
- pages - holds the page object class for the values page
- Gemfile - describes what libraries are used in this project
- example_output.txt - contains output from the cucumber command from a run of runs_windows.bat, which represents the testing output.  Also includes a short note about the results.
- README.md - this file
- run_windows.bat - a Windows batch script that sets the path, starts the mock webserver, and then runs cucumber to do testing.
 
Set Up
======

- Gems - run gem install -g to pick up the gems described by Gemfile
- Download ChromeDriver - https://chromedriver.storage.googleapis.com/index.html?path=75.0.3770.90/
- Modify run_windows.bat as needed, create your own script (if on macOS or Linux, etc.), or determine what steps are needed to run the program.

To run the project
==================
If not using run_windows.bat, which already does these things, one needs to do the following:

1. Set the path to communicate to cucumber where the ChromeDriver lives
2. Boot up the mock webserver
3. Run `cucumber` to start the testing


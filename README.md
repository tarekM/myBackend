dailyroute
==========
Ruby version: 2.0.0

In order to run the tests, please clone the github repository and run

bundle install

Make sure that database.yml is in the config folder.

Then run:

bin/rake db:migrate RAILS_ENV=test

rspec spec

The tests should run.
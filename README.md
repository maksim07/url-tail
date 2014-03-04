url-fetch.sh
=========

  This bash script monitors url for changes and print its tail into standard output. It acts as "tail -f" linux command.
  It can be helpful for tailing logs that are accessible by http.

# Installation

  Script needs *curl* to be installed. Many Linux distributions as well as Mac OS X already have curl installed.
  On Ubuntu you can use this command to install curl:

  `sudo apt-get install curl`

  Then copy script to your computer:

  `cd /usr/bin`
  `sudo wget https://raw.github.com/maksim07/url-tail/master/script/src/url-fetch.sh`
  `sudo chmod +x url-fetch.sh`

# Usage

  To start tailing url just run

  `url-fetch.sh http://example.com/file_to_tail`

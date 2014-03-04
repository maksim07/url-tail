url-tail.sh
=========

  This bash script monitors url for changes and print its tail into standard output. It acts as "tail -f" linux command.
  It can be helpful for tailing logs that are accessible by http.

# Installation

  Script needs *curl* to be installed. Many Linux distributions as well as Mac OS X already have curl installed.
  On Ubuntu you can use this command to install curl:

`sudo apt-get install curl`

  Then copy script to your computer:

```
sudo curl -o /usr/bin/url-fetch.sh -s https://raw.github.com/maksim07/url-tail/master/script/src/url-tail.sh
sudo chmod +x url-fetch.sh
```

# Usage

  To start tailing url just run

`url-tail.sh http://example.com/file_to_tail`

  Script will stop automatically if remote file will be re-created e.g. in case of log rotation.

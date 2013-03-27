# Kali Scripts

## Overview
This is simply a place for me to store scripts to make my life easier using kali.  Hopfully others will find them useful and even contribute to them.

### kaliupdate.sh
This is a simple update script, I purposfully kept it simple and easy to read with a lot of echo's to the screen so people newer to shell scripting could understand it and easily update it adding the tools they want to keep updated.  Simply it:

1. Updates the system
2. Updates a few tools I use often enough to want to keep up to date.

I didn't automate adding in bleeding edge packages.  I'm going to wait and see how that goes first.  But this is a lot less than the backtrack update script I wrote.  Kali is doing a good job keeping things updated often in packages, no need to do more.

I hope someone out there finds it useful to see and I hope people contribute back and I would love to see what tools other people like.

### chromium_fix.sh
I like using Chrome, and I like running as root on Kali.  I hate having to edit the chromium file every time I do an apt-get upgrade so it runs.  So I made this script which will fix it for me when it is updated.  I'm using the chromium package from apt-get install chromium.  If you download Chrome from google and install it, the file name is /usr/bin/chrome and the exec line which is replaced is different.  So the script won't work for that one.  Ditch it and install the offical package, it isn't updated every day like the other one too, so it is less annoying.  If a few people ask I'll make a script for that one too.

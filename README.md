# Kali Scripts

## Overview
This is simply a place for me to store scripts to make my life easier using kali.  Hopfully others will find them useful and even contribute to them.

### kaliupdate.sh
Update 10/29/14:
Minor typo changes in echo's. Changed the update to do a dist-update.

Update 8/31/12:
I rewrote the update script.  People haven't been adding to it so I decided to stop keeping it simple and make it more flexible.  I added switches so you can decide if you just want to update packages, add packages, add software from source, or all of it.  To get the same functionality as before just add a -a to the end of the script.

I remove the Nessus update since that doesn't seem to work anymore with Nessus 5.  I added aircrack-ng install from source since it does really seem needed if you are using airobase-ng for evil twin attacks.  

### kaliautoupdate.sh
I added this script for server/workstations that don't get turned off. The idea is to link this in one of the /etc/cron.* directories and let it run on it's own. 

**WARNING:** This script assumes the kaliupdate.sh script was ran at least once with the -a option. It does very little checks, it doesn't setup things up to auto-start, add packages needed to compile things, etc. The one time items from the kaliupdate.sh script are removed. Running this script having not rane the manual kaliupdate.sh script first could cause errors.


### chromium_fix.sh
I like using Chrome, and I like running as root on Kali.  I hate having to edit the chromium file every time I do an apt-get upgrade so it runs.  So I made this script which will fix it for me when it is updated.  I'm using the chromium package from apt-get install chromium (now in the extra packages option of the update script) since it seems to be updated far less than the chrome package from google.  If you download Chrome from google and installed it, the file name is /usr/bin/chrome and the exec line which is replaced is different, threfore this script won't work for that one.  Ditch it and install Chromium.  It isn't updated every day like the other one too, so it is less annoying.

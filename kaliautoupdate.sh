#For server/workstation installs that always stay on, link this in a cron folder and enjoy.
#It assumes you ran the kaliupdate.sh file and did a -a once, it does not check for packages needed or install new ones or patch freeradius or install easy-creds other one time things from the other script.

apt-get update && apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade
/opt/metasploit/apps/pro/msf3/msfupdate
cd /opt/metasploit/apps/pro/msf3/
bundle install
if [ -d /usr/share/fuzzdb ]; then
  cd /usr/share/fuzzdb
  svn up
  else
  cd /usr/share
  svn co http://fuzzdb.googlecode.com/svn/trunk fuzzdb
fi
svn co --username guest --password "" https://svn.nmap.org/nmap /opt/nmap-svn
cd /opt/nmap-svn
./configure && make
/opt/nmap-svn/nmap -V
if [ -d /opt/aircrack-ng-svn ]; then
  cd /opt/aircrack-ng-svn
  svn up
else
  svn co http://svn.aircrack-ng.org/trunk/ /opt/aircrack-ng-svn
  cd /opt/aircrack-ng-svn
fi
make && make install
airodump-ng-oui-update
updatedb
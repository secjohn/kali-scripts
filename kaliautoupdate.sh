#For server/workstation installs that always stay on, link this in a cron folder and enjoy.
#It assumes you ran the kaliupdate.sh file and did a -a once, it does not check for packages needed or install new ones or patch freeradius or install easy-creds other one time things from the other script.

apt-get update -y && apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade -y && apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade -y
apt-get autoclean -y && apt-get clean -y
apt-get autoremove
if [ -d /usr/share/fuzzdb/.git ]; then
    cd /usr/share/fuzzdb
    git pull
  else
    rm -r /usr/share/fuzzdb
    cd /usr/share
    git clone https://github.com/fuzzdb-project/fuzzdb.git fuzzdb
  fi
svn co --username guest --password "" https://svn.nmap.org/nmap /opt/nmap-svn
cd /opt/nmap-svn
./configure && make
/opt/nmap-svn/nmap -V
updatedb
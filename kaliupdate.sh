#This function shows which switches are needed to run the script.
usage(){
	echo "Use one or more of the following switches"
	echo " -p Upgrade packages"
	echo " -e Install select extra packages"
	echo " -s Install select tools from source"
	echo " -a All, same as -pes"
	echo " -h see this message"
}

#This option updates the packages installed and Metasploit.
package(){
	echo -e "\e[1;34m[*] Updating the entire system.\e[0m"
  apt-get update && apt-get upgrade -y
  echo -e "\e[1;34m[*]Updating MSF.\e[0m"
  /opt/metasploit/apps/pro/msf3/msfupdate
  cd /opt/metasploit/apps/pro/msf3/
  bundle install
}

#This installs extra packages I find most useful to add to a fresh Kali install.
extra(){
  echo -e "\e[1;34m[*]Adding some needed and nice packages.\e[0m"
  apt-get -y install autoconf terminator libssl-dev hostapd ipcalc isc-dhcp-server chromium

}

#This section installs software from source.
#Fuzzdb is downloaded from svn
#Nmap is build in the /opt/nmap-svn dir but it is not installed over the package, so you have to call it manually
#Aircrack-ng is downloaded and compiled and it is installed over the package, I've found airobase-ng to be buggy otherwise.

source(){
  echo -e "\e[1;34m[*]Making sure packages required to build things are there.\e[0m"
  apt-get -y install autoconf libssl-dev
  echo -e "\e[1;34m[*]Installing SVN version of fuzzdb in /usr/share/fuzzdb and keeping it updated.\e[0m"
  if [ -d /usr/share/fuzzdb ]; then
    cd /usr/share/fuzzdb
    svn up
  else
    echo -e "\e[1;34m[*]Fuzzdb not found, installing at /usr/share/fuzzdb.\e[0m"
    cd /usr/share
    svn co http://fuzzdb.googlecode.com/svn/trunk fuzzdb
  fi
  echo -e "\e[1;34m[*]Adding nmap-svn to /opt/nmap-svn.\e[0m"
  svn co --username guest --password "" https://svn.nmap.org/nmap /opt/nmap-svn
  cd /opt/nmap-svn
  ./configure && make
  /opt/nmap-svn/nmap -V
  echo "Installed in /opt/nmap-svn"
  echo -e "\e[1;34m[*]Updating aircrack-ng from SVN.\e[0m"
  if [ -d /opt/aircrack-ng-svn ]; then
    cd /opt/aircrack-ng-svn
    svn up
  else
    svn co http://svn.aircrack-ng.org/trunk/ /opt/aircrack-ng-svn
    cd /opt/aircrack-ng-svn
  fi
  make && make install
  airodump-ng-oui-update
  #Saying what happened:
  echo -e "\e[1;34m[*]Installed or updated Fuzzdb to /usr/share/fuzzdb.\e[0m"
  echo -e "\e[1;34m[*]Installed or updated nmap-svn to /opt/nmap-svn.\e[0m"
  echo -e "\e[1;34m[*]Downloaded svn version of aircrack-ng to /opt/aircrack-ng-svn and overwrote package with it.\e[0m"
  sleep 5
}

#This displays the usage info if you didn't put in a switch.
(($# )) || usage

#This is the main logic calling the proper functions based on the switches used.
while getopts "pesah" flag
do
  if [ "$flag" = "h" ]; then
  	usage
  elif [ "$flag" = "p" ]; then
  	package
  elif [ "$flag" = "e" ]; then
  	extra
  elif [ "$flag" = "s" ]; then
  	source
  elif [ "$flag" = "a" ]; then
  	package
  	extra
  	source
  else
  	usage
  fi
done
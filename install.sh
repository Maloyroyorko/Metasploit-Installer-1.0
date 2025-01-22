#!/bin/bash
RESET="\e[0m"
BOLD="\e[1m"
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
WHITE="\e[37m"

clear
apt update && apt upgrade -y
apt install figlet -y
clear
# Function to print a colorful responsive banner
print_banner() {
    # Get the terminal width
    terminal_width=$(tput cols)
    # Define the banner text
    banner_text="Script By Maloy Roy Orko"
    
    # Calculate the padding
    padding=$(( (terminal_width - ${#banner_text}) / 2 ))
    
    # Create the banner line
    banner_line=$(printf "%-${terminal_width}s" "=")
    
    # Print the banner
    echo -e "\e[1;34m${banner_line}\e[0m"  # Blue
echo -e ${RESET}
echo -e ${RED}
figlet "Metasploit"
echo -e ${RESET}
echo -e ${BLUE}
figlet "Installer"
echo -e ${RESET}

    printf "%${padding}s\e[1;32m%s\e[0m\n" "" "$banner_text"  # Green
    echo -e "\e[1;34m${banner_line}\e[0m"  # Blue
}

# Function to run a command and display its output
run_command() {

    echo -e "\e[1;33mRunning command: $1\e[0m"  # Yellow
    eval "$1"
sleep 5
    echo -e "\e[1;32mCommand completed.\e[0m"  # Green
}

# Print the banner
print_banner

# Example commands to run
run_command "pkg update && pkg upgrade -y -o Dpkg::Options::="--force-confnew""
run_command "pkg install wget -y"
run_command "pkg install curl -y"
run_command "pkg install sqlite -y"
run_command "pkg install ruby -y"
run_command "pkg install git -y"
run_command "pkg install -y binutils python autoconf bison clang coreutils findutils apr apr-util postgresql openssl readline libffi libgmp libpcap libsqlite libgrpc libtool libxml2 libxslt ncurses make ncurses-utils ncurses unzip zip tar termux-tools termux-elf-cleaner pkg-config git ruby -o Dpkg::Options::="--force-confnew""
run_command "python3 -m pip install requests"
if [ -d "${PREFIX}/opt/metasploit-framework" ]; then
  rm -rf ${PREFIX}/opt/metasploit-framework
fi
if [ ! -d "${PREFIX}/opt" ]; then
  mkdir ${PREFIX}/opt
fi
run_command "git clone https://github.com/rapid7/metasploit-framework.git --depth=1 ${PREFIX}/opt/metasploit-framework"
run_command "cd ${PREFIX}/opt/metasploit-framework
gem install bundler"
NOKOGIRI_VERSION=$(cat Gemfile.lock | grep -i nokogiri | sed 's/nokogiri [\(\)]/(/g' | cut -d ' ' -f 5 | grep -oP "(.).[[:digit:]][\w+]?[.].")
gem install nokogiri -v $NOKOGIRI_VERSION -- --with-cflags="-Wno-implicit-function-declaration -Wno-deprecated-declarations -Wno-incompatible-function-pointer-types" --use-system-libraries
bundle install
gem install actionpack
bundle update activesupport
bundle update --bundler
bundle install -j$(nproc --all)
ln -sf ${PREFIX}/opt/metasploit-framework/msfconsole ${PREFIX}/bin/
ln -sf ${PREFIX}/opt/metasploit-framework/msfvenom ${PREFIX}/bin/
ln -sf ${PREFIX}/opt/metasploit-framework/msfrpcd ${PREFIX}/bin/
termux-elf-cleaner ${PREFIX}/lib/ruby/gems/*/gems/pg-*/lib/pg_ext.so
run_command "gem update bundler"
run_command "gem install bundler"
run_command "bundle install --gemfile /data/data/com.termux/files/usr/opt/metasploit-framework/Gemfile"
echo -e ${RESET}
echo -e "${GREEN}Metasploit INSTALLED SUCCESSFULLY!"
echo -e ${RESET}
echo -e "${GREEN}Use ${RED}msfconsole${RED} to use Metasploit! "

#[root@NSCADVSBSTAP00 ~]# cat avkeyenroll.sh
# Date: 11 June 2026
# Author: Clueless
#!/usr/bin/expect

set timeout 30


# Get the first argument (VM name)
set vmname [lindex $argv 0]

# Spawn console with dynamic VM name
spawn /usr/local/bin/virtctl console $vmname
send "\r"

expect "login:"
send "sysad\r"

expect "Password:"
send "!QAZ2wsx#EDC4rfv\r"

send "id\r"

send "sudo su -\r"

expect -timeout 1 "*password:*"
send "!QAZ2wsx#EDC4rfv\r"

expect -timeout 1 "\[root@.*\]\#"
send "id\r"
expect -timeout 1 "uid*"

send "mokutil --import /opt/ds_agent/secureboot/DS20* << EOF\n123456\n123456\nEOF\r"
send "reboot\r"

# Wait for MOK screen
expect -nocase "Press any key to perform MOK management"
send "\r"

# Wait for MOK menu
expect -nocase "Perform MOK management"

# Down arrow to select "Enroll MOK"
send "\x1b\x5b\x42"

# Enter to confirm selection
send "\r"

# Down arrow to select "Continue"
send "\x1b\x5b\x42"
send "\x1b\x5b\x42"

# Enter to confirm "Continue"
send "\r"

send "\x1b\x5b\x42"
send "\r"


# Enter MOK password
send "123456\r"
send "\r"
send "\r"
expect -timeout 60 eof


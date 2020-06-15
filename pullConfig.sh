#!/usr/bin/expect -f

# set your variables
set timeout 8
set IPaddress [lindex $argv 0]
set Username "snoop"
set Password "snoop"
set Directory .

# log into devices and auth
spawn ssh -o "StrictHostKeyChecking no" $Username@$IPaddress
expect "Password: "
send "$Password\r"
expect ">"
send "term len 0\r"
expect ">"
send "en\r"
expect "Password: "
send "$Password\r"
expect "#"
send "sh run\r"

# start log file
log_file -a $Directory/rollback-config_$IPaddress.log
send_log "Start Config HOST: $IPaddress : [exec date]"
send_log "\n\n"

expect "#"
send_log "\n\n"
send "exit\r"
sleep 1
send_log "End Config HOST: $IPaddress : [exec date]"
send_log "\n\n"

exit


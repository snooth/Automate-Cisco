#!/usr/bin/expect -f

        # set your variables
        set timeout 8
        set IPaddress [lindex $argv 0]
        set Username "snoop"
        set Password "snoop"
        set Directory .

        # log your session
        log_file -a $Directory/change-session_$IPaddress.log
        send_log "Start Change HOST: $IPaddress @ [exec date] ###"
        send_log "\n\n"

        # log into devices and auth
        spawn ssh -o "StrictHostKeyChecking no" $Username@$IPaddress
        expect "Password: "
        send "$Password\r"
        expect ">"
        send "en\r"
        expect "Password: "
        send "$Password\r"
        expect "#"
        send "conf t\r"
        expect "(config)#"

        # this is where you change your ACL's to suite what you need. The following was the example I showed you.
        send "int g3\r"
        expect "(config-if)#"
        send "description asdfasdf\r"
        expect "(config-if)#"
        send "exit\r"
        expect "(config)#"
        send "exit\r"
        expect "#"
        send "wr mem\r"
        expect "#"
        send "term len 0\r"
        expect "#"
        send_log "End Config HOST: $IPaddress @ [exec date] ###"

        # this will run another show run to capture the new change
        send_log "Start NewConfig HOST: $IPaddress @ [exec date] "
        send "sh run\r" 
        send_log "\n\n"
        expect "#"
        send_log "End NewConfig HOST: $IPaddress @ [exec date] "
        send_log "\n\n"
        send "exit\r"
        sleep 1

exit


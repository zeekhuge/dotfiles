#!/bin/bash

function getIp () {
    get_interfaces ()  {
        echo -e $(ifconfig | grep "Link" | sed 's/^\(.*\)\s\+Link.*$/\1/')
    } 

    is_interface_connected () {
        local iface=$1
        (ifconfig ${iface} | grep -iq "inet addr") && echo 1 || echo 0
    }

    get_interface_ip () {
        local iface=$1
        echo $(ifconfig ${iface} | grep "inet addr" | sed 's/.*addr:\(.*\)\s\+\(Bcast.*$\|Mask.*$\)/\1/') 
    }

    local ifaces=$(get_interfaces)
    local output=""
    for nface in ${ifaces}; do
        if [ "$(is_interface_connected ${nface})" == "1" ]; then
            output+="${nface}\t\t$(get_interface_ip ${nface})\n"
        fi
    done
    if [ "$1" != "" ]; then
        echo -e ${output} | grep "$1" | sed 's/^.*\s\+\([0-9].*$\)/\1/'
    else
        echo -e ${output}
    fi

    unset get_interface_ip
    unset is_interface_connected
    unset get_interfaces
}

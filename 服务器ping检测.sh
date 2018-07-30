#!/bin/bash
#Created by XXXX
#set -x
while true
do
    list=(baidun.com)
    list_1=(地域)
    mail=XXX@XXX
    date=$(date -d "today" +"%Y-%m-%d-%H:%M:%S")
    i=0
    id=${#list[*]}
    while [ $i -lt $id ] 
    do
        if ping -c1 ${list[$i]} >/dev/null
        then
            echo  $date:服务器${list[$i]}能ping通。
        else
            if curl -m 10  ${list[$i]} > /dev/null
            then
                echo  $date:服务器${list[$i]} ping不通,能打开网页。
            else
                echo  "您好，据系统监测服务器${list_1[$i]}不能访问且ping不通,请及时处理!故障发生时间：$date"|mail -s "服务器${list_1[$i]}不能连接! 故障发生时间：$date" $mail
                until
                    date=$(date -d "today" +"%Y-%m-%d-%H:%M:%S")
                    ping -c1 ${list[$i]} >/dev/null && echo "恭喜！服务器${list_1[$i]}已恢复正常，恢复时间：$date"|mail -s "服务器${list_1[$i]}已恢复正常! 恢复时间：$date" $mail
                do
                    sleep 5
                done
            fi
        fi
        let i++
    done
    sleep 60
done

<p align="center">
  <a href="https://dev.to/vumdao">
    <img alt="Use GoAccess To Analyze HAProxy Logs" src="https://github.com/vumdao/bash/blob/master/codility/cover.jpg?raw=true" width="500" />
  </a>
</p>
<h1 align="center">
  <div><b>Using Bash Shell To Parsing Apache Logs</b></div>
</h1>

## - Using bash shell (version 5.0) to parsing Apache logs to print statistics on requests per day and requests per IP. Hackerrank code
**Tasks**: Create Bash script to parse and analyze Apache access log file. Path of the log file is the input of the script (LOG_FILE) eg. `solution.sh /var/log/access.log`
You need to output two statistics, limited to the top 10 results and sorted numerically by quantity and from highest to lowest value without leading blanks and that lines with greater key values appear earlier in the output instead of later.
Your script should output both results one after other, and each row must have QUANTITY FILED format, with either space or tabulator as separator.

- The Apache log has the folloing example content:
```
172.19.0.100 - - [15/Feb/2020:22:32:02 +0000] "GET /index HTTP/1.1" 200 14034 "-" "Mozilla/5.0 (compatible; SemrushBot/6~bl; +http://www.semrush.com/bot.html)" "172.19.0.4"
172.19.0.100 - - [16/Feb/2020:22:31:32 +0000] "GET /site HTTP/1.1" 200 36565 "https://command-not-found.com/curl" "Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)" "172.19.0.3"
172.19.0.101 - - [16/Feb/2020:22:30:10 +0000] "GET /credits HTTP/1.1" 200 31067 "-" "Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)" "172.19.0.2"
172.19.0.102 - - [17/Feb/2020:22:30:10 +0000] "GET /index HTTP/1.1" 200 31067 "-" "Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)" "172.19.0.2"
172.19.0.100 - - [18/Feb/2020:22:35:10 +0000] "GET /index HTTP/1.1" 200 31067 "-" "Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)" "172.19.0.2"
```

- Expected result:

```
2 16/Feb/2020
1 18/Feb/2020
1 17/Feb/2020
1 15/Feb/2020

3 172.19.0.100
1 172.19.0.102
1 172.19.0.101
```

- Script starts with:

```
#!/usr/bin/env bash
LOG_FILE="$1"
```

- Write your own solution or referenece here

https://github.com/vumdao/bash/blob/master/codility/solution.sh
```
#!/usr/bin/env bash
LOG_FILE="$1"

function request_per_day() {
    declare -A day_array
    while read line; do
        day=$(echo "$line" | sed 's/.*\[//g;s/].*//g;s/:.*//g')
        if [[ -v day_array[$day] ]]; then
            day_array[$day]=$((day_array[$day]+1))
        else
            day_array[$day]=1
        fi
    done < $LOG_FILE

    for day in ${!day_array[@]}; do echo ${day_array[$day]} $day; done | sort -rn | head -10
}

function request_per_ip() {
    declare -A ip_array
    while read line; do
        ip=$(echo $line | awk '{print $1}')
        if [[ -v ip_array[$ip] ]]; then
            ip_array[$ip]=$((ip_array[$ip]+1))
        else
            ip_array[$ip]=1
        fi
    done < $LOG_FILE

    for ip in ${!ip_array[@]}; do echo ${ip_array[$ip]} $ip; done | sort -rn | head -10
}

request_per_day
echo ""
request_per_ip
```

<h3 align="center">
  <a href="https://dev.to/vumdao">:stars: Blog</a>
  <span> · </span>
  <a href="https://github.com/vumdao/">Github</a>
  <span> · </span>
  <a href="https://vumdao.hashnode.dev/">Web</a>
  <span> · </span>
  <a href="https://www.linkedin.com/in/vu-dao-9280ab43/">Linkedin</a>
  <span> · </span>
  <a href="https://www.linkedin.com/groups/12488649/">Group</a>
  <span> · </span>
  <a href="https://www.facebook.com/CloudOpz-104917804863956">Page</a>
  <span> · </span>
  <a href="https://twitter.com/VuDao81124667">Twitter :stars:</a>
</h3>
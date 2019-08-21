#!/bin/bash
# Daily backup at 1A.M: Crontab: 0     1 * * *

mysql_host=rdb
mysql_user=admin
mysql_password=password

# Location to place backups
backup_dir="/mnt/storage/backup/"

#String to append to the name of the backup files
backup_date=`date +%Y-%m-%d`

#Numbers of days you want to keep copies of your databases
number_of_days=7

#make dir for date of backup
backup_dir_each_day=$backup_dir$backup_date/
mkdir $backup_dir_each_day

databases=`mysql -h $mysql_host -u $mysql_user -p"$mysql_password" -e 'show databases;'`
for i in $databases; do
    if [ "$i" != "information_schema" ] && [ "$i" != "Database" ] &&  [ "$i" != "performance_schema" ]  &&  [ "$i" != "mysql" ];  then
       dump_file=$backup_dir_each_day$i\_$backup_date.gz
       echo Dumping $i to $dump_file
       mysqldump -h $mysql_host -u $mysql_user -p"$mysql_password" $i | gzip -c > $dump_file
    fi
done

find $backup_dir -type f -prune -mtime +$number_of_days -exec rm -f {} \;
find $backup_dir -type d -empty -exec rmdir {} \;
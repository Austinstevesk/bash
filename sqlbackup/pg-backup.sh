#!/bin/bash
# Postgres daily backup

# Location to place backups.
backup_dir="/mnt/storage/backup/"
mkdir -p $backup_dir

# String to append to the name of the backup files
backup_date=`date +%Y-%m-%d`

# Numbers of days you want to keep copies of your databases
number_of_days=1

# make dir for date of backup   
backup_dir_each_day=$backup_dir$backup_date/
mkdir $backup_dir_each_day

source /var/opt/.db.env

databases=`psql -l -t | grep -v "backup_\|bella\|test\|backup\|configuration\|postgres" | cut -d'|' -f1 | sed -e 's/ //g' -e '/^$/d'`

for i in $databases; do
	if [ "$i" != "template0" ] && [ "$i" != "template1" ];  then
		dump_file=$backup_dir_each_day$i\_$backup_date.gz
		echo Dumping $i to $dump_file 
		pg_dump -E UTF-8  $i | gzip -c > $dump_file
	fi
done

# Backup to S3
/usr/bin/aws s3 cp $backup_dir_each_day s3://infra-backups-databases/$(hostname)/$backup_date/ --recursive

find $backup_dir -type f -prune -mtime +$number_of_days -exec rm -f {} \;
find $backup_dir -type d -empty -exec rmdir {} \;

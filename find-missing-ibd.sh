#!/bin/bash

#this is a test tool to find the InnoDB tables which don't have .ibd file
#it also dumps the innodb files into separate sql files

MYUSER=$1
MYPASS=$2

MYDATA=/var/lib/mysql
SAVEPATH=/root
OUTPUT=$SAVEPATH/innoproblem.txt

MYAUTH="--user=$MZUSER --password=$MYPASS"

MYCMD="mysql $MYAUTH"

echo "Getting databases"
#MYQRY="$MYCMD --batch --skip-column-names --execute=\"SELECT DISTINCT TABLE_SCHEMA, TABLE_NAME FROM TABLES WHERE ENGINE='InnoDB';\" INFORMATION_SCHEMA"
echo "List of problems" > $OUTPUT

$MYCMD --batch --skip-column-names --execute="SELECT DISTINCT TABLE_SCHEMA, TABLE_NAME FROM TABLES WHERE ENGINE='InnoDB';" INFORMATION_SCHEMA | while read db table; do
    filepath="$MYDATA/$db/$table"
    echo -n "working on $db.$table... "
    echo -n "dumping... "
    mysqldump $MYAUTH $db $table >$SAVEPATH/$db.$table.sql || { echo "Problem dumping $db.$table" >> $OUTPUT; }
    echo -n "logging... "
    [ -f $filepath.ibd ] || { echo "$filepath.ibd" >> $OUTPUT; }
    echo "done"
done

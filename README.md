# find-missing-ibd
This is a little tool to find thos InnoDB tables which don't have separate ibd file (useful if you want to remove large ibdata1)

It was made to find possible problems before removing the ibdata1 file which grew incredibly huge

You can give mysql authentication information (user and password) as the first and second argument
or you can hardcode this information into the script after you checked it out (don't push it back, please :))

Also you can configure
- where to find the tables in the filesystem
- where to put the dumps from the InnoDB tables
- where to log problems with the InnoDB tables (if mysqldump returns with error or if ibd file is not there)

Thanks if you contribute

#the workplace is cygdrive/e/projects/Music

# unzip *_down.log.tar.gz into *_down.log
for f in ../Music/*_down.log.tar.gz
do
 echo "Processing $f"
 tar -xvzf $f -O > "${f%.tar.gz}" #only take filename before .tar.gz, which is '20170301_down', the extension is .log
done

#move all unzipped down.log into Music/download/ file 
mv *_down.log ../Music/download/

# go to the download file workplace, then append file_name to each row (will be used for date)
cd /cygdrive/e/projects/Music/download/

for f in ../download/*_down.log
do
 echo "Processing $f"
 awk -v var="$f" '{print $0,"\t",var}' $f > ${f}.fn
done

# cat all log with filename to one file
#no need to create all_download_1.log.fn before, if it is not exist, it will be generated once run the file
cat ../download/*log.fn > ../download/all_download_1.log.fn

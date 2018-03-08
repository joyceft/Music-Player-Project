#the workplace is cygdrive/e/projects/Music

# unzip *_down.log.tar.gz into *_down.log
for f in ../Music/*_down.log.tar.gz
do
 echo "Processing $f"
 tar -xvzf $f -O > "${f%.tar.gz}"
done

#move all unzipped down.log into Music/download/ file 
mv *_down.log ../Music/download/

# go to the download file workplace, then append file_name to each row (will be used for date)
cd /cygdrive/e/projects/Music/download/

for f in *.log
do
 echo "Processing $f"
 awk -v var="$f" '{print $0,"\t",var}' $f > ${f}.fn
done

# cat all log with filename to one file

cat ../Music/download/*.log.fn > ../d/MusicFile/all_download.log.fn

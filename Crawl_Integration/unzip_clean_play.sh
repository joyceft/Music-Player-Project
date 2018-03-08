# unzip uid
#copy uids.gz as all_uid.txt.gz
#cp ../Music/3_1.uids.gz ../Music/all_uid.txt.gz
#gunzip ../Music/all_uid.txt.gz

# unzip play log
for f in ../Music/*_play.log.tar.gz
do
 echo "Processing $f"
 tar -xvzf $f 
done

mv *_play.log ../Music/play/
cp ../Music/*_play.log.gz ../Music/play/ 
gunzip ../Music/play/*.gz

# append file_name to each row (will be used for date)
cd ../Music/play/
for f in *.log
do
 echo "rename Processing $f"
 awk -v var="$f" '{print $0,"\t",var}' $f > ${f}.fn
done

# cat all log with filename to one file
cat ../Music/play/*.log.fn > ../Music/all_play.log.fn

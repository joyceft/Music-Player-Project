# unzip uid

#cp ../Music/3_1.uids.gz ../Music/all_uid.txt.gz

#gunzip ../Music/all_uid.txt.gz


# unzip download log

for f in ../Music/*_down.log.tar.gz

do

 echo "Processing $f"

 tar -xvzf $f 

done



mv *_search.log ../Music/download/



cp ../Music/*_down.log.gz ../Music/download/ 

gunzip ../Music/search/*.gz



# append file_name to each row (will be used for date)
cd ../Music/download/

for f in *.log

do

 echo "Processing $f"

 awk -v var="$f" '{print $0,"\t",var}' $f > ${f}.fn

done



# cat all log with filename to one file

cat ../Music/download/*.log.fn > ../Music/all_download.log.fn
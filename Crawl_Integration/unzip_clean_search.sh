###unzip and integration search file
###the first workplace is under e/projects/Music
for f in ../Music/*_search.log.tar.gz
do
  echo "Processing unzip $f"
  tar -xvzf $f -O > "${f%.tar.gz}"
done

#move all unzipped search.log into search file
mv *_search.log ../Music/search/

#now the workplace changed to e/projects/Music/search, this .sh should also go to search file, so run the above first, then run the below.
#add filename as a new variable to each search.log

#cd /cygdrive/e/projects/Music/search/

for f in ../search/*_search.log
do
  echo "rename processing $f"
  awk -v var="$f" '{print $0, "\t", var}' $f > ${f}.fn
done

#cat all search.log with its filename to a whole file
echo "integrate to one search.log"
cat ../search/*log.fn > ../search/all_search_1.log.fn

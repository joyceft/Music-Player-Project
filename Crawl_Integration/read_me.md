Using BeautifulSoup to crawl user data, including user_log, user_play, user_search, user_download from the website from 20170301 to 20170512

Then, integrated the same type files from all dates into a whole file, with their filename(which contains dates) as added column 
## Note
Since I use Windows system, Linux is needed for run .sh. Using cygwin
**cygwin basic**
1. set the workplace as where you .sh is, using the following format
- cd /cygdrive/d/xxx
2. since windows use different separation(\r) from Linux(\t), use **dos2unix** to convert .sh, so that cygwin can read
- dos2unix xxx.sh
3. Linux is not that difficult :)

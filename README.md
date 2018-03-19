# Music-Player-Project
Based on three types of log data, including **user's search**, **download** and **play** records in MusicBox App through 03/01/2017 to 05/12/2017, analyze their behavior patterns and trends, churn prediction to provide more business insights for MusicBox. 

[Data can be found in:] (https://bittigermusicplayerdata.s3-us-west-2.amazonaws.com/list.html)

## Dataset Description(Ideas after self cleaning and exploration)
### 1.Play.log(17G)
- user_id (numeric) :5 digits-11digits
- device (categoric) :ar/ip
- song_id (numeric): 1 digit - 15 digits
- song_type (categoric) : 0/1/2
- song_name(object) : Chinese/Japanese character
- singer(object) : Chinese/Japanese character
- play_time(numeric): records as single play records(not cumulative)most dirty data and need lots of effort to clean up
- song_length(numeric): records in seconds
- paid_flag (categoric): 0/1
- file_name(object): mannually extracted from file_name, added as a new column when integrating file, as the record day
### 2. search.log(11G)
- user_id
- device
- song_id
- search time
- url
### 3. download.log(7G)
- user_id
- song_id
- song_name
- song_type
- singer

## Business Goal
Based on different user behavior log, finding the user act patterns and trends, creating Churn window to analyze and predict user churn behavior, aimed to prevent potential churn and providing applicable business insights and recommendations.

## Data Processing
### 1. Download & Integration(Shell&Python)
- Crawled and downloaded raw data files using BeautifulSoup, requests libraries 
- Unzipped, added file_name to each file as new variable indicating the date information by writing Shellscript, ran in cgywin
- Intgrated all files of one type into a entire file by writing Shellscript, ran in cgywin
### 2. Clean & Imputation & Extraction(Spark&Python)
- Filtered mislocation fields when parsing each row into Spark by fields length, fields datatypes
- Filtered extremely large play_time and frequency, based on the avereage and range of other music apps daily play time.(average play_time > 8h/day)
- Filtered abnormal song_length and impute missing song_length with average play_time in the entire period
- Extracted variables from each type log, mainly useful for churn prediction. Dropped song_name, singer, etc to reduce dataset size, reduce redundency and save analysis costs.
- **Downsampling**
purpose: shrink dataset size, balance churn/active rate





## Some notes for myself
1.there are three types of file, including search, download, play. Most file name contains date information, so this variable needs to
be record and add as a new column.

2. Notice for abnormal data:
i.e.
**play** file: play_time means how many seconds this song was played. song_length means how many seconds the song is, so
any song with 0 song_length or play_time>song_length needs to be dropped.
**play** file: after group by userid, we can count how many songs they have listened, some abnormal records need to be eliminated.

3.download can be down in request and beautifulSoup, unzip can be down by shell file using **cgywin**.

cd/cygdrive/e/projects/Music #go to the work directory

./unzip_clean_play.sh

Since I use Windows, the separate is \n, convert it into what Linux can read
- using
sed -i 's/\r//' xxxx.sh

or

dos2unix xxx.sh

before actually run unzip.sh
-after install Spark, use pyspark as notebook, but find libs of python such as numpy, pandas are not accessible. so install them under the Python file(using cmd)

pip install numpy

**commend**
cd /cygdrive/d
./xxx.sh

4.Install Spark
[how to install spark] (https://medium.com/@GalarnykMichael/install-spark-on-windows-pyspark-4498a5d8d66c)

If using DataFrame in spark, it really takes long time to execute.. so try rdd.
### Explore play.fn
Using 'unzip_clean_play.sh' to combine all daily log data into a whole file, adding the filename(which contains the date) as new column. The combined play.log.fn contains features as:

1.Since we are aiming to analyze and predict churn rate, informationa about songs are of little use. So to accelerate our calculation, we first drop those columns(song_id, song_type, song_name, singer)
2.Dealing with abnormal data

save unique user_id list to memory, when 
machine users: play.count(<95%)

**churn label**
**down sampling** 
try from smaller, 30%, 40%, if not improve, 

**Note 3.2**
count of song_play time, total time, distinct count


20170339 ->20170329
20170309-20170329中间没有
其余按uid, date, play_time, song_length<<看
pandas data cleaning, song_length = 0, play_time !=0 >>说明song is real,



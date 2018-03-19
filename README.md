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
- device: users are in multiple platform, one user has both play records in andriod and IPhone device.
### 3.Feature Generation
- time-window =[1,3,7,14,21,30], snapshot date = 4/29
- frequency: count of play/search/download records within each time-window
- recency: last day of play/search/download action
- play_complete degree: average play complete degree
- dummy device
 
### 4. Prediction Model
- Applied multiple binary classification models in feature_data, tried default model first, then applied **RandomizedSearchCV** and **GridSearchCV** to find the best parameter. Models including:
- Decision Tree
- Random Forest
- AdaBoost
- Evaluated model preformance by various preformance matrix, confusion matrix, ROC curve.

### Improvements & Business Insights
With more available information, we can have better idea of users, and better predict their behaviors based on models.
1. Refine churn type: use different threshold define churn(key action, time_window, etc), according to specific business targets.
2. User portfolios: When download MusicBox App or registered as new user, basic information of users can be obtained. Including their region, age, gender, membership, purchase history, etc, whether they have other connected social media accounts, etc.
3. User segmentation: with their demographical information, behavior records to segment user, customized analytical models and recommendation methods
4. Technical Support: During EDA, found huge imbalance with different device. The play_time of IPhone user is much more fluctuated than Andriod and Both device holders. More efforts should be down to improve and update IPhone device, such as API, latency, version, operation, etc.


















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


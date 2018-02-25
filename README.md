# Music-Player-Project
Based on user's searching, downloading and playing records in MusicBox through 03/01/2017 to 05/12/2017, analysis their patterns and find the churn rate and predict. 

[Data can be found in:](https://bittigermusicplayerdata.s3-us-west-2.amazonaws.com/list.html)

## Some notes for myself
1.there are three types of file, including search, download, play. Most file name contains date information, so this variable needs to
be record and add as a new column.

2. Notice for abnormal data:
i.e.
**play** file: play_time means how many seconds this song was played. song_length means how many seconds the song is, so
any song with 0 song_length or play_time>song_length needs to be dropped.
**play** file: after group by userid, we can count how many songs they have listened, some abnormal records need to be eliminated.

3.download can be down in request and beautifulSoup, unzip can be down by shell file using cgywin.

Since I use Windows, the separate is \n, convert it into what Linux can read
- using
sed -i 's/\r$$//' xxxx.sh
-after install Spark, use pyspark as notebook, but find libs of python such as numpy, pandas are not accessible. so install them under the Python file(using cmd)
pip install numpy
4.Install Spark
[how to install spark](https://medium.com/@GalarnykMichael/install-spark-on-windows-pyspark-4498a5d8d66c)


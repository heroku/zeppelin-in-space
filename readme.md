### zeppelin-in-space

Apache Zeppelin notebooks for Spark.

requires: a private space with dns-discovery enabled, and an spark-in-space cluster running (heroku/spark-in-space)


```
app=zepplin-in-space
spark_cluster_app=spark-in-space
spark_cluster_space=a-space
git clone https://github.com/heroku/zeppelin-in-space
cd zeppelin-in-space
heroku create $app --space $spark_cluster_space
heroku sudo labs:enable dyno-run-inside -a $app
heroku buildpacks:add http://github.com/kr/heroku-buildpack-inline.git -a $app
heroku buildpacks:add https://github.com/heroku/heroku-buildpack-jvm-common.git -a $app
heroku addons:create bucketeer -a $app
heroku config:set SPARK_INTERPRETER_APPS=$spark_cluster_app -a $app
heroku config:set SPARK_MASTERS=1 -a $app
git push heroku master
heroku scale web=1:private-l
```

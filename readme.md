### zeppelin-in-space

Heroku Button deploy of Apache Zeppelin notebooks for Apache Spark and Postgres

requires: a private space with dns-discovery enabled, and either a spark-in-space cluster running (heroku/spark-in-space)
or heroku postgres attached.

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/heroku/zeppelin-in-space)

Note: The rest of this readme assumes you have set your app name as `$app`, and your spark cluster app name as `$spark` in your shell, like so 

```
app=my-zeppelin-app
spark=my-spark-in-space-app
```

When performing the button app creation you should set the `SPARK_INTERPRETER_APPS` to `$spark`.

Once your button deploy completes, you can tail the logs and see the zeppelin and web process come online.

```
heroku logs -t -a $app
```

You can open the zeppelin web ui by running `heroku open -a $app`. The default basic auth creds are `zeppelin:space`. If
you set different credentials during app creation use those credentials.

Once you see the zeppelin ui, click `Create new note`, and name the note. You will be taken to the UI for the note.

Enter the following text, and then hit Shift+Enter to run the notebook.

```
sc.parallelize(1 to 10000).reduce(_+_)
```

The first run will take several seconds to spin up a spark driver and connect to your spark cluster.

Edit the text to read as follows, and then hit Shift+Enter to run the notebook again. You should see the result very rapidly.

```
sc.parallelize(1 to 12345).reduce(_+_)
```

You can also look at the spark cluster ui to see what is runing. See the spark-in-space docs on how to look at the ui.

### adding more spark clusters

To add more spark-in-space clusters to the zeppelin interpreter list, simply set the `SPARK_INTERPRETER_APPS`.

```
heroku config:set SPARK_INTERPRETER_APPS=my-spark-cluster,my-other-spark-cluster -a $app

```

You can set the binding for your previously created notebook by clicking the black settings icon in the top right corner.


### adding postgres databases

If you attach existing heroku postgres databases to your zeppelin-in-space app you can create notebook for postgres.

Note: The following assumes you have set your postgres app name as `$pg`.

```
heroku addons -a $pg
#find the database name that you want to attach and set it as a shell var
database=some-heroku-haiku-12345
heroku addons:attach $database -a $app --as FIRST_DB
heroku config:set DATABASE_INTERPRETER_URLS=FIRST_DB_DATABASE_URL -a $app
```

Once the zeppelin app restarts, create a new note, enter the following and execute it.

```
%psql
select * from pg_stat_activity;
```

You should see the query result.

To add more postgres databases, follow the same procedure, and append them in a comma seperated manner to `DATABASE_INTERPRETER_URLS`

```
heroku config:set DATABASE_INTERPRETER_URLS=FIRST_DB_DATABASE_URL,SOMEOTHER_DATABASE_URL -a $app
```


### S3 Storage

By default the button deploy uses S3 via the bucketeer addon, created with the `--as ZEPPELIN_S3` option.

Zeppelin itself and the spark configuration generated for this app substitutes in the bucket and credentials provided by that addon, 
so reads and writes by zeppelin and any spark jobs to S3 will use those credentials.

If you want to bring your own S3 bucket, simply remove the bucketeer addon and manually set the configuration.


```
heroku addons:remove bucketeer -a $app
heroku config:set ZEPPELIN_S3_BUCKET_NAME=<the bucket you want to store notebooks in> -a $app
heroku config:set ZEPPELIN_S3_AWS_ACCESS_KEY_ID=<creds that can read and write your buckets> -a $app
heroku config:set ZEPPELIN_S3_AWS_SECRET_KEY=<creds that can read and write your buckets> -a $app
```

Any spark code you run from this app wil have the spark context configured with those credentials, so you should be able to access
`s3n://` and `s3a://` urls.


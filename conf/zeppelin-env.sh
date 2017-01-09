#!/usr/bn/env bash

export ZEPPELIN_NOTEBOOK_S3_BUCKET=$ZEPPELIN_S3_BUCKET_NAME
export ZEPPELIN_NOTEBOOK_S3_USER=zeppelin-notebook
export AWS_ACCESS_KEY_ID=$ZEPPELIN_S3_AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=$ZEPPELIN_S3_AWS_SECRET_ACCESS_KEY
# Use the port allocated by the Heroku runtime
export ZEPPELIN_PORT=$PORT
export SPARK_LOCAL_IP=$HEROKU_PRIVATE_IP
export SPARK_PUBLIC_DNS=$HEROKU_DNS_DYNO_NAME
export SPARK_HOME=/app/spark-home
export SPARK_SUBMIT_OPTIONS='--jars=/app/spark-home/lib/hadoop-aws-shaded.jar,/app/spark-home/lib/hadoop-lzo.jar'
export PYTHONHASHSEED=random
export PYTHONHOME=/app/.heroku/python
export PYTHONPATH=/app/
export PYTHONUNBUFFERED=true
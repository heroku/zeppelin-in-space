### zepplin-in-space


```
app=zepplin-in-space
heroku sudo labs:enable dyno-run-inside -a $app
heroku buildpacks:add http://github.com/kr/heroku-buildpack-inline.git -a $app
heroku buildpacks:add https://github.com/heroku/heroku-buildpack-jvm-common.git -a $app
heroku addons:create bucketeer -a $app

```

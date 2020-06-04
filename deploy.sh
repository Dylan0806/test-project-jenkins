#!/usr/bin/env bash
#编译加部署

#需要配置如下参数
# 项目路径,再Execute Shell中配置项目路径,pwd可以获得该项目路径
# export PROJ_PATH=这个jenkins任务再部署机器上的路径

killDemoProject()
{
  pid=`ps -ef | grep demo-0.0.1-SNAPSHOT.jar | grep -v grep |awk '{print $2}'`
  echo "Springboot Application id : $pid"
  if [ "pid" = "" ];
  then
    echo "no Springboot Application is alive"
  else
    kill -9 $pid
  fi
}

cd $PROJ_PATH/demo
mvn clean package -Dmaven.test.skip=true

#调用上面构建的函数
killDemoProject

cd target
nohup java -jar demo-0.0.1-SNAPSHOT.jar > console.log &
#tail -1000f console.log
echo Springboot application deploy complete
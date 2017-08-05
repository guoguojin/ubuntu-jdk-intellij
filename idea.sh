#!/bin/bash

docker run -dit --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $HOME/develop:/home/user/code -v $HOME/.IntelliJIdea2017.2-docker:/home/user/.IntelliJIdea2017.2 --name=idea guoguojin/ubuntu-jdk-intellij:2017.2.1
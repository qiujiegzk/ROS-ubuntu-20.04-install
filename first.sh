#!/bin/bash
echo "欢迎使用一键ros轻松装"
str=$(pwd)



sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo sh -c '. /etc/lsb-release && echo "deb http://mirrors.tuna.tsinghua.edu.cn/ros/ubuntu/ `lsb_release -cs` main" > /etc/apt/sources.list.d/ros-latest.list'
echo "添加源成功ok"
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
sudo apt-get update
sudo apt-get install ros-noetic-desktop-full 
apt-get install python3-rosdep
cd $str/rosdistro-master/rosdep/sources.list.d/
sed -i d 20-default.list
sudo clear



echo "20-default.list文件展示"
echo "# os-specific listings first"  >> 20-default.list
echo "yaml file://$str/rosdistro-master/rosdep/osx-homebrew.yaml osx " >> 20-default.list
echo "# generic " >> 20-default.list
echo "yaml file://$str/rosdistro-master/rosdep/base.yaml" >> 20-default.list
echo "yaml file://$str/rosdistro-master/rosdep/python.yaml" >> 20-default.list
echo "yaml file://$str/rosdistro-master/rosdep/ruby.yaml" >> 20-default.list
echo "gbpdistro file://$str/rosdistro-master/releases/fuerte.yaml fuerte" >> 20-default.list
echo "# newer distributions (Groovy, Hydro, ...) must not be listed anymore, they are being fetched from the rosdistro index.yaml instead" >> 20-default.list
cat -n 20-default.list
read -p "请确认路径名称是否正确（任意键，不正确也会继续LOL）：" x


sed '72d' /usr/lib/python3/dist-packages/rosdep2/sources_list.py
sed -i "72c DEFAULT_SOURCES_LIST_URL = 'file://$str/rosdistro-master/rosdep/sources.list.d/20-default.list'" /usr/lib/python3/dist-packages/rosdep2/sources_list.py

sed '39d' /usr/lib/python3/dist-packages/rosdep2/rep3.py
sed -i "39c REP3_TARGETS_URL = 'file://$str/rosdistro-master/releases/targets.yaml'" /usr/lib/python3/dist-packages/rosdep2/rep3.py

sed '68d' /usr/lib/python3/dist-packages/rosdistro/__init__.py
sed -i "68c DEFAULT_INDEX_URL = 'file://$str/rosdistro-master/index-v4.yaml'" /usr/lib/python3/dist-packages/rosdistro/__init__.py

sudo rosdep init
sudo rosdep update

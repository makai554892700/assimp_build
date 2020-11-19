# assimp编译项目，[参考](https://blog.csdn.net/camellhf/article/details/78065622)
* win/\*.bat mac/\*.sh 等文件为编译assimp的文件，分别于windows、macos下运行
* 运行前需下载assimp源码并切至 assimp_5.0_release 分支
	
		git clone --depth=1 https://github.com/assimp/assimp.git
		git checkout assimp_5.0_release

* 修改 ANDROID_PATH/NDK_PATH/CMAKE_PATH 变量，运行 .bat/.sh 文件即可



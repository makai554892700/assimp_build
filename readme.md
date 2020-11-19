# assimp编译项目，[参考](https://blog.csdn.net/camellhf/article/details/78065622)
* build_assimp_v7a.bat 等文件为编译assimp的文件，于windows下运行。
* 运行前需下载assimp源码并切至 assimp_5.0_release 分支
	
		git clone --depth=1 https://github.com/assimp/assimp.git
		git checkout assimp_5.0_release

* 将bat文件复制至assimp文件夹，然后修改 ANDROID_PATH/NDK_PATH/CMAKE_PATH 变量。



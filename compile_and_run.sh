#!/bin/bash
# BuildAndRun.sh
# 编译并运行java代码

# 命令行传入的第一个参数，就是要进行编译运行的java代码文件名
file=$1

# 根据文件名来获取生成的class名称
class=$(echo $file | awk -F '.' '{print $1}')

# 生成的包
package=$(head -1 Test.java | sed 's/package \(.*\);/\1/')

echo "开始编译，请等待!!!"
echo "------------------------------------"

# 编译，并指定生成的class文件保存在当前目录
javac -d . $file

if [ $? -eq 0 ]; then
    echo "编译成功, 准备运行!!!"
    echo "------------------------------------"

    # 判断是否生成了package目录，如果生成了package目录，就要修改class变量
    if [ -e $package ]; then
        class=$package.$class
    fi

    # 运行
    java $class

    if [ $? -eq 0 ]; then
        echo "------------------------------------"
        echo "运行完毕!!!"
    else
        echo "------------------------------------"
        echo "运行时出错!!!"
    fi
else 
    echo "------------------------------------"
    echo "编译时出现错误!!!"
fi

# 如果生成了package目录，那么生成的class文件就在该目录中，删除所有class文件
if [ -e $package ]; then
    rm -rf $package 
else
    # 未生成package目录，删除当前目录下所有的*.class文件
    rm -f *.class
fi


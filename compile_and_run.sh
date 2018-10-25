#!/bin/bash
# BuildAndRun.sh
# 编译并运行java代码

# 命令行传入的第一个参数，就是要进行编译运行的java代码文件名
file=$1

# 根据文件名来获取生成的class名称
class=$(echo $file | awk -F '.' '{print $1}')

echo "开始编译，请等待!!!"
echo "------------------------------------"

# 编译
javac $file

if [ $? -eq 0 ]; then
    echo "编译成功, 准备运行!!!"
    echo "------------------------------------"

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


# 删除刚刚生成的那个class文件，防止某次编译失败，但是执行了之前成功编译出的class文件。
if [ -f $class.class ]; then
    rm -f $class.class
fi
#!/bin/bash
echo "auto cp test data"
echo "author : xielw"

#获得随机数返回值，shell函数里算出随机数后，更新该值
function random()
{
    min=$1;
    max=$2-$1;
    num=$(date +%s);
    ((retnum=num%max+min));
    #进行求余数运算即可
    echo $retnum;
    #这里通过echo 打印出来值，然后获得函数的，stdout就可以获得值
    #还有一种返回，定义全价变量，然后函数改下内容，外面读取
}

#随机拷贝测试数据
function cp_test_data()
{
    echo "开始拷贝数据"
    
    day=`date +%d`
    month=`date +%m`
    year=`date +%Y`
    hour=`date +%H`

	target="${year}-${month}-${day}"
	if [ ! -d "$target" ]; then 
		mkdir "$target" 
    fi

    oldday="2015-01-1$(random 1 5)"
	oldhour=$(random 10 22)

    #拷贝文件
    echo "拷贝文件"
    `cp ./$oldday/*${oldhour}_* ./$target/ -r` 

    #重命名文件
    #echo "ls ./$target/*${oldhour}_* | grep -v "${target}" | while read line"
    ls ./$target/*${oldhour}_* | grep -v "_${target}" | while read line
    do
        f1=$line
        f2=${line//${oldday}\ ${oldhour}/${target}\ ${hour}}
        echo "$f1 $f2"
        mv "$f1" "$f2"
        sed -i "s/${oldday/-01-/-1-}/$target/g" "$f2"
        sed -i 's/8BF/AEF/g' "$f2"
    done

    echo "完成拷贝数据"
}


while true
do
    target=`date +%Y-%m-%d`
    hour=`date +%H`
    if [ $hour -ge 9 ];
    then
        existfiles=`ls ./${target}/*| grep "${target}\ ${hour}"|wc -l`
        echo "ls ./${target}/*| grep "${target}\ ${hour}"|wc -l"
        echo $existfiles
        if [ $existfiles -eq 0 ]; then
            cp_test_data
        fi
        sleep "300s"
    fi
done

#!/bin/sh
 
#写个随机函数，调用方法random min max 
#在min 与 max直接获得随机整数
#copyright chengmo QQ:8292669
 
 
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

out=$(random $1 $2)
echo $out

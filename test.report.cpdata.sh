#!/bin/bash
#输入日期
OLDDATE=$1
NEWDATE=$2
#拷贝文件
cp ./$OLDDATE/ ./$NEWDATE/ -r
#删除垃圾文件
rm ./$NEWDATE/processed.info
#重命名
ls ./$NEWDATE | while read line
do
    f1=$line
    f2=${f1//$OLDDATE/$NEWDATE}
    echo "$NEWDATE/$f1 $NEWDATE/$f2"
    mv $PWD/$NEWDATE/"$f1" $PWD/$NEWDATE/"$f2"
    sed -i "s/${OLDDATE/-01-/-1-}/$NEWDATE/g" $PWD/$NEWDATE/"$f2"
done

#!/bin/bash

ACCESS=`head -n 1 ./ftp.conf`
HOST=`tail -n 1 ./ftp.conf`

echo "Name of the document ?"
read doc

fileName=$doc
hotglueContent=hotglue/content
mkdir $fileName
mkdir $fileName/head

echo "Number of pages ?"
read max


echo "$ACCESS" >ftp.temp

#echo "mdelete $hotglueContent/$fileName/auto-20140505130324/elements*" >> ftp.temp
#echo "delete $hotglueContent/$fileName/auto-220140505130324/page" >> ftp.temp

echo "mdelete $hotglueContent/$fileName/head/page*" >> ftp.temp
echo "delete $hotglueContent/$fileName/head/page" >> ftp.temp



#echo "rmdir $hotglueContent/$fileName/auto-20140505130324" >> ftp.temp
echo "rmdir $hotglueContent/$fileName/head" >> ftp.temp
echo "rmdir $hotglueContent/$fileName"     >> ftp.temp



echo "mkdir $hotglueContent/$fileName"     >> ftp.temp
echo "chmod 777 $hotglueContent/$fileName" >> ftp.temp
echo "mkdir $hotglueContent/$fileName/head" >> ftp.temp
echo "chmod 777 $hotglueContent/$fileName/head" >> ftp.temp




for ((pageSpace=50; counter<$max ;pageSpace=pageSpace+852))

do

counter=$(ls -A1 $fileName/head | wc -l)
#file=$($fileName)/head/elements$i	
file=$fileName/head/pages$counter
echo "put $file $hotglueContent/$fileName/head/pages$counter" >> ftp.temp
echo "chmod 666 $hotglueContent/$fileName/head/pages$counter" >> ftp.temp
echo "type:text"  > $file
echo "module:text"  >> $file
echo "object-height:842px"    >> $file 
echo "object-left:200px"			>> $file
echo "object-top:${pageSpace}px" >> $file
echo "object-width:596px"  >> $file
echo "object-zindex:100" >> $file
echo "text-background-color:rgb(255,255,255)"  >> $file
echo "object-lock:locked" >> $file


done




	#file=$($fileName)/head/page
file=$fileName/head/page
echo "put $file $hotglueContent/$fileName/head/page" >> ftp.temp
echo "chmod 666 $hotglueContent/$fileName/head/page" >> ftp.temp

echo "page-title:$fileName${i}"							>$file
echo "page-background-color:rgb(140, 140, 140)"			>>$file
echo "page-background-attachment:fixed"		>>$file





echo "bye"  >>ftp.temp

ftp -i -p -n $HOST < ftp.temp

<< Documentation
Name	      : Shridhar Pujar 
Date 	      :
Description   :
Sample input  :
Sample output :
Documentation
#!/bin/bash

echo hi
for i in `seq 5`;do
    echo $i
    if [ $i -eq 4 ];then
	continue
    fi
done
echo hello
while [ 1 ] ; do
    read a
    if [ $a = 1 ];then
	continue
    else
	break
    fi
done
#echo shri >> usernames.csv
#echo pra >> usernames.csv
#echo shra >> usernames.csv
#array=(`cat usernames.csv`)
#for i in ${array[*]}; do
#    echo $i
#done

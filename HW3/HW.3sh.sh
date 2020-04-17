var1=$( cat SRS_IDs.txt)
#echo $var1
for id in $var1
do
	if [ ! -d $id ]
	then
		mkdir $id
	fi
done

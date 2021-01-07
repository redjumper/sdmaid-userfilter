#!/system/bin/sh

echo "导出文件列表的时间可能会有点长，请耐心等待，中途不要停止脚本，导出完成会有提示"

start_time=`date +%s`
root=false

martix="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
length="10"
while [ "${n:=1}" -le "$length" ]
do
        random="$random${martix:$(($RANDOM%${#martix})):1}"
        let n+=1
done

# if rooted
if [ -f "/sbin/su" ] || [ -f "/system/bin/su" ]; then
	root=true
	# list internal storage
	if [ ! -d "/data/user" ]; then
		find /data/data/ -print > /storage/emulated/0/private-$random.txt
		sed -i 's/^\/data\/data/\/data\/user\/0/' private-$random.txt
	elif [ ! -d "/data/user/0" ] || [ `ls /data/user/0/ | wc -l` -lt 3 ]; then
		find /data/data/ -print > /storage/emulated/0/private-$random.txt
		find /data/user/ -print >> /storage/emulated/0/private-$random.txt
		sed -i 's/^\/data\/data/\/data\/user\/0/' private-$random.txt
	else
		find /data/user/ -print > /storage/emulated/0/private-$random.txt
	fi
	# list external storage
	if [ ! -d "/data/media" ]; then
		find /storage/emulated/0/ \( -path /storage/emulated/0/DCIM -o -path /storage/emulated/0/Documents -o -path /storage/emulated/0/Download -o -path /storage/emulated/0/Movies -o -path /storage/emulated/0/Music -o -path /storage/emulated/0/Pictures \) -prune -o -print > /storage/emulated/0/public-$random.txt
		sed -i 's/^\/storage\/emulated/\/data\/media/' public-$random.txt
	elif [ ! -d "/data/media/0" ] || [ `ls /data/media/0/ | wc -l` -lt 3 ]; then
		find /storage/emulated/0/ \( -path /storage/emulated/0/DCIM -o -path /storage/emulated/0/Documents -o -path /storage/emulated/0/Download -o -path /storage/emulated/0/Movies -o -path /storage/emulated/0/Music -o -path /storage/emulated/0/Pictures \) -prune -o -print > /storage/emulated/0/public-$random.txt
		find /data/media/ -type d \( -name DCIM -o -name Documents -o -name Download -o -name Movies -o -name Music -o -name Pictures \) -prune -o -print  > /storage/emulated/0/public-$random.txt
		sed -i 's/^\/storage\/emulated/\/data\/media/' public-$random.txt
	else
		find /data/media/ -type d \( -name DCIM -o -name Documents -o -name Download -o -name Movies -o -name Music -o -name Pictures \) -prune -o -print  > /storage/emulated/0/public-$random.txt
	fi
fi

# if not rooted
if [ "$root" = false ] && [ -d "/storage/emulated/0" ]; then
	find /storage/emulated/0/ \( -path /storage/emulated/0/DCIM -o -path /storage/emulated/0/Documents -o -path /storage/emulated/0/Download -o -path /storage/emulated/0/Movies -o -path /storage/emulated/0/Music -o -path /storage/emulated/0/Pictures \) -prune -o -print > /storage/emulated/0/public-$random.txt
	sed -i 's/^\/storage\/emulated/\/data\/media/' public-$random.txt
fi
	
end_time=`date +%s`
execute_time=`expr $end_time - $start_time`

echo "导出完成，耗时$execute_time秒"
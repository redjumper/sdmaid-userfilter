#!/system/bin/sh

echo "导出文件列表的时间可能会有点长，请耐心等待，中途不要停止脚本，导出完成会有提示"

start_time=`date +%s`
random=`date +%s%N | md5sum | head -c 10`
root=false

# if rooted
if [ -f "/sbin/su" ] || [ -f "/system/bin/su" ];
then
	root=true
	file_count=`find /data/user -maxdepth 2 | wc -l`
	if [ $file_count -lt 10 ];
	then
		find /data/data/ -print > /storage/emulated/0/private-$random.txt
	else
		find /data/user/ -print > /storage/emulated/0/private-$random.txt
	fi
	file_count=`find /data/media -maxdepth 2 | wc -l`
	if [ $file_count -lt 10 ];
	then
		find /storage/emulated/0/ \( -path /storage/emulated/0/DCIM -o -path /storage/emulated/0/Documents -o -path /storage/emulated/0/Download -o -path /storage/emulated/0/Movies -o -path /storage/emulated/0/Music -o -path /storage/emulated/0/Pictures \) -prune -o -print > /storage/emulated/0/public-$random.txt
		sed -i 's/^\/storage\/emulated/\/data\/media/' public-$random.txt
	else
		find /data/media/ -type d \( -name DCIM -o -name Documents -o -name Download -o -name Movies -o -name Music -o -name Pictures \) -prune -o -print  > /storage/emulated/0/public-$random.txt
	fi
fi

# if not rooted
if [ "$root" = false ] && [ -d "/storage/emulated/0" ];
then
	find /storage/emulated/0/ \( -path /storage/emulated/0/DCIM -o -path /storage/emulated/0/Documents -o -path /storage/emulated/0/Download -o -path /storage/emulated/0/Movies -o -path /storage/emulated/0/Music -o -path /storage/emulated/0/Pictures \) -prune -o -print > /storage/emulated/0/public-$random.txt
	sed -i 's/^\/storage\/emulated/\/data\/media/' public-$random.txt
fi
	
end_time=`date +%s`
execute_time=`expr $end_time - $start_time`

echo "导出完成，耗时$execute_time秒"
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

internal_file="/storage/emulated/0/private-$random-$(date +%Y%m%d).txt"
external_file="/storage/emulated/0/public-$random-$(date +%Y%m%d).txt"

# if rooted
if [ -f "/sbin/su" ] || [ -f "/system/bin/su" ]; then
	root=true
	# list internal storage
	if [ -d "/data/user" ]; then		
		if [ -d "/data/user/0" ] && [ `ls /data/user/0/ | wc -l` -gt 2 ]; then
			find -L /data/user/ -print > $internal_file 2>/dev/null | grep -v "No such file or directory"
		else
			find /data/data/ -print > $internal_file
			find /data/user/ -print >> $internal_file
			sed -i 's/^\/data\/data/\/data\/user\/0/' $internal_file
		fi
	else
		find /data/data/ -print > $internal_file
		sed -i 's/^\/data\/data/\/data\/user\/0/' $internal_file
	fi
	# list external storage
	if [ -d "/data/media" ]; then		
		if [ -d "/data/media/0" ] && [ `ls /data/media/0/ | wc -l` -gt 2 ]; then
			find /data/media/ -type d \( -name DCIM -o -name Documents -o -name Download -o -name Movies -o -name Music -o -name Pictures \) -prune -o -print > $external_file
		else
			find /storage/emulated/0/ \( -path /storage/emulated/0/DCIM -o -path /storage/emulated/0/Documents -o -path /storage/emulated/0/Download -o -path /storage/emulated/0/Movies -o -path /storage/emulated/0/Music -o -path /storage/emulated/0/Pictures \) -prune -o -print > $external_file
			find /data/media/ -type d \( -name DCIM -o -name Documents -o -name Download -o -name Movies -o -name Music -o -name Pictures \) -prune -o -print >> $external_file
			sed -i 's/^\/storage\/emulated/\/data\/media/' $external_file
		fi
	else
		find /storage/emulated/0/ \( -path /storage/emulated/0/DCIM -o -path /storage/emulated/0/Documents -o -path /storage/emulated/0/Download -o -path /storage/emulated/0/Movies -o -path /storage/emulated/0/Music -o -path /storage/emulated/0/Pictures \) -prune -o -print > $external_file
		sed -i 's/^\/storage\/emulated/\/data\/media/' $external_file
	fi
fi

# if not rooted
if [ "$root" = false ] && [ -d "/storage/emulated/0" ]; then
	find /storage/emulated/0/ \( -path /storage/emulated/0/DCIM -o -path /storage/emulated/0/Documents -o -path /storage/emulated/0/Download -o -path /storage/emulated/0/Movies -o -path /storage/emulated/0/Music -o -path /storage/emulated/0/Pictures \) -prune -o -print > $external_file
	sed -i 's/^\/storage\/emulated/\/data\/media/' $external_file
fi
	
end_time=`date +%s`
execute_time=`expr $end_time - $start_time`

echo "导出完成，耗时$execute_time秒"
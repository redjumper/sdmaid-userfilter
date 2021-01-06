#!/system/bin/sh

echo "导出文件列表的时间可能会有点长，请耐心等待，中途不要停止脚本，导出完成会有提示"

start_time=`date +%s`
random=`uuidgen -r | cksum | cut -f 1 -d " "`

if [ -f "/sbin/su" ] || [ -f "/system/bin/su" ];
then
	find /data/user/ -print > /storage/emulated/0/private-$random.txt
	find /data/media/ -type d \( -name DCIM -o -name Documents -o -name Download -o -name Movies -o -name Music -o -name Pictures \) -prune -o -print  > /storage/emulated/0/public-$random.txt
else
    if [ -d "/storage/emulated/0" ];
    then
	    find /storage/emulated/0/ \( -path /storage/emulated/0/DCIM -o -path /storage/emulated/0/Documents -o -path /storage/emulated/0/Download -o -path /storage/emulated/0/Movies -o -path /storage/emulated/0/Music -o -path /storage/emulated/0/Pictures \) -prune -o -print > /storage/emulated/0/public-$random.txt
		sed -i 's/^\/storage\/emulated/\/data\/media/' public-$random.txt
    fi
fi

end_time=`date +%s`
execute_time=`expr $end_time - $start_time`

echo "导出完成，耗时$execute_time秒"
#!/system/bin/sh

echo "导出文件列表的时间可能会有点长，请耐心等待，中途不要停止脚本，导出完成会有提示"

random=`uuidgen -r | cksum | cut -f 1 -d " "`

if [ -f "/sbin/su" ] || [ -f "/system//bin/su" ];
then
	find /data/data/ -print > /storage/emulated/0/private-$random.txt
fi

if [ -d "/storage/emulated/0" ];
then
	find /storage/emulated/0/ \( -path /storage/emulated/0/DCIM -o -path /storage/emulated/0/Documents -o -path /storage/emulated/0/Download -o -path /storage/emulated/0/Movies -o -path /storage/emulated/0/Music -o -path /storage/emulated/0/Pictures \) -prune -o -print > /storage/emulated/0/public-$random.txt
fi

echo "导出完成"
# SD Maid用户规则

# 说明

SD Maid是安卓上最强大的清理类应用，但它默认的规则没有很好地适配国内的应用。此项目创建的初衷就是适配国内的应用。

此规则

* 开源免费，同步在QQ 群内分享。

* 和官方规则一样，每条规则前都有颜色图标，范围从绿色到红色，代表规则内文件的重要性或者规则误删文件的可能性。

* 支持存储空间隔离（存储重定向）。

* 针对扫描机制优化。

1、使用前请先阅读[wiki](https://github.com/redjumper/sdmaid-userfilter/wiki)和[issue 1](https://github.com/redjumper/sdmaid-userfilter/issues/1)。

2、为尊重作者的知识产权，不会采用再编译SD Maid，集成应用清理规则的方式。

3、master分支下的规则经过测试后才发布，一般不会误删文件，但本人不对规则可能导致的误删做任何承诺，如发现问题，可以提issue或者去QQ 群反馈。

4、SD Maid用户规则相关讨论 QQ 群: 945792668

# 使用方法

1、设置

参照[wiki](https://github.com/redjumper/sdmaid-userfilter/wiki/3.%E8%AE%BE%E7%BD%AE)

2、用户规则

* 删除原规则

系统清理>右上角齿轮>用户，删除所有规则

如果设备已root，也可以直接删除/data/data/eu.thedarken.sdm/files/systemcleaner_user_filter/下所有文件

* 导入新规则

系统清理>右上角齿轮>用户>右上角的下载图标，手动导入systemcleaner_user_filter下所有文件

如果设备已root，也可以直接复制systemcleaner_user_filter下所有文件到/data/data/eu.thedarken.sdm/files/systemcleaner_user_filter/

3、排除项

其他>排除项>右上角省略号>导入 手动导入exclusions下exclusions.json

# 反馈

如果有疑问，请提issue或者去QQ 群反馈。

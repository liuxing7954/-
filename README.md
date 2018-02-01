# MyUpdateTool
2.0版本


# 目录结构说明
```

│  1一键打包.bat
│  2一键上传.bat
│  3一键重启.bat
│  4一键打包上传重启.bat
│  log.txt
│  npm-debug.log
│  README.md
│  text.txt
│  非专业认识勿点.txt
│  
├─auto
│  │  AutoUpgrade.class.php    
│  │  main.php                 --------------------------打包程序入口 
│  │  path.php                 --------------------------主要配置文件
│  │  PathUtil.class.php
│  │  打包测试.bat              --------------------------使用bat执行php main.php命令
│  │      
│  ├─ForUpdate                 --------------------------最近一次打包的代码
│  │                      
│  └─升级包                     --------------------------历史打包代码保留
│                              
├─bin                          --------------------------存放上传代码和执行重启服务使用的第三方连接服务器软件
│      
└─config
        02down.ini              
        76upload.ini           --------------------------上传服务器的配置
        killCSP.sh             --------------------------重启服务的命令
        
```

# 环境配置
配置基本php环境变量，版本最好`5.6`以上。
打开cmd输入`php -v`不报错即为配置成功

# 使用步奏
- 打开`path.php`,编写需要打包的文件已经此次升级包的更新内容
- 运行`打包测试.bat`,如果编写正确就不会报错，提示此次打包内容。打包会生成一个最近更新的txt文档，也会把最新的`path.php`文件复制一份到升级包中，以备以后继续打包
- 然后即可运行`一键上传.bat`.
- 视情况决定是否需要运行`一键重启.bat`

# 配置文件如何编写
> 至少需要php的数据基础知识  
路径用php关联数组表示。如果key对应的是数组，则此key名是文件夹名，程序会递归继续查询最终的文件名
```
<?php
header("Content-type: text/html; charset=utf-8"); 
date_default_timezone_set("Asia/Shanghai");
$DirName = date("Ymd", time()); 
//目标文件路径    
$target_path = './升级包/首页头部改造';                      //升级包名字
$target_path = iconv("UTF-8", "GBK", $target_path); 
// $target_path = '账户功能改造';
//源文件路径前缀
$base_path = 'D:\System\Doc\CODE\ZZJG\otc';                 //此处配置本地项目绝对路径
$note = '首页头部改造';                                       //升级内容备注

$modArr = [
    'main'=>[
        'index_v2.jsp',                                     //这里标识文件路径为mod/main/index_v2.jsp
        'head_v2.jsp',
        'foot_v2.jsp',
        'head_v2.bak.jsp',
        'foot_v2.bak.jsp',
    ],
];

$resArr = [
    "otcV2"=>[
        'js'=>[
            'head'=>[
                'index.js'
            ],
        ]
    ]
];

$classes = [
    'urlredirect.properties',
    'com'=>[
        'apex'=>[
            'interotc'=>[
                'global'=>[
                    'config'=>[
                        'UrlredirectConfig.class'
                    ],
                    'Constants$WebApp.class',
                    'Constants.class'
                ]
            ]
        ]
    ],
    'filter' => [
        'UrlRedirectFilter.class'
    ],
];

$config = [
    "config_custom.properties",
];

//最终使用路径数组
$pathArr = [
    "WebContent"=>[
        "WEB-INF"=>[
            "mod"=>$modArr,
            "classes"=>$classes,
            // "config"=>$config,
        ],
        "res"=>$resArr,
    ]
];
```

说明文档写的不是很详细。提供在线支持。可联系`qq:467677527`

# 实现思路
就是配置文件主要是为了配置出一个路径组成的数组`$pathArr`然后程序会解析出所有文件的路径，去系统中寻找并复制出来，按照原本的路径存放
可以将打包功能替换，使用java代码和json配置替换。

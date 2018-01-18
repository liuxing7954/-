<?php
header("Content-type: text/html; charset=utf-8"); 
date_default_timezone_set("Asia/Shanghai");
$DirName = date("Ymd", time()); 
//目标文件路径
$target_path = './升级包/临时用户修改组织机构代码';
$target_path = iconv("UTF-8", "GBK", $target_path); 
// $target_path = '账户功能改造';
//源文件路径前缀
$base_path = 'D:\System\Doc\CODE\ZZJG\otc';
$note = '临时用户修改组织机构代码';

$modArr = [
    "user"=>[
        'tempUserInfoView.jsp'
    ],
];

$resArr = [
    "otcV2"=>[
        'js'=>[
            'echarts.min.js',
            'main'=>[
                'zzqs.js'
            ],
        ],
    ],
];

$classes = [
    "com"=>[
        "apex"=>[
            "interotc"=>[
                "module"=>[
                    "cyrpx"=>[
                        "vo"=>[
                            "PxtzVo.class",
                            "XxydVo.class",
                            "ZxbmVo.class",
                        ],
                        "controller"=>[
                            "CyrpxController.class"
                        ],
                        "service"=>[
                            "CyrpxService.class"
                        ],

                    ]
                ]
            ]
        ]
    ],
    "tableparams.xml",
];

$config = [
    "config_custom.properties",
];

//最终使用路径数组
$pathArr = [
    "WebContent"=>[
        "WEB-INF"=>[
            "mod"=>$modArr,
            // "classes"=>$classes,
            // "config"=>$config,
        ],
        // "res"=>$resArr,
    ]
];
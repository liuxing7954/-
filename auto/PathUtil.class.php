<?php

/**
 * Created by PhpStorm.
 * User: liuxi
 * Date: 2017/9/25
 * Time: 16:15
 */
class PathUtil
{
    static function arrayToPathArray($pre, $arr, &$res = null)
    {
        if ($res == null) {
            $res = [];
        }
        foreach ($arr as $k => $v) {
            if (is_array($v)) {
                self::arrayToPathArray($pre . "/" . $k, $v, $res);
            }
            if (is_string($v) && $v != '') {
                $res[] = $pre . "/" . $v;
//                echo $pre . "/" . $v;
            }
        }
//        var_dump($res);
        return $res;
    }

    static function translationFile($sourcePathArr, $targetPathArr)
    {
//        global $updatePathArr, $successCount, $failCount;
        $updatePathArr = [];
        $failCount = 0;
        //复制文件，开始打包
        foreach ($sourcePathArr as $k => $v) {
            //源文件是否存在
            if (file_exists($v)) {
                $parentPath = dirname($targetPathArr[$k]);
                //创建目录
                if (!is_dir($parentPath)) {
                    if (!mkdir($parentPath, 0777, true)) {
                        echo $parentPath . "==> Make Dir Error\n";
                        exit();
                    }
                }

                //判断大小，记录有变动的文件
                if (file_exists($targetPathArr[$k])) {
                    $sourceFSize = abs(filesize($v));
                    $targetFSize = abs(filesize($targetPathArr[$k]));
                    if ($sourceFSize != $targetFSize) {
                        $updatePathArr[$k] = $v;
                        // echo 'file_exists';
                    }
                } else {
                    $updatePathArr[$k] = $v;
                    // echo 'file_not_exists';
                }

                //复制文件
                if (!copy($v, $targetPathArr[$k])) {
                    echo $v . "==> File Copy Error\n";
                    $failCount++;
                    exit();
                } else {
//                    $successCount++;
                }
            } else {
                echo $v . "==> Can't Find File\n";
                $failCount++;
                exit();
            }
        }

        return $updatePathArr;
    }

    static function delDir($dir)
    {
        //TODO::注意替换分隔符
        $dir = str_replace('/', DIRECTORY_SEPARATOR, $dir);
//        echo $dir;
        $cmd = 'rmDir /s/q ' . $dir;
        $flag = system($cmd);
//        if (!$flag) {
//            exit($cmd . '执行失败' . $flag);
//        }
    }
}
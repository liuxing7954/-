<?php

/**
 * Created by PhpStorm.
 * User: liuxi
 * Date: 2017/9/25
 * Time: 16:16
 */
require_once "./PathUtil.class.php";

class AutoUpgrade
{
    private $source_path_arr;
    private $target_path_arr;
    private $change_path_arr = [];
    private $source_pre_path;
    private $target_pre_path;
    private $update_path_arr;
    private $update_path = 'ForUpdate';

    function __construct($source_arr, $base_path, $target_path)
    {
        $this->source_pre_path = $base_path;
        $this->target_pre_path = $target_path;
        $this->source_path_arr = PathUtil::arrayToPathArray($base_path, $source_arr);
        $this->target_path_arr = PathUtil::arrayToPathArray($target_path, $source_arr);
        $this->update_path_arr = PathUtil::arrayToPathArray($this->update_path, $source_arr);
    }

    function packge()
    {
        $this->packgeForBackUp();
        $this->packgeForAutoUpdate();
    }

    function packgeForBackUp()
    {
        $this->change_path_arr = PathUtil::translationFile($this->source_path_arr, $this->target_path_arr);
        if(count($this->change_path_arr) != 0){
            print_r($this->change_path_arr);
        }
        $this->noteUpdate();
    }

    function packgeForAutoUpdate()
    {
        PathUtil::delDir($this->update_path);
        PathUtil::translationFile($this->source_path_arr, $this->update_path_arr);
    }



    function noteUpdate()
    {
        $file = fopen($this->target_pre_path . '/update.txt', 'w');
//        fwrite($file, "升级内容：\r\n" . $note . "\r\n\r\n");

        fwrite($file, "升级包内总共有以下文件:\r\n");
        foreach ($this->source_path_arr as $v) {
            fwrite($file, $v . "\r\n");
        }

        fwrite($file, "最近一次更新以下文件:\r\n");
        foreach ($this->change_path_arr as $v) {
            fwrite($file, $v . "\r\n");
        }
        flush($file);
        fclose($file);
        //复制文件
        if (!copy("./path.php", $this->target_pre_path . '/path.php')) {
            echo "path.php ==> File Copy Error\n";
            exit();
        }
    }

    function getChangeFileNum()
    {
        return count($this->change_path_arr);
    }

    function getTotalFileNum()
    {
        return count($this->source_path_arr);
    }



    function printResult()
    {
        $str = "总共{$this->getTotalFileNum()}个文件，更新{$this->getChangeFileNum()}个文件。";
        echo iconv("UTF-8", "GBK", $str);
    }
}
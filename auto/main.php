<?php
/**
 * Created by PhpStorm.
 * User: liuxi
 * Date: 2017/9/25
 * Time: 16:14
 */
require_once './path.php';
require_once './AutoUpgrade.class.php';

$auto = new AutoUpgrade($pathArr,$base_path,$target_path);
$auto->packgeForBackUp();
$auto->packgeForAutoUpdate();
$auto->printResult();
//var_dump($auto);
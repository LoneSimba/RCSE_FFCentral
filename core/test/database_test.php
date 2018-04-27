<?php

require_once('../database.php');
$database = new Database();

$test_user_login = "Test";
$test_user_firstname = "Test";
$test_user_lastname = "User";
$test_user_password = password_hash("Hello", PASSWORD_DEFAULT);
$test_user_email = "hello@x.yz";
$test_user_usergroup = "Test";
$test_user_brithdate = date('Y-m-d H:i');
$test_user_regdate = date('Y-m-d H:i');
$test_user_sex = "Male";
$test_user_origin = "Moscow, Russia";
$test_user_settings = "theme:default;";
$test_users = array($test_user_login, $test_user_firstname, $test_user_lastname, $test_user_password, $test_user_email, $test_user_usergroup, $test_user_brithdate, $test_user_regdate, $test_user_sex, $test_user_origin, $test_user_settings);

$test_usergroup_title = "Test";
$test_usergroup_priority = "2";
$test_usergroup_permissions = "openpages;";
$test_usergroups = array($test_usergroup_title, $test_usergroup_priority, $test_usergroup_permissions);

$usergroup = $database->execute_statement('insert','usergroups', $test_usergroups);
var_dump($usergroup);
echo "<br>";
var_dump($test_usergroups);
echo "<br>";

$user = $database->execute_statement('insert','users',$test_users);
var_dump($user);
echo "<br>";
var_dump($test_users);
<?php

require_once("../user.php");

$user = new User();

$userdata = $user->auth("Test","Hello");

print $_SESSION['login'];
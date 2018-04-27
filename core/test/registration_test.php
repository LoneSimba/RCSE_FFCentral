<?php

require_once("../user.php");
$user = new User();

$login = $_POST['login'];
$password = $_POST['password1'];
$email = $_POST['email'];
$firstname = $_POST['firstname'];
$lastname = $_POST['lastname'];
$brithdate = $_POST['brithdate'];
$sex = $_POST['sex'];
$origin = $_POST['origin'];
?>
<html>
    <head>
        <meta charset="utf-8">
    </head>
    <body>
        <?php
            
            $user->register($login, $password, $email, $firstname, $lastname, $brithdate, $sex, $origin);
            ?>
    </body>
    </html>
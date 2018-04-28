<?php

/**
 * Файл системы пользователей
 * 
 * Файл содержит функции для обеспечения работы системы пользователей
 * @author LoneSimba <silet-stalker99@yandex.ru>
 * @version 0.1
 * @package RCSE_FFCentral
 * @todo Составить список настроек аккаунта, добавить в таблицу пользователей звания и биографию, подключить чтение конфига
 */

/**
 * Подключение database.php
 */
require_once("database.php");

/**
 * Обеспечивает работу системы пользователей
 * 
 * @package RCSE_FFCentral
 * @subpackage Usersystem
 */
class User
{

  private $database;
  private $other;
  private $config;

  /**
   * Конструктор класса User
   */
  public function __construct()
  {
    $this->database = new Database();
    $this->other = new Other();

    //$this->config = $this->other->read_config();

    if (!isset($_SESSION)) session_start();
  }


  /**
   * Проверяет соответсвие введеных логина\пароля на соответсвие данным в БД
   *
   * @param string $login     имя пользователя
   * @param string $password  пароль
   * @return void
   */
  public function auth($login, $password)
  {
    $params = array($login);
    $query = $this->database->execute_statement('select', 'users', $params);

    if (!$query['bool']) {
      echo 'Логин не найден!';
    } else {
      $result = $query['result']->fetch(PDO::FETCH_ASSOC);

      if (!password_verify($password, $result['password'])) {
        echo 'Пароль неверен!';
      } else {
        $_SESSION['login'] = $login;
      }
    }
  }

  public function register($login, $password, $email, $firstname, $lastname, $brithdate, $sex, $origin)
  {
    $regdate = date('Y-m-d H:i');
    $settings = "theme:default;brithdate:shown;email:shown;feed:true;";
    $titles = "Newbie;Tester";
    $usergroup = "User";

    /*
    $options = array('cost'=>$this->config[encr_cost]);
    $encrypted_password = password_hash($password, PASSWORD_DEFAULT, $options);
     */

    $user_params = array($login, $firstname, $lastname, password_hash($password, PASSWORD_DEFAULT), $email, $usergroup, $brithdate, $regdate, $sex, $origin, $settings);

    $this->database->execute_statement('insert', 'users', $user_params);

    if (!$this->database->users_requests['result']) {
      $error = $this->database->users_requests['insert']->errorInfo();
      print 'Ошибка: ' . $error[2];
    } else {
      $error = '';
      echo "Все ОК.";
    }

  }

}
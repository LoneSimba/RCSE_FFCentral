<?php
/**
 * Файл системы пользователей
 * 
 * Файл содержит функции для обеспечения работы системы пользователей
 * @author LoneSimba <silet-stalker99@yandex.ru>
 * @version 0.1
 * @package RCSE_FFCentral
 */

 /**
  * Подключение database.php
  */
  require_once("./database.php");

 /**
  * Обеспечивает работу системы пользователей
  * 
  * @package RCSE_FFCentral
  * @subpackage Usersystem
  */
class User 
{
  
  public $database;

  /**
   * Конструктор класса User
   */
  public function __construct() 
  {
    $this->database = new Database();

    if(!isset($_SESSION)) session_start();
  }

  
  /**
   * Проверяет соответсвие введеных логина\пароля на соответсвие данным в БД
   *
   * @param string $login     имя пользователя
   * @param string $password  пароль
   * @return void
   */
  public function auth(string $login, string $password) 
  {
      $params = array($login);
      $query = $this->database->execute_statement('select','users',$params);

      if(!$query) {
        echo 'Логин не найден!';
      } else {
        $result = $this->database->users_requests['select']->fetch(PDO::FETCH_ASSOC);

        if(md5($password)!=$result['pass']) {
          echo 'Пароль неверен!';
        } else {
          $_SESSION['login'] = $login;
        }
      }
  }

  public function register() 
  {
    
  }

}
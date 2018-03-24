<?php

/**
 * Файл с основнымы взаимодействиями с БД
 * 
 * В этом файле размещены основные функции взаимодействия с БД, работает через СУБД PDO
 * @author LoneSimba <siluet-stalker99@yandex.ru>
 * @version 0.1b
 * @package RCSE_FFCentral
 */


/**
 * Обеспечивает взаимодействие движка и PDO
 * 
 * @package RCSE_FFCentral
 * @subpackage Database
 */
class Database
{

    /*
     * Запросы
     */
    public $users_requests = ['select' => null, 'selectall' => null, 'login' => null, 'update' => null, 'insert' => null, 'remove' => null];
    public $usergorups_requests = ['select' => null, 'selectall' => null, 'update' => null, 'instert' => null, 'remove' => null];
    public $bans_requests = ['select' => null, 'selectall' => null, 'update' => null, 'insert' => null, 'remove' => null];
    public $fanfics_requests = ['select' => null, 'selectall' => null, 'update' => null, 'insert' => null, 'remove' => null];
    public $replies_requests = ['select' => null, 'selectall' => null, 'update' => null, 'insert' => null, 'remove' => null];
    public $fandoms_requests = ['select' => null, 'selectall' => null, 'update' => null, 'instert' => null, 'remove' => null];
    public $genres_requests = ['select' => null, 'selectall' => null, 'update' => null, 'insert' => null, 'remove' => null];
    public $orders_requests = ['select' => null, 'selectall' => null, 'update' => null, 'insert' => null, 'remove' => null];
    public $udef_requests = ['select' => null, 'selectall' => null, 'update' => null, 'insert' => null, 'remove' => null];

    /*
     * Экземпляры класса 
     */
    private $database;

    /**
     * Конструктор Database
     * 
     * @todo Получать имя БД, адрес хоста, логин и пароль СУБД из файла конфигурации
     */
    public function __construct()
    {

        $dbinfo = 'mysql:dbname=ffcentral;host=127.0.0.1';
        $dbuser;
        $dbpass;

        try {
            $this->database = new PDO($dbinfo, 'root', '', array(PDO::ATTR_ERRMODE => PDO::ERRMODE_WARNING));
        } catch (PDOException $e) {
            print('Error: ' . $e->getMessage() . '<br>');
        }

        $this->prepare_statemets();
    }

    /**
     * Выполняет подготовку существующих запросов
     *
     * @return void
     */
    private function prepare_statemets()
    {
        $this->users_requests['selectall'] = $this->database->prepare("SELECT * FROM users");
        $this->users_requests['select'] = $this->database->prepare("SELECT * FROM users WHERE `login`=?");

        $this->fanfics_requests['selectall'] = $this->database->prepare("SELECT * FROM fanfics");

        $this->replies_requests['selectall'] = $this->database->prepare("SELECT * FROM replies"); // Заметка: сомневаюсь в необходимости прогрузки всех отзывов на фанфики

        $this->genres_requests['selectall'] = $this->database->prepare("SELECT * FROM genres");

        $this->bans_requests['selectall'] = $this->database->prepare("SELECT * FROM  bans");
    }

    /**
     * Выполняет запрос, указанный в $type
     *
     * @param string $type Тип запроса
     * @param string $table Таблица
     * @param array  $params Массив параметров для запроса
     * @return void
     */
    public function execute_statement(string $type, string $table, array $params)
    {
        if(($type != null || $type != "") || ($table != null || $table != "")) {
            switch($table) {
                case 'users':
                    $this->users_requests[$type] = $this->database->execute($params);
                    break;
                case 'usergroups':
                    $this->usergorups_requests[$type] = $this->database->execute($params);
                    break;
                case 'bans':
                    $this->bans_requests[$type] = $this->database->execute($params);
                    break;
                case 'fanfics':
                    $this->fanfics_requests[$type] = $this->database->execute($params);
                    break;
                case 'replies':
                    $this->replies_requests[$type] = $this->database->execute($params);
                    break;
                case 'fandoms':
                    $this->fandoms_requests[$type] = $this->database->execute($params);
                    break;
                case 'genres':
                    $this->genres_requests[$type] = $this->database->execute($params);
                    break;
                case 'orders':
                    $this->orders_requests[$type] = $this->database->execute($params);
                    break;
                default:
                    print("Ошибка - для исполнения запросов udef используйте execute_udef()");
            }
        } else {
            print("Ошибка - не указан тип запроса или целевая таблица!");
        }

    }
    /**
     * Выполняет подготовку запроса, отличного от стандартных
     *
     * @param string $table Таблица, к которй идет запрос
     * @param string $type Тип запроса
     * @param array $params Набор параметров(не у всех запросов)
     * @param string $statement SQL-запрос
     * @return void
     * @todo Вывод сообщения об ошибке в браузер через модальное окно
     */
    private function prepare_statement_wtable(string $table, string $type, array $params, string $statement)
    {
        if ($table != null || $table != "") {
            switch ($type) {
                case 'select':
                    ($params != null || $params != "") ? $this->udef_requests['select'] = $this->database->prepare("SELECT * FROM $table WHERE $params[0]=:param1") : print("Ошибка - массив параметров пуст!");
                    break;
                case 'selectall':
                    switch ($table) {
                        case 'users':
                        case 'usergroups':
                        case 'bans':
                        case 'fanfics':
                        case 'genres':
                        case 'fandoms':
                        case 'replies':
                        case 'orders':
                            print("Ошибка - запрос типа $type для таблицы $table уже подготовлен - используйте $table/_requests[/'$type/']");
                            break;
                        default:
                            $this->udef_requests['selectall'] = $this->database->prepare("SELECT * FROM $table");
                            return;
                    }
                    break;
                case 'update':
                    ($params != null || $params != "") ? $this->udef_requests['update'] = $this->database->prepare("UPDATE $table SET $params[2]=:param3 WHERE $params[0]=:param1") : print("Ошибка - массив параметров пуст!");
                    break;
                case 'insert':
                    switch ($table) {
                        case 'users':
                        case 'usergroups':
                        case 'bans':
                        case 'fanfics':
                        case 'genres':
                        case 'fandoms':
                        case 'replies':
                        case 'orders':
                            print("Ошибка - запрос типа $type для таблицы $table уже подготовлен - используйте $table/_requests[/'$type/']");
                            break;
                        default:
                            ($statement != "" || $statement != null) ? $this->udef_requests['insert'] = $this->database->prepare($statement) : print("Ошибка - переменная statement не должна быть пуста при запросе типа $type");
                            return;
                    }
                    break;
                case 'remove':
                    switch ($table) {
                        case 'users':
                        case 'usergroups':
                        case 'bans':
                        case 'fanfics':
                        case 'genres':
                        case 'fandoms':
                        case 'replies':
                        case 'orders':
                            print("Ошибка - запрос типа $type для таблицы $table уже подготовлен - используйте $table/_requests[/'$type/']");
                            break;
                        default:
                        //$this->udef_requests['remove'] = $this->database->prepare("P FROM $table");
                    }
                    break;
                default:
                    print("Ошибка - не выбран тип запроса!");
            }
        }
    }
}
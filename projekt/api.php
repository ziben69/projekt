<?php

require_once __DIR__.'/../vendor/autoload.php';

use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;

$app = new Silex\Application();

$app->register(new Silex\Provider\DoctrineServiceProvider(), array(
    'db.options' => array(
        'driver'   => 'pdo_mysql',
        'dbname' => 'xx',
        'user' => 'xx',
        'password' => 'xx',
        'charset' => 'UTF8'
    ),
));

$app['debug'] = true;

class DataProvider {
    private $db;

    public function __construct($db)
    {
        $this->db = $db;
    }

    public function getRequestData()
    {
        return json_decode(file_get_contents('php://input'), true);
    }


    /*==========  Tasks  ==========*/
    public function getTasks()
    {
        $sql = "SELECT c.*, cs.name as status_name, u.name as user_name FROM tasks as c LEFT JOIN status as cs ON c.status_id = cs.id LEFT JOIN users as u ON c.user_id = u.id";

        return $this->db->fetchAll($sql);
    }

    public function getTask($taskId)
    {
        $sql = "SELECT * FROM tasks WHERE id = ?";
        return $this->db->fetchAssoc($sql, array((int) $taskId));
    }

    public function updateTask($taskId, $data)
    {
        unset($data['id']);

        $where = ['id' => (int) $taskId];

        $this->db->update('tasks', $data, $where);

        return true;
    }

    public function saveNewTask($data)
    {
        unset($data['id']);

        $result = $this->db->insert('tasks', $insertData);

        if(!$result){
            return false;
        }

        return $this->db->lastInsertId();
    }

    public function deleteTask($taskId)
    {
        $this->db->delete('tasks', ['id' => $taskId]);
        return true;
    }


    /*==========  Timeline  ==========*/
    public function getTaskTimeline($taskId)
    {
        $sql = "SELECT ct.*, u.name as user_name FROM realization_timeline as ct LEFT JOIN users as u ON ct.user_id = u.id WHERE task_id = ? ORDER BY control_date DESC";
        return $this->db->fetchAll($sql, array((int) $taskId));
    }

    public function addTimelineEvent($taskId, $eventData)
    {
        $eventData['task_id'] = $taskId;

        $result = $this->db->insert('realization_timeline', $eventData);

        if(!$result){
            return false;
        }

        return $this->db->lastInsertId();
    }

    public function getTimelineEvent($eventId)
    {
        return $this->db->fetchAssoc("SELECT * FROM realization_timeline WHERE id = ?", array((int) $eventId));
    }


    /*==========  Users  ==========*/
    public function getUsers()
    {
        $sql = "SELECT * FROM users";

        return $this->db->fetchAll($sql);
    }

    public function getUser($userId)
    {
        $sql = "SELECT * FROM users WHERE id = ?";
        return $this->db->fetchAssoc($sql, array((int) $userId));
    }
    public function getLogin()
    {
           $sql = "SELECT login FROM users WHERE login='$username' AND password='$password'";
            
            return $this->db->fetchAll();
    }

    /*==========  status  ==========*/
    public function getStatus()
    {
        $sql = "SELECT * FROM status";

        return $this->db->fetchAll($sql);
    }



};

$DataProvider = new DataProvider($app['db']);

/*===============================
=            TASKS            =
===============================*/
$app->get('/tasks', function () use ($app, $DataProvider) {
    $tasks = $DataProvider->getTasks();

    $response = new JsonResponse();
    $response->setEncodingOptions(JSON_NUMERIC_CHECK);
    $response->setData($tasks);

    return $response;
});

$app->get('/task/{taskId}', function ($taskId) use ($app, $DataProvider) {

    $taskDetails = $DataProvider->getTask($taskId);

    if(!$taskDetails){
        return $app->json(['errorMessage' => 'Task Not Found'], 404);
    }

    return $app->json($taskDetails);
});

$app->put('/task/{taskId}', function (Request $request, $taskId) use ($app, $DataProvider) {

    $taskDetails = $DataProvider->getTask($taskId);

    if(!$taskDetails){
        return $app->json(['errorMessage' => 'Task Not Found'], 404);
    }

    $updateData = $DataProvider->getRequestData();

    $result = $DataProvider->updateTask($taskId, $updateData);

    return $app->json(['message' => 'Task updated!']);
});

$app->post('/task', function (Request $request) use ($app, $DataProvider) {

    $insertData = $DataProvider->getRequestData();

    $newTaskId = $DataProvider->saveNewTask($insertData);

    if(false == $newTaskId){
        return $app->json(['errorMessage' => 'Can not insert user'], 500);
    }

    $taskDetails = $DataProvider->getTask($newTaskId);

    return $app->json(['message' => 'Task created!', 'task' => $taskDetails]);
});

$app->delete('/task/{taskId}', function (Request $request, $taskId) use ($app, $DataProvider) {

    $DataProvider->deleteTask($taskId);

    return $app->json(['message' => 'Task deleted!']);
});
/*===============================
=            LOGIN              =
===============================*/

$app->post('/login', function () use ($app, $DataProvider) {

    $login = $DataProvider->getLogin();

    return $app->json($login);
});

/*=======================================
=                 STATUS                =
=======================================*/
$app->get('/status', function () use ($app, $DataProvider) {

    $status = $DataProvider->getStatus();

    return $app->json($status);
});



/*=============================
=            USERS            =
=============================*/
$app->get('/users', function () use ($app, $DataProvider) {

    $users = $DataProvider->getUsers();

    return $app->json($users);
});



/*================================
=            TIMELINE            =
================================*/
$app->get('/task/{taskId}/timeline', function (Request $request, $taskId) use ($app, $DataProvider) {

    $taskDetails = $DataProvider->getTask($taskId);

    if(!$taskDetails){
        return $app->json(['errorMessage' => 'Task Not Found'], 404);
    }

    $timeline = $DataProvider->getTaskTimeline($taskId);

    return $app->json($timeline);
});

$app->post('/task/{taskId}/timeline', function (Request $request, $taskId) use ($app, $DataProvider) {

    $taskDetails = $DataProvider->getTask($taskId);

    if(!$taskDetails){
        return $app->json(['errorMessage' => 'Task Not Found'], 404);
    }

    $eventData = $DataProvider->getRequestData();

    $eventId = $DataProvider->addTimelineEvent($taskId, $eventData);

    if(false == $eventId){
        return $app->json(['errorMessage' => 'Can not create timeline event'], 500);
    }

    $timeline = $DataProvider->getTaskTimeline($taskId);

    return $app->json(['message' => 'Timeline Event created!', 'timeline' => $timeline]);
});

$app->run();

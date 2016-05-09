(function(){

    var app = angular.module('crmApp', ['ngRoute', 'crmService', 'ngMessages']);

    app.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {

        $routeProvider
        .when('/login', {
            controller: 'LoginController',
            templateUrl: 'views/login.html',
            label: 'Panel logowania'
        })
        .when('/tasks', {
            controller: 'TasksListCtrl',
            templateUrl: 'views/tasks-list.html',
            label: 'Lista zleceń'
        })
        .when('/tasks/:taskId', {
            controller: 'TasksDetailsCtrl',
            templateUrl: 'views/task-details.html',
            label: 'Szczegóły zlecenia'
        })
        .when('/users', {
                //controller: 'UsersCtrl',
                templateUrl: 'views/users-list.html',
                //label: 'Lista pracowników'
            })
        .otherwise({
            redirectTo: '/login'
        })
        ;

        $locationProvider
        .html5Mode(true);

    }]);

    app.controller("LoginController",  function($scope, LoginFtr) {
    $scope.loginInfo = {
      username: undefined,
      password: undefined
    };
 
    $scope.loginUser = function(){
        LoginFtr.getLogin($scope.loginInfo).then(function(response) {
                  console.log("OK");
        });
    }
  })
  .factory("LoginFtr", function($q, $http) {
    return {
      getLogin: function(data) {
        var deferred = $q.defer();
        $http.post('/api.php/login', data)
          .success(function(response) {
            deferred.resolve(response);
          });
        return deferred.promise;
      }
    };
  });

    app.controller('TasksListCtrl', ['$scope', 'tasks', 'users', 'status', function ($scope, tasks, users, status){

        $scope.tasks = [];
        $scope.users = [];
        $scope.status = [];

        $scope.orderByColumn = 'id';
        $scope.orderByDir = false;

        $scope.filterBy = {};

        tasks.getTasks(function (tasks){
            $scope.tasks = tasks;
        });

        users.getUsers(function(users){
            $scope.users = users;
        });

        status.getStatus(function(status){
            $scope.status = status;
        });

        $scope.changeOrder = function(columnName){
            if($scope.orderByColumn == columnName){
                $scope.orderByDir = !$scope.orderByDir;
            }else{
                $scope.orderByColumn = columnName;
                $scope.orderByDir = false;
            }
        };

        $scope.isOrderedBy = function(columnName){
            return ($scope.orderByColumn == columnName);
        };

        $scope.isOrderedReverse = function(){
            return !$scope.orderByDir;
        };
    }]);

    app.controller('TasksDetailsCtrl',['$scope', 'tasks','$routeParams', 'users', 'status', '$timeout', 'timeline','$location',function($scope, tasks, $routeParams, users, status, $timeout, timeline, $location){
        $scope.task = {};
        $scope.users = [];
        $scope.status = [];


        $scope.timeline = [];
        $scope.timelineHelper = timeline.getTimelineHelper();
        $scope.timelineEvent = {};
        $scope.eventTypes = timeline.getEventTypes();
        $scope.newEventCreatedMsg = false;

        $scope.taskNotFound = false;
        $scope.showSaveTaskFormMsg = false;

        if('new' !== $routeParams.taskId){
            tasks.getTask(
                $routeParams.taskId,
                function (data) {
                    $scope.task = data;

                    timeline.getTaskTimeline($scope.task.id, function (timeline) {
                        $scope.timeline = timeline;
                        console.log($scope.timeline);
                    });
                },
                function (data, statuss) {
                    if(404 == statuss){
                        $scope.taskNotFound = true;
                    }
                }
                );
        }


        users.getUsers(function (users) {
            $scope.users = users;
        });

        status.getStatus(function (status) {
            $scope.status = status;
        });


        $scope.saveTaskData = function () {

            if($scope.tasksForm.$invalid) return;


            if('new' == $routeParams.taskId){

                tasks.saveNewTask($scope.task, function (task) {

                 $location.path('/tasks/'+task.id);

             });

            }else{
                tasks.updateTask($scope.task.id, $scope.task, function (data) {
                    $scope.showSaveTaskFormMsg = true;

                    $timeout(function () {

                        $scope.showSaveTaskFormMsg = false;

                    }, 5000);
                });
            }


        };

        $scope.addEventTimeline = function () {

            if($scope.eventForm.$invalid) return;

            timeline.addTimelineEvent($scope.task.id, $scope.timelineEvent, function (timeline) {
                $scope.timeline = timeline;
                $scope.timelineEvent = {};

                $scope.newEventCreatedMsg = true;
                $scope.eventForm.$setUntouched();
                $scope.eventForm.$submitted = false;

                $timeout(function () {

                    $scope.newEventCreatedMsg = false;

                }, 5000);
            });

        };

        $scope.deleteTask = function () {

            if(!$scope.task.id) return;

            if(!confirm('Czy na pewno chcesz usunąć to zlecenie?')) return;

            tasks.deleteTask($scope.task.id, function () {
             alert('Zlecenie zostało poprawnie usunięte');
             $location.path('/#/tasks');
         });

        };

    }]);
})();
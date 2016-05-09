(function(){

    var app = angular.module('crmService', []);

    app.factory('routeChecker', ['$location', function($location){
        return {
            isActive: function (location) {
                return (-1 !== $location.path().indexOf(location));
            }
        };
    }])

    app.factory('tasks', ['$http', function($http){

        var _getTasks = function (callback) {

            callback = callback||function(){};

            $http.get('/api.php/tasks')
                .success(function (data) {
                    callback(data);
                });
        };

        var _getTask = function (taskId, success, error) {

            success = success||function(){};
            error = error||function(){};

            $http.get('/api.php/task/'+taskId)
                .success(function (data) {
                    success(data);
                })
                .error(error);

        };

        var _updateTask = function (taskId, taskData, success) {

            success = success||function(){};

            $http.put('/api.php/task/'+taskId, taskData)
                    .success(success);

        };

        var _saveNewTask = function (taskData, success) {

            success = success||function(){};

            $http.post('/api.php/task', taskData)
                .success(function (data) {

                    success(data.task);

                });

        };

        var _deleteTask = function (taskId, success) {

            success = success||function(){};

            $http.delete('/api.php/task/'+taskId)
                .success(success);

        };

        return {
            getTasks: _getTasks,
            getTask: _getTask,
            updateTask: _updateTask,
            deleteTask: _deleteTask,
            saveNewTask: _saveNewTask
        };
    }]);

    app.factory('users', ['$http', function($http){

        var _getUsers = function (callback) {

            callback = callback||function(){};

            $http.get('/api.php/users')
                .success(function (data) {
                    callback(data);
                });

        };

        return {
            getUsers: _getUsers
        };
    }]);

    app.factory('status', ['$http', function($http){

        var _getStatus = function (callback) {

            callback = callback||function(){};

            $http.get('/api.php/status')
                .success(function (data) {
                    callback(data);
                });

        };

        return {
            getStatus: _getStatus
        };
    }]);
     app.factory('login', ['$http', function($http){

        var _getLogin = function (callback) {

            callback = callback||function(){};

            $http.get('/api.php/login')
                .success(function (data) {
                    callback(data);
                });

        };

        return {
            getLogin: _getLogin
        };
    }]);

    app.factory('timeline', ['$http', function($http){

        var helperOptions = {
            'phone': {
                color: 'blue',
                message: 'Rozpoczynam wykonywanie zlecenia'
            },
            'envelope-o': {
                color: 'green',
                message: 'Jestem w trakcie wykonywania zlecenia/swojej części zlecenia'
            },
            'users': {
                color: 'purple',
                message: 'Ukończyłem zlecenie/swoją część zlecenia'
            },
            'file-text-o': {
                color: 'red',
                message: 'Wstrzymuję realizację zlecenia/swojej części zlecenia'
            }
        };

        var eventTypes = [
            {
                value: 'phone',
                name: 'Rozpoczynam wykonywanie'
            },
            {
                value: 'envelope-o',
                name: 'Jestem w trakcie wykonywania'
            },
            {
                value: 'users',
                name: 'Ukończyłem zlecenie'
            },
            {
                value: 'file-text-o',
                name: 'Wstrzumuję realizację'
            }
        ];

        var _timelineHelper = function (contactType, option) {

            return helperOptions[contactType][option];

        };

        var __parseTimeline = function (timeline) {

            angular.forEach(timeline, function (element, index) {
                element['control_date'] = new Date(element['control_date']);
            });

            return timeline;
        };

        var _getTaskTimeline = function (taskId, success) {

            success = success||function(){};

            $http.get('/api.php/task/'+taskId+'/timeline')
                .success(function (timeline) {

                    timeline = __parseTimeline(timeline);

                    success(timeline);

                });
        };

        var _addTimelineEvent = function (taskId, eventData, success) {

            success = success||function(){};

            $http.post('/api.php/task/'+taskId+'/timeline', eventData)
                .success(function (data) {

                    var timeline = __parseTimeline(data.timeline);
                    success(timeline);

                });

        };

        return {
            getTaskTimeline: _getTaskTimeline,
            getTimelineHelper: function () {
                return _timelineHelper;
            },
            getEventTypes: function () {
                return eventTypes;
            },
            addTimelineEvent: _addTimelineEvent
        };
    }])

})();
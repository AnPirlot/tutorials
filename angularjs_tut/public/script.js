// this is a controller module which consumes the rest service
var TasksModule = angular.module('tasksApp', []);

TasksModule.controller('getTasks', function($scope, $http) {

    $http.get('http://localhost:8070/tasks').
        then(function(response) {
            $scope.tasks = response.data;
        });

});

TasksModule.controller('postTasks', function ($scope, $http) {

    $scope.SendData = function () {
       // use $.param jQuery function to serialize data from JSON 
        var data = $.param({
            begin_date: $scope.begin_date,
            end_date: $scope.end_date,
            name: $scope.name
        });
    
        var config = {
            headers : {
                'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8;'
            }
        }

        $http.post('http://localhost:8070/tasks', data, config)
        .success(function (data, status, headers, config) {
            $scope.PostDataResponse = data;
        })
        .error(function (data, status, header, config) {
            $scope.ResponseDetails = "Data: " + data +
                "<hr />status: " + status +
                "<hr />headers: " + header +
                "<hr />config: " + config;
        });
    };

});

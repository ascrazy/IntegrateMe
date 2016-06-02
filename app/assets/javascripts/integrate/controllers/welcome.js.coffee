angular.module('integrate').controller('WelcomeController', ($scope, $http) ->
  self = @

  @init = (data) ->
    self.competitions = data.competitions
    self.new_competition = { name: '', requires_entry_name: true }

  @create_competition = () ->
    self.errors = null
    $http.post("/api/competitions", { competition: self.new_competition }).
      success((data, status, headers, config) ->
        self.competitions.unshift(data);
        self.new_competition = {}
      ).
      error((data, status, headers, config) ->
        if data.errors
          self.errors = data.errors
        else
          alert("SERVER ERROR: #{status}")
      )

  self
)

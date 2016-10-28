app.factory("Product", function($resource) {
  return $resource("/products/:id.json", { id: "@id" },
    {
      'create':  { method: 'POST' },
      'index':   { method: 'GET', isArray: true },
      'show':    { method: 'GET', isArray: false },
      'update':  { method: 'PUT' },
      'destroy': { method: 'DELETE' }
    }
  );
});

app.controller('ProductsController', ['$scope', '$route', '$routeParams', '$resource', 'Product',
  function ($scope, $route, $routeParams, $resource, Product) {

    $scope.products = Product.index();

    $scope.submit_product = function(new_product) {
      Product.create(new_product,
        function() {
          $route.reload();
        }
      );
    }

}]);


app.controller('ProductsShowController', ['$scope', '$routeParams', '$resource', '$location', 'Product',
  function ($scope, $routeParams, $resource, $location, Product) {

    $scope.product = Product.show({ id: $routeParams.id },
      function() {},
      function() {
        $location.path("/");
      }
    );

    $scope.remove_product = function() {
      Product.destroy({ id: $routeParams.id },
        function() {
          $location.path("/");
        }
      );
    }

}]);


app.controller('ProductsEditController', ['$scope', '$routeParams', '$resource', '$location', 'Product',
  function ($scope, $routeParams, $resource, $location, Product) {

    $scope.product = Product.show({ id: $routeParams.id },
      function() {},
      function() {
        $location.path("/");
      }
    );

    $scope.submit_product = function(updated_product) {
      Product.update(updated_product,
        function() {
          $location.path("/products/" + $routeParams.id);
        }
      );
    }

}]);
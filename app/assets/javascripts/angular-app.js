var app = angular.module('pla', ['ngRoute', 'ngResource', 'templates']);

app.config(function($httpProvider) {
  $httpProvider.defaults.headers.common['X-CSRF-Token'] =
    $('meta[name=csrf-token]').attr('content');
});

app.config(function($routeProvider, $locationProvider) {
  $locationProvider.html5Mode(true);
  $routeProvider
    .when("/",
      { templateUrl: 'products.html',
        controller: "ProductsController" })
    .when("/products/:id",
      { templateUrl: "product.html",
        controller: "ProductsShowController" })
    .when("/products/:id/edit",
      { templateUrl: "product_edit.html",
        controller: "ProductsEditController" })
});

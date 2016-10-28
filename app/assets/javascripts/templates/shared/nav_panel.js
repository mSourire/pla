app.directive("navpanel", function() { 
    return { 
        template: '\
        <nav class="navbar navbar-dark bg-inverse" style="margin-bottom: 20px;">\
  <div class="navbar-header">\
     <a class="navbar-brand" href="/">Products</a>\
  </div> \
  <button class="navbar-toggler hidden-lg-up pull-xs-right" type="button" data-toggle="collapse" data-target="#exCollapsingNavbar">\
    &#9776;\
  </button>\
  <div class="collapse navbar-toggleable-md" id="exCollapsingNavbar">\
    <ul class="nav navbar-nav pull-md-right">\
      <li class="nav-item active">\
        <a class="nav-link" href="/">Home <span class="sr-only">(current)</span></a>\
      </li>\
    </ul>\
  </div>\
</nav>'
    }; 
})

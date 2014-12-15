<%@ page import="java.util.ArrayList" %>
<%@ page import="clean.WikiPage" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Search Engine for Wikipedia named entities">
    <meta name="author" content="Thomas TRIBOULT">
    
	<title>WikiSearch &mdash; Results for '<%=request.getAttribute("q") %>'</title>
	
	<!-- Bootstrap Core CSS -->
    <link href="<%=request.getServletContext().getContextPath() + "/ui/css/bootstrap.min.css" %>" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="<%=request.getServletContext().getContextPath() + "/ui/css/stylish-portfolio.css" %>" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="<%=request.getServletContext().getContextPath() + "/ui/font-awesome-4.1.0/css/font-awesome.min.css" %>" rel="stylesheet" type="text/css">
    <link href="http://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
	<nav class="navbar navbar-inverse navbar-static-top" role="navigation">
	  <div class="container-fluid">
	    <div class="navbar-header">
	      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
	        <span class="sr-only">Toggle navigation</span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	      </button>
	      <a class="navbar-brand" href="<%=request.getServletContext().getContextPath() %>">WikiSearch</a>
	    </div>
	    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	      <form class="navbar-form navbar-right" method="get" action="" role="search">
	        <div class="form-group">
				<div class="input-group">
		          	<input type="text" value="<%=request.getAttribute("q") %>" name="q" class="form-control" placeholder="Search">
					<span class="input-group-btn">
		           		<button type="submit" class="btn btn-success">Go!</button>
		           	</span>
		        </div>
	        </div>
	      </form>
	    </div>
	  </div>
	</nav>
	<div class="container">
		<div class="row">
			<div class="col-md-8">
				<% if (request.getAttribute("error") != null) { %>
					<div class="alert alert-danger">
						<strong>Error!</strong> Unable to perform the request : <%=request.getAttribute("error") %>
					</div>
				<% } else {
						ArrayList<WikiPage> results = (ArrayList<WikiPage>) request.getAttribute("res");
						int i=0;
						for (WikiPage result : results) { %>
					<div class="media">
						<a class="media-left" href="<%=result.getUri() %>">
							<img src="http://placehold.it/64/AAAAAA/000000&amp;text=No+Image" style="width: 64px; height: 64px;" alt="<%=result.getTitle() %> result">
						</a>
						<div class="media-body">
							<h4 class="media-heading"><a href="<%=result.getUri() %>"><%=result.getTitle() %></a></h4>
							<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal<%=i %>">Show linked entities</button>
							<div class="modal fade" id="modal<%=i %>" tabindex="-1" role="dialog" aria-labelledby="modalLabel<%=i %>" aria-hidden="true">
							  <div class="modal-dialog modal-lg">
							    <div class="modal-content">
							      <div class="modal-header">
							        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
							        <h4 class="modal-title" id="modalLabel<%=i %>"><%=result.getTitle() %> article linked entities</h4>
							      </div>
							      <div class="modal-body">
							        <p>
							        	<% for (String entity : result.getEntities()) { %>
							        		<a href="http://fr.wikipedia.org/wiki/<%=entity.replace(" ", "_") %>"><%=entity %></a> | 
							        	<% } %>
							        </p>
							      </div>
							      <div class="modal-footer">
							        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
							      </div>
							    </div>
							  </div>
							</div>
						</div>
					</div>
					 	<%  i++;
					    }
				   } %>
			</div>
		</div>
		<% if (request.getAttribute("pages") != null && (int) request.getAttribute("pages") > 1) { %>
		<div class="row">
			<div class="col-sm-12">
				<nav class="text-center">
				  <ul class="pagination">
				  	<% for (int i=1; i < (int) request.getAttribute("pages"); i++) { %>
				  		<% if (i==(int)request.getAttribute("currentPage")) { %>
				  			<%="<li class=\"active\">" %>
				  		<% } else { %>
				  			<%="<li>" %>
				  		<% } %>
							<a href="<%=request.getServletContext().getContextPath() %>?q=<%=request.getAttribute("q") %>&page=<%=i %>"><%=i %></a>
						</li>
				    <% } %>
				  </ul>
				</nav>
			</div>
		</div>
		<% } %>
	</div>
	<!--<header id="top" class="header">
        <div class="text-vertical-center">
        	<div class="container">
        		<div class="row">
        			<div class="col-md-8 col-md-offset-2 col-sm-12">
			            <h1>Wikipedia named entities</h1>
			            <form method="get" action="">
				            <div class="input-group input-group-lg">
				            	<input type="search" placeholder="Type a query" name="q" class="form-control" />
				            	<span class="input-group-btn">
				            		<button class="btn btn-primary" type="button">Go!</button>
				            	</span>
				            </div>
			            </form>
        			</div>
        		</div>
        	</div>
        </div>
    </header>-->

    <script src="<%=request.getServletContext().getContextPath() + "/ui/js/jquery.js" %>"></script>
    <script src="<%=request.getServletContext().getContextPath() + "/ui/js/bootstrap.min.js" %>"></script>
	<script src="<%=request.getServletContext().getContextPath() + "/ui/js/wikipedia.js" %>"></script>
    <script>
    $(function(){
    	$(".media-heading").each(function(){
    		var uri = $(this).find('a').first().attr('href').trim().split("/"),
    			resource = uri[uri.length - 1];
    		
    		dbpedia.getInfoRessource(resource, function(results, $dest){
    			var data = results[0],
    				abst = (data.abstract.value.length > 445 ? data.abstract.value.substring(0, 445) + '...' : data.abstract.value);
    			$dest.find("h4").first().after('<p class="abstract">' + abst + '</p>');
    			if (data.thumbnail) {
    				// Test if image
    				$.ajax({
    					type: "head",
    					url: data.thumbnail.value,
    					success: function(msg, text, resp) {
    						var imageRegEx = /^image/i;
    						if (imageRegEx.test(resp.getResponseHeader("Content-Type"))) {
    							$dest.parent().find("img")
    		        				.first().attr('src', data.thumbnail.value);
    						}
    					}
    				});
    			}
    		}, $(this).parent());
    	});
    });
    // Closes the sidebar menu
    $("#menu-close").click(function(e) {
        e.preventDefault();
        $("#sidebar-wrapper").toggleClass("active");
    });

    // Opens the sidebar menu
    $("#menu-toggle").click(function(e) {
        e.preventDefault();
        $("#sidebar-wrapper").toggleClass("active");
    });

    // Scrolls to the selected menu item on the page
    $(function() {
        $('a[href*=#]:not([href=#])').click(function() {
            if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') || location.hostname == this.hostname) {
                var target = $(this.hash);
                target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
                if (target.length) {
                    $('html,body').animate({
                        scrollTop: target.offset().top
                    }, 1000);
                    return false;
                }
            }
        });
    });
    </script>
</body>
</html>
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
    
	<title>WikiSearch</title>
	
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
	<header id="top" class="header">
        <div class="text-vertical-center">
        	<div class="container">
        		<div class="row">
        			<div class="col-md-8 col-md-offset-2 col-sm-12">
			            <h1>Wikipedia named entities</h1>
			            <form method="get" action="" role="search">
				            <div class="input-group input-group-lg">
				            	<input type="search" placeholder="Type a query" name="q" class="form-control" />
				            	<span class="input-group-btn">
				            		<button class="btn btn-primary" type="submit">Go!</button>
				            	</span>
				            </div>
			            </form>
        			</div>
        		</div>
        	</div>
        </div>
    </header>
	<!-- jQuery -->
    <script src="<%=request.getServletContext().getContextPath() + "/ui/js/jquery.js" %>"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="<%=request.getServletContext().getContextPath() + "/ui/js/bootstrap.min.js" %>"></script>

    <!-- Custom Theme JavaScript -->
    <script>
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
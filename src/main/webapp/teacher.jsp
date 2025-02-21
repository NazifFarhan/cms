<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	
	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	
	<link rel="stylesheet" href="./latest.css">
	
<title>Dashboard</title>
</head>
<body>
	<%
		/* Authentication check */
		
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); 
		
		if( session.getAttribute("userType") == null )
			response.sendRedirect("login.jsp");
		else	{
			String userType = (String) session.getAttribute("userType");
			String nextPage = userType+".jsp";
			if(nextPage.equals("teacher.jsp") == false)
				response.sendRedirect(nextPage);
		}
		
	%>

 <!-- The sidebar -->
<div class="sidebar">
  <a class="active" href="teacher.jsp">Home</a>
  <a href="teacherCourses.jsp" style="margin-bottom: 15px;">View Running Courses</a>
    <hr style=" background-color: white; margin: -1px;">
  <a href="Logout" style="margin-top: 15px;">Logout</a>
</div>

<!-- Page content -->
<div class="content">
<div class="d-flex justify-content-center"><h2>Welcome, <%= (String) session.getAttribute("name") %> !</h2></div>
</div> 

</body>
</html>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head lang="en">
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
			if(nextPage.equals("admin.jsp") == false)
				response.sendRedirect(nextPage);
		}
		
	%>

 <!-- The sidebar -->
<div class="sidebar">
  <a class="active" href="#">Home</a>
  <a href="adminAddCourse.jsp">Add New Course</a>
  <a href="adminDeleteCourse.jsp"> Delete Course</a>
  <a href="adminAssignTeacher.jsp">Assign Teacher To Course</a>
  <a href="adminReassignTeacher.jsp" style="margin-bottom: 15px;">Change Course Teacher</a>
  <hr style=" background-color: white; margin: -1px;">
  <a href="Logout" style="margin-top: 15px;">Logout</a>
</div>

<!-- Page content -->
<div class="content">
<div class="d-flex justify-content-center"><h2>Welcome, <%= (String) session.getAttribute("name") %> !</h2></div>
</div> 

</body>
</html>
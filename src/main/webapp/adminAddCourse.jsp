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

<title>Add New Course</title>
</head>
<body>

	<%
		/* Authentication check */
		
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); 
		
		if( session.getAttribute("userType") == null )
			response.sendRedirect("login.jsp");
		else	{
			String userType = (String) session.getAttribute("userType");
			String nextPage = userType+"AddCourse.jsp";
			if(nextPage.equals("adminAddCourse.jsp") == false)
				response.sendRedirect(nextPage);
		}
	%>
 <!-- The sidebar -->
<div class="sidebar">
  <a href="admin.jsp">Home</a>
  <a class="active" href="adminAddCourse.jsp">Add New Course</a>
  <a href="adminDeleteCourse.jsp">Delete Course</a>
  <a href="adminAssignTeacher.jsp">Assign Teacher To Course</a>
  <a href="adminReassignTeacher.jsp" style="margin-bottom: 15px;">Change Course Teacher</a>  <hr style=" background-color: white; margin: -1px;">
  <a href="Logout" style="margin-top: 15px;">Logout</a>
</div>

<div class="content">
<form action="AddCourse" method="post">
 <table class="table table-bordered table-hover">
  <thead>
    <tr>
      <th scope="col">Course ID</th>
      <th scope="col">Title</th>
      <th scope="col">Credits</th>
      <th scope="col">Semester</th>
    </tr>
  </thead>
  <tbody>
  	<tr>
  		<td scope="row"><input type="text" name="course_id" required></td>
  		<td><input type="text" name="title" required></td>
  		<td><input type="number" step="0.01" min="1" name="credits" required></td>
  		<td>
  		<select name="semester" class="form-select" aria-label="Default select example" required>
		  <option value="1-1">1-1</option>
		  <option value="1-2">1-2</option>
		  <option value="2-1">2-1</option>
		  <option value="2-2">2-2</option>
		  <option value="3-1">3-1</option>
		  <option value="3-2">3-2</option>
		  <option value="4-1">4-1</option>
		  <option value="4-2">4-2</option>
		  <option value="M-1">M-1</option>
		  <option value="M-2">M-2</option>
		</select>
		</td>
<!--   		<input type="text" name="semester" required></td> -->
  	</tr>
  </tbody>
  
</table>
  		<div class="d-flex justify-content-center"><button type="submit" class="btn btn-primary d-flex justify-content-center" >Add Course</button><br></div>
</form>

	<%
		/* Course Added Message */ 
			if(session.getAttribute("courseExists") != null)	{
	%>	
			<div class="alert alert-danger" role="alert" style="text-align: center;">
  				Course ID already exists!
			</div>
	<%		
				session.removeAttribute("courseExists");
			}
			else if(session.getAttribute("courseAdded") != null)	{
	%>
			<div class="alert alert-success" role="alert" style="text-align: center;">
  				Course added successfully!
			</div>
	<% 
				session.removeAttribute("courseAdded");
			}
	%>
</div>	
	

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

</body>
</html>
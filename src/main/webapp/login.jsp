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

<title>Course Management System</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css?family=Assistant:400,700" rel="stylesheet">
<link rel="stylesheet" href="./style.css">

</head>
<body>
	
	<%
		/* Authentication check */
		
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); 
		if( session.getAttribute("userType") != null )	{
			String userType = (String) session.getAttribute("userType");
			response.sendRedirect(userType+".jsp");
		}
			
	%>
	
<section class='login' id='login'>
  <div class='head'>
  <h1 class='company'>Course Management System</h1>
  </div>
  <br><br>
<!--   <p class='msg'>Sign In</p> -->
  <div class='form'>
    <form action="Login" method="Post">
  <input name="uname" type="text" placeholder='Username' class='text' required><br>
  <input name="pwd" type="password" placeholder='Password' class='password' id="id_password" required><br>
<!-- <input type="checkbox" onclick="myFunction()">Show Password <br> -->
<!--   <input name="utype" type="text" placeholder='Select Role' class='text' required><br> -->

<select name="utype" class="form-select" aria-label="Default select example" required>
  <option disabled>Select Role</option>
  <option name ="utype" value="student">Student</option>
  <option name ="utype" value="teacher">Teacher</option>
  <option name ="utype" value="admin">Admin</option>
</select><br>
	
	<div style="display: flex; justify-content: around;">
  <input style="cursor: pointer; border: 0px; position: relative; left: 158px; top: 2px;" type="submit" class='btn-login' value="Login">
<!--   <a href="Login" class="btn-login" id="do-login">Login</a> -->
  <a href="register.jsp" class='btn-login' style="text-align: center; position: relative; left: 173px; top: 2px;">Register</a>
    </div>
    </form>
  </div>
<%
	if(session.getAttribute("invalidCred") != null)	{
%>		
		<div class="alert alert-danger rounded" role="alert" style="text-align: center;  position: relative; top: 20px;">
			Invalid Credentials!
		</div>
<% 
		session.removeAttribute("invalidCred");
	}
%>
</section>


	
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>


</body>
</html>
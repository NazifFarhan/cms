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

<title>Student List</title>
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
			if(userType.equals("teacher") == false)
				response.sendRedirect(nextPage);
		}
	%>

 <!-- The side-bar -->
<div class="sidebar">
  <a href="teacher.jsp">Home</a>
  <a class="active" href="teacherCourses.jsp" style="margin-bottom: 15px;">View Running Courses</a>
    <hr style=" background-color: white; margin: -1px;">
  <a href="Logout" style="margin-top: 15px;">Logout</a>
</div>

	<%
		/* Query */ 
		
		
		try	{
			String url = "jdbc:mysql://localhost:3306/course_management";
			String dbms_user = "root";
			String dbms_pass = "root";
		
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, dbms_user, dbms_pass);
			Statement st = con.createStatement();
			
	%>
	
<!-- Page content -->
<div class="content">

		<!-- List of students enrolled in course -->
<h2> Students enrolled in <b><%=request.getParameter("course_id")%></b>:</h2>
		<table class="table table-bordered">
		  <thead>
		    <tr>
		      <th scope="col">Student ID</th>
		      <th scope="col">Name</th>
		      <th scope="col">Department</th>
		    </tr>
		  </thead>
		  <tbody>
		  <% 
		    String course_id = request.getParameter("course_id");
		  	String sql = String.format("SELECT ID, name, dept_name FROM student WHERE ID IN (SELECT ID FROM takes WHERE course_id='%s');", course_id);
	    	ResultSet student = st.executeQuery(sql);
		  	while(student != null && student.next())	{ 
		  %>
	  	    <tr>
		      <th scope="row"><%=student.getString(1)%></th>
		      <td><%=student.getString(2)%></td>
		      <td><%=student.getString(3)%></td>
		    </tr>
	      <% } 
	      	student.close();
	      %>
		  </tbody>
		
		</table>
		
	
</div> 

	<%
		st.close();
		con.close();
	
		}	catch(Exception e)	{
			e.printStackTrace();
		}
	%>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

</body>
</html>
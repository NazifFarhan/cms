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

<title>Reassign Teacher</title>
</head>
<body>

	<%
		/* Authentication check */
		
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); 
		
		if( session.getAttribute("userType") == null )
			response.sendRedirect("login.jsp");
		else	{
			String userType = (String) session.getAttribute("userType");
			String nextPage = userType+"ReassignTeacher.jsp";
			if(nextPage.equals("adminReassignTeacher.jsp") == false)
				response.sendRedirect(nextPage);
		}
	%>

 <!-- The sidebar -->
<div class="sidebar">
  <a href="admin.jsp">Home</a>
  <a href="adminAddCourse.jsp">Add New Course</a>
  <a href="adminDeleteCourse.jsp"> Delete Course</a>
  <a href="adminAssignTeacher.jsp"> Assign Teacher To Course </a>
  <a class="active" href="adminReassignTeacher.jsp" style="margin-bottom: 15px;">Change Course Teacher</a>
  <hr style=" background-color: white; margin: -1px;">
    
  <a href="Logout" style="margin-top: 15px;">Logout</a>
</div>

	<%
		/* Query */ 
//		String userType = (String) session.getAttribute("userType");
		String ID = (String) session.getAttribute("ID");
		
		try	{
			String url = "jdbc:mysql://localhost:3306/course_management";
			String dbms_user = "root";
			String dbms_pass = "root";
		
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, dbms_user, dbms_pass);
			Statement st = con.createStatement();
			
			String query = "SELECT * FROM course WHERE course_id IN(SELECT course_id FROM teaches)";
			ResultSet rs = st.executeQuery(query);
			
	%>

<div class="content">
	<%		
			if(session.getAttribute("courseReassigned") != null)	{
	%>
			<div class="alert alert-success" role="alert" style="text-align: center;">
  				Course reassigned successfully!
			</div>
	<% 
				session.removeAttribute("courseReassigned");
			}
	%>
 <table class="table table-bordered table-hover">
  <thead>
    <tr>
      <th scope="col">Course ID</th>
      <th scope="col">Title</th>
      <th scope="col">Credits</th>
      <th scope="col">Semester</th>
<!--       <th scope ="col">Course Teacher</th> -->
    </tr>
  </thead>
  <tbody>
  <% while(rs != null && rs.next())	{  %>
    <tr>
      <th scope="row"><%=rs.getString(1)%></td>
      <td><%=rs.getString(2)%></td>
      <td><%=rs.getString(3)%></td>
      <td><%=rs.getString(4)%></td>
<%--       <td><%=rs.getString(5)%></td> --%>
      <td> 
      	<form action="reassign.jsp" method="post">
      	<button type="submit" class="btn btn-primary" name="course_id" value="<%=rs.getString(1)%>">
  			Reassign
	  	</button> 
	  	</form>
	  </td>
    </tr>
      <%  } %>
  </tbody>
  	<%
	 		rs.close();
	 		st.close();
	 		con.close();
	
 		}	catch(Exception e)	{
 			e.printStackTrace();
 		}
	%>
</table>
</div>




<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

</body>
</html>
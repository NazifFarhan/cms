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

<title>Running Courses</title>
</head>
<body>

	<%
		/* Authentication check */
		
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); 
		
		if( session.getAttribute("userType") == null )
			response.sendRedirect("login.jsp");
		else	{
			String userType = (String) session.getAttribute("userType");
			String nextPage = userType+"Courses.jsp";
			if(nextPage.equals("teacherCourses.jsp") == false)
				response.sendRedirect(nextPage);
		}
	%>

 <!-- The sidebar -->
<div class="sidebar">
  <a href="teacher.jsp">Home</a>
  <a class="active" href="teacherCourses.jsp" style="margin-bottom: 15px;">View Running Courses</a>
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
			
			String query = String.format("SELECT * FROM course WHERE course_id in (SELECT course_id FROM teaches WHERE ID='%s')", ID);
			ResultSet rs = st.executeQuery(query);
			
	%>
	
<!-- Page content -->
<div class="content">

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
  <% while(rs != null && rs.next())	{  %>
    <tr>
      <th scope="row"><%=rs.getString(1)%></th>
      <td><%=rs.getString(2)%></td>
      <td><%=rs.getString(3)%></td>
      <td><%=rs.getString(4)%></td>
      <td>
      	<form action="viewStudents.jsp">
      	<button class="btn btn-primary" name="course_id" type="submit" value="<%=rs.getString(1)%>">
      		View Students
      	</button>
      	</form>
      </td>
    </tr>
    <%
  		}
    %>
  </tbody>
</table>
	
</div> 
	<%
		rs.close();
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
package com.course;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

@WebServlet("/AssignTeacher")
public class AssignTeacher extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try	{
			String url = "jdbc:mysql://localhost:3306/course_management";
			String dbms_user = "root";
			String dbms_pass = "root";
		
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, dbms_user, dbms_pass);
			Statement st = con.createStatement();
			
			String teacher_id = request.getParameter("teacher_id");
			String course_id = request.getParameter("course_id");
			
			String update = String.format("INSERT INTO teaches VALUES('%s', '%s')", teacher_id, course_id); 
			st.executeUpdate(update);
			
			request.getSession().setAttribute("courseAssigned", true);
			
      		st.close();
      		con.close();
      		
			response.sendRedirect("adminAssignTeacher.jsp");
	
		
		}	catch(Exception e)	{
			e.printStackTrace();
		}
	}
}

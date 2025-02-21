package com.course;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.*; 

@WebServlet("/DeleteCourse")
public class DeleteCourse extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try	{
			String url = "jdbc:mysql://localhost:3306/course_management";
			String dbms_user = "root";
			String dbms_pass = "root";
		
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, dbms_user, dbms_pass);
			Statement st = con.createStatement();
			
			String course_id = request.getParameter("course_id");
			
			String update = String.format("DELETE FROM course WHERE course_id='%s'", course_id);
			st.executeUpdate(update);
			
			HttpSession session = request.getSession();
			
			session.setAttribute("courseDeleted", true);
			
			st.close();
			con.close();
			
			response.sendRedirect("adminDeleteCourse.jsp");
			
		}	catch(Exception e)	{
			e.printStackTrace();
		}
	}

}

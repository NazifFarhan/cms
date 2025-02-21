package com.course;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.*; 

@WebServlet("/AddCourse")
public class AddCourse extends HttpServlet {
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
			String title = request.getParameter("title");
			String credits = request.getParameter("credits");
			String semester = request.getParameter("semester");
			
			String query = String.format("SELECT * FROM course WHERE course_id='%s'", course_id);
			ResultSet rs = st.executeQuery(query);
			
			HttpSession session = request.getSession();
			
			if(rs.next())	{
				session.setAttribute("courseExists", true);
			}
			else	{
				String update = String.format("INSERT INTO course VALUES('%s', '%s', %s, '%s')", course_id, title, credits, semester);
				st.executeUpdate(update);
				session.setAttribute("courseAdded", true);
			}
				
			
			rs.close();
			st.close();
			con.close();
			
			response.sendRedirect("adminAddCourse.jsp");
			
		}	catch(Exception e)	{
			e.printStackTrace();
		}
	}

}

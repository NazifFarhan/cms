package com.course;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.*;
@WebServlet("/EnrollStudent")
public class EnrollStudent extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try	{
			String url = "jdbc:mysql://localhost:3306/course_management";
			String dbms_user = "root";
			String dbms_pass = "root";
		
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, dbms_user, dbms_pass);
			Statement st = con.createStatement();
			
			HttpSession session = request.getSession();
			
			String ID = (String) session.getAttribute("ID");
			String course_id = request.getParameter("course_id");
			
			System.out.println(ID+" "+course_id);	
			String enrollUpdate = String.format("INSERT INTO takes VALUES('%s', '%s')", ID, course_id);
    		st.executeUpdate(enrollUpdate);
    		
    		st.close();
    		con.close();
    		
    		session.setAttribute("enrolled", true);
    		response.sendRedirect("studentEnroll.jsp");
    		
		}	catch(Exception e)	{
			e.printStackTrace();
		}
	}

}

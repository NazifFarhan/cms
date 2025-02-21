package com.register;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Register")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
try	{
			
			String url = "jdbc:mysql://localhost:3306/course_management";
			String dbms_user = "root";
			String dbms_pass = "root";
		
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, dbms_user, dbms_pass);
			Statement st = con.createStatement();
			
			String name = request.getParameter("full_name");
			String username = request.getParameter("uname");
			String password = request.getParameter("pwd");
			String dept_name = request.getParameter("department");
			String ID = request.getParameter("ID");
			String userType = request.getParameter("utype");			
			
			String query = String.format("SELECT ID FROM %s WHERE ID='%s'", userType, ID);
			ResultSet rs = st.executeQuery(query);
			
			HttpSession session = request.getSession();
			if(rs.next())	{
				session.setAttribute("invalidRegister", true);
			}
			else {
				session.setAttribute("allowRegister", true);
				String update = String.format("INSERT INTO %s VALUES('%s', '%s', '%s', '%s', '%s')", userType, username, password, ID, name, dept_name);
				st.executeUpdate(update);
			}
			
			rs.close();
			st.close();
			con.close();
			
			
			response.sendRedirect("register.jsp");
		}	catch(Exception e)	{
			e.printStackTrace();
		}
	
	}

}

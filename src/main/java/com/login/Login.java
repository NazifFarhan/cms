package com.login;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try	{
			
			String username = request.getParameter("uname");
			String password = request.getParameter("pwd");
			String userType = request.getParameter("utype").toLowerCase();
			
			String url = "jdbc:mysql://localhost:3306/course_management";
			String dbms_user = "root";
			String dbms_pass = "root";
					
			String query = String.format("SELECT * FROM %s", userType);
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, dbms_user, dbms_pass);
			Statement st = con.createStatement();
			
			ResultSet rs = st.executeQuery(query);
			
			boolean allowLogin = false;
			String ID = null, name = null;
			
			while(rs.next())	{
				String auth_user = rs.getString(1);
				String auth_pass = rs.getString(2);
				ID = rs.getString(3);
				name = rs.getString(4);
				
//				System.out.println(auth_user);
//				System.out.println(auth_pass);
//				System.out.println(ID);
				if(username.equals(auth_user) && password.equals(auth_pass))	{
					allowLogin = true;
					break;
				}
					
			}
			
			rs.close();		
			st.close();
			con.close();
			
			HttpSession session = request.getSession();
			
			if(allowLogin) {
				
				session.setAttribute("userType", userType);
				session.setAttribute("ID", ID);
				session.setAttribute("name", name);
//				System.out.println("HERE");
				String nextPage = userType+".jsp";
				response.sendRedirect(nextPage);
			}
			else {
				session.setAttribute("invalidCred", true);				
				response.sendRedirect("login.jsp");
			}
		}	catch(Exception e)	{
			e.printStackTrace();
		}


		

			
	}


}

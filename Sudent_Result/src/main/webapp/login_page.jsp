<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Login Page</title>
</head>
<body>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    if (username != null && password != null) {
        try {
            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/kanase", "postgres", "Kana@7666");

            PreparedStatement psmt = con.prepareStatement("SELECT * FROM student_login WHERE username = ? AND password = ?");
            psmt.setString(1, username);
            psmt.setString(2, password);
            ResultSet rs = psmt.executeQuery();

            if (rs.next()) {
                response.sendRedirect("home_page.html");
            } else {
                response.sendRedirect("ragitration_page.html"); // fixed typo
            }

            rs.close();
            psmt.close();
            con.close();
        } catch (Exception e) {
            log("Login error", e); // logs to server logs
            out.println("<p style='color:red;'>An error occurred. Please try again later.</p>");
        }
    } else {
        out.println("<p style='color:red;'>Please provide username and password.</p>");
    }
%>
<%@ include file="footer.jsp" %>

</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Report Card</title>
    <style>
    		
    		
    </style>
</head>
<body>

<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String subject = request.getParameter("subject");
    String message = request.getParameter("message");
    
    Connection con = null;
    PreparedStatement psmt = null;
    try {
        Class.forName("org.postgresql.Driver");  // Load the driver
        String url = "jdbc:postgresql://localhost:5432/kanase";
        String user = "postgres";
        String pwd = "Kana@7666";
        con = DriverManager.getConnection(url, user, pwd);

        String Q = "INSERT INTO contact_from(name,email,subject,message) VALUES (?, ?, ?, ?)";
        psmt = con.prepareStatement(Q);
        psmt.setString(1, name);
        psmt.setString(2, email);
        psmt.setString(3, subject);
        psmt.setString(4, message);

        int i = psmt.executeUpdate();
        if (i > 0) {
            out.print("<center><h2>Entered Successfully</h2><center>");
        } else {
            out.print("<center><h3>Failed to Enter Data</h3></center>");
        }

    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        try { if (psmt != null) psmt.close(); } catch (Exception e) {}
        try { if (con != null) con.close(); } catch (Exception e) {}
    }
%>

<%@ include file="footer.jsp" %>

</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Report Card</title>
    <style>
    		h2{
    			color=green;
    		}
    		h3{
    			color=red;
    		}
    		
    </style>
</head>
<body>

<%
    String sname = request.getParameter("studentName");
    String srollN = request.getParameter("rollNumber");
    int sub1 = Integer.parseInt(request.getParameter("Marathi"));
    int sub2 = Integer.parseInt(request.getParameter("English"));
    int sub3 = Integer.parseInt(request.getParameter("Hindi"));
    int sub4 = Integer.parseInt(request.getParameter("Math"));
    int sub5 = Integer.parseInt(request.getParameter("History"));
    int sub6 = Integer.parseInt(request.getParameter("Science"));

    int total = sub1 + sub2 + sub3 + sub4 + sub5 + sub6;
    float percentage = (total / 600.0f) * 100;

    String grade = "";
    if (percentage >= 90) {
        grade = "A+";
    } else if (percentage >= 80) {
        grade = "A";
    } else if (percentage >= 70) {
        grade = "B";
    } else if (percentage >= 60) {
        grade = "C";
    } else if (percentage >= 50) {
        grade = "D";
    } else {
        grade = "F";
    }

    Connection con = null;
    PreparedStatement psmt = null;
    try {
        Class.forName("org.postgresql.Driver");  // Load the driver
        String url = "jdbc:postgresql://localhost:5432/kanase";
        String user = "postgres";
        String pwd = "Kana@7666";
        con = DriverManager.getConnection(url, user, pwd);

        String Q = "INSERT INTO Sudent_Data(sudent_name, roll_no, marathi, english, hindi, math, history, science, sumofmarks, percentage, grade) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        psmt = con.prepareStatement(Q);
        psmt.setString(1, sname);
        psmt.setString(2, srollN);
        psmt.setInt(3, sub1);
        psmt.setInt(4, sub2);
        psmt.setInt(5, sub3);
        psmt.setInt(6, sub4);
        psmt.setInt(7, sub5);
        psmt.setInt(8, sub6);
        psmt.setInt(9, total);
        psmt.setFloat(10, percentage);
        psmt.setString(11, grade);

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

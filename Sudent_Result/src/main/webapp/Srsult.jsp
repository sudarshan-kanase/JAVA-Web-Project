<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Report Card</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
        }
        table {
            border-collapse: collapse;
            margin: 20px auto;
            width: 50%;
        }
        th, td {
            border: 1px solid #000;
            padding: 10px;
        }
        th {
            background-color: #f2f2f2;
        }
        caption {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>

<%
    String sname = request.getParameter("sname");
    String srollN = request.getParameter("srollno");

    Connection con;
    PreparedStatement psmt;
    ResultSet rs;

    try {
        String url = "jdbc:postgresql://localhost:5432/kanase";
        String user = "postgres";
        String pwd = "Kana@7666";
        Class.forName("org.postgresql.Driver");
        con = DriverManager.getConnection(url, user, pwd);

        psmt = con.prepareStatement("SELECT * FROM Sudent_Data WHERE sudent_name = ? AND roll_no = ?");
        psmt.setString(1, sname);
        psmt.setString(2, srollN);
        rs = psmt.executeQuery();
        if (rs.next()) {
%>
    <table>
        <caption>Your Report Card</caption>
        <tr>
            <td><strong>Name:</strong></td>
            <td><%= rs.getString("sudent_name") %></td>
        </tr>
        <tr>
            <td><strong>Roll No:</strong></td>
            <td><%= rs.getString("roll_no") %></td>
        </tr>
        <tr><th>Subject</th><th>Marks</th></tr>
        <tr><td>Marathi</td><td><%= rs.getInt("marathi") %></td></tr>
        <tr><td>English</td><td><%= rs.getInt("english") %></td></tr>
        <tr><td>Hindi</td><td><%= rs.getInt("hindi") %></td></tr>
        <tr><td>Math</td><td><%= rs.getInt("math") %></td></tr>
        <tr><td>History</td><td><%= rs.getInt("history") %></td></tr>
        <tr><td>Science</td><td><%= rs.getInt("science") %></td></tr>
        <tr><td><strong>Total Marks</strong></td><td><%= rs.getInt("sumOfmarks") %></td></tr>
        <tr><td><strong>Percentage</strong></td><td><%= rs.getFloat("percentage") %> %</td></tr>
        <tr><td><strong>Grade</strong></td><td><%= rs.getString("grade") %></td></tr>
    </table>
<%
        } else {
            out.println("<p style='color:red;'>No student record found for the provided name and roll number.</p>");
        }

        rs.close();
        psmt.close();
        con.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    }
%>
<%@ include file="footer.jsp" %>

</body>
</html>

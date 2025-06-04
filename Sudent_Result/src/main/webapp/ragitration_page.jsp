<%@ page import="java.sql.*" %>
<%@ include file="header.jsp" %>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    try {
        Class.forName("org.postgresql.Driver");
        Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/kanase", "postgres", "Kana@7666");

        // Check if username already exists
        PreparedStatement check = con.prepareStatement("SELECT * FROM student_login WHERE username = ?");
        check.setString(1, username);
        ResultSet rs = check.executeQuery();

        if (rs.next()) {
            response.sendRedirect("login_page.html"); // You can show a message via query string if needed
        } else {
            // Insert new student login
            PreparedStatement ps = con.prepareStatement("INSERT INTO student_login (username, password) VALUES (?, ?)");
            ps.setString(1, username);
            ps.setString(2, password);  // In real apps, hash the password!
            ps.executeUpdate();
            ps.close();

            response.sendRedirect("home_page.html"); // Redirect to login after registration
        }

        rs.close();
        check.close();
        con.close();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
<%@ include file="footer.jsp" %>

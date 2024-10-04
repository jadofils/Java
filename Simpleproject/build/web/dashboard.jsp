<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.Base64"%>
<%@page import="Backend.Connections"%> <!-- Add this line with the correct package -->

<!DOCTYPE html>
<html>
<head>
    <title>Registration Result</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f8ff; /* Light blue background */
            color: #333;
            margin: 0;
            padding: 20px;
        }

        h1 {
            text-align: center;
            color: #007bff; /* Blue color for the main heading */
        }

        h2 {
            text-align: center;
            color: #0056b3; /* Darker blue for subheading */
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        th, td {
            border: 1px solid #007bff; /* Border color */
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #007bff; /* Blue header */
            color: white; /* White text */
        }

        tr:nth-child(even) {
            background-color: #e7f0ff; /* Light blue for even rows */
        }

        tr:hover {
            background-color: #d6e9ff; /* Hover effect */
        }

        a {
            display: inline-block;
            margin: 20px auto;
            padding: 10px 20px;
            background-color: #007bff; /* Button color */
            color: white; /* Button text color */
            text-decoration: none;
            border-radius: 5px;
            text-align: center;
        }

        a:hover {
            background-color: #0056b3; /* Darker blue on hover */
        }

        .logout-button {
            background-color: #dc3545; /* Red color for logout */
        }

        .logout-button:hover {
            background-color: #c82333; /* Darker red on hover */
        }
    </style>
</head>
<body>
    <h1>Registration Status List</h1>

    <%
        // Retrieve the message from session
        String message = (String) session.getAttribute("message");
        if (message != null) {
            out.println("<p style='text-align:center; color:#007bff;'>" + message + "</p>");
            // Remove the message from the session after displaying it
            session.removeAttribute("message");
        }

        // Database connection setup
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            // Assuming Connections class handles DB connections
            Connections c = new Connections();
            conn = c.getConnection(); // Get the database connection

            String query = "SELECT * FROM register"; // Query to fetch all records
            stmt = conn.createStatement();
            rs = stmt.executeQuery(query);

            // Displaying the records in a table
            out.println("<h2>Registered Users</h2>");
            out.println("<table>");
            out.println("<tr><th>ID</th><th>First Name</th><th>Last Name</th><th>Subscribe</th><th>Gender</th><th>Comments</th><th>Picture</th><th>Registration Date</th></tr>");

            while (rs.next()) {
                int id = rs.getInt("ID");
                String firstName = rs.getString("Firstname");
                String lastName = rs.getString("Lastname");
                boolean subscribe = rs.getBoolean("Subscribe");
                String gender = rs.getString("Gender");
                String comment = rs.getString("Comment");
                Blob picture = rs.getBlob("Picture");
                Timestamp registrationDate = rs.getTimestamp("Date");

                out.println("<tr>");
                out.println("<td>" + id + "</td>");
                out.println("<td>" + firstName + "</td>");
                out.println("<td>" + lastName + "</td>");
                out.println("<td>" + (subscribe ? "Yes" : "No") + "</td>");
                out.println("<td>" + gender + "</td>");
                out.println("<td>" + comment + "</td>");
                out.println("<td>");

                // Displaying picture if exists
                if (picture != null) {
                    out.println("<img src='data:image/jpeg;base64," + Base64.getEncoder().encodeToString(picture.getBytes(1, (int) picture.length())) + "' width='50' height='50' />");
                } else {
                    out.println("No Image");
                }

                out.println("</td>");
                out.println("<td>" + registrationDate + "</td>");
                out.println("</tr>");
            }

            out.println("</table>");
        } catch (SQLException e) {
            out.println("Error occurred: " + e.getMessage());
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>

    <a href="register.jsp">Go back to Registration Page</a>

</body>
</html>

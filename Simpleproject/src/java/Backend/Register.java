package Backend;

// Import necessary libraries for handling HTTP requests, file uploads, and database connections
import java.io.IOException; // For handling IO exceptions
import java.io.InputStream; // For reading uploaded files as streams
import javax.servlet.ServletException; // For servlet exceptions
import javax.servlet.annotation.MultipartConfig; // To configure the servlet for file uploads
import javax.servlet.annotation.WebServlet; // For servlet mapping
import javax.servlet.http.HttpServlet; // Base class for servlets
import javax.servlet.http.HttpServletRequest; // To handle HTTP requests
import javax.servlet.http.HttpServletResponse; // To handle HTTP responses
import javax.servlet.http.HttpSession; // For managing user sessions
import javax.servlet.http.Part; // To handle file parts in multipart requests
import java.sql.*; // For SQL operations

/**
 * Servlet implementation class Register
 * Handles user registration and file uploads
 * Author: JdFils-Salim
 */
@WebServlet(urlPatterns = {"/register"}) // Maps this servlet to the /register URL
@MultipartConfig // Allows the servlet to handle multipart/form-data, which is necessary for file uploads
public class Register extends HttpServlet {

    // Method to process the request from the client
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Set the content type of the response to HTML
        response.setContentType("text/html;charset=UTF-8");

        // Create a new session or retrieve the existing one
        HttpSession session = request.getSession(); // To store messages and data that persist across requests
        try {
            // Retrieve form data from the request
            String fname = request.getParameter("firstName"); // Get the first name from the form
            String lname = request.getParameter("lastName"); // Get the last name from the form
            // Check if the newsletter subscription checkbox is checked
            boolean subscribe = request.getParameter("NewsLetter") != null; // true if checked, false otherwise
            String gender = request.getParameter("gender"); // Get the gender from the form
            String message = request.getParameter("message"); // Get the user message from the form

            // Handle file upload
            Part filePart = request.getPart("profilePic"); // Retrieve the uploaded file part
            InputStream fileContent = null; // Input stream for the file content
            // Check if a file was uploaded
            if (filePart != null && filePart.getSize() > 0) {
                // Get the input stream of the uploaded file
                fileContent = filePart.getInputStream(); // Convert the uploaded file part to an InputStream
            }

            // Establish a database connection using a custom Connections class
            Connections c = new Connections(); // Create an instance of Connections to handle DB connection
            Connection conn = c.getConnection(); // Get the connection to the database
            // SQL query to insert a new user record into the register table
            String insertQuery = "INSERT INTO register(Firstname, Lastname, Subscribe, Gender, Comment, Picture) VALUES(?,?,?,?,?,?)";
            // Prepare the SQL statement to prevent SQL injection attacks
            PreparedStatement pst = conn.prepareStatement(insertQuery);

            // Set the values in the PreparedStatement (Index starts from 1)
            pst.setString(1, fname); // Set first name
            pst.setString(2, lname); // Set last name
            pst.setBoolean(3, subscribe); // Set subscription status
            pst.setString(4, gender); // Set gender
            pst.setString(5, message); // Set user message

            // If the file is uploaded, set it as a BLOB in the database, else set it to NULL
            if (fileContent != null) {
                pst.setBlob(6, fileContent); // Store the uploaded file in the database
            } else {
                pst.setNull(6, Types.BLOB); // Handle the case where no file was uploaded
            }

            // Execute the update and check how many rows were affected
            int rows = pst.executeUpdate(); // Execute the insert statement
            if (rows > 0) {
                // If the insertion was successful, store a success message in the session
                session.setAttribute("message", "User Registered Successfully");
            } else {
                // If the insertion failed, store a failure message in the session
                session.setAttribute("message", "Failed to Register User");
            }

        } catch (SQLException e) {
            // Handle any SQL exceptions and store the error message in the session
            session.setAttribute("message", "An error occurred: " + e.getMessage());
        }

        // Redirect the user to a JSP page to display the registration message
        response.sendRedirect("dashboard.jsp"); // Send the user to the dashboard page
    }

    // Handles GET requests
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response); // Process the request using the processRequest method
    }

    // Handles POST requests
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response); // Process the request using the processRequest method
    }

    // Returns a short description of the servlet
    @Override
    public String getServletInfo() {
        return "Short description"; // Provide a brief description of the servlet
    }

}

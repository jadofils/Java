<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <link rel="stylesheet" href="register.css">
  
</head>
<body>
    <!-- Navbar -->
    <nav>
        <ul class="navbar">
            <li><a href="index.html">Home</a></li>
            <li><a href="register.jsp">Register</a></li>
            <li><a href="dashboard.jsp">View List</a></li>
        </ul>
    </nav>

    <!-- Registration Form -->
    <section class="form-section">
     
        <h2>Register</h2>
        <form action="register" method="POST" enctype="multipart/form-data">
            <!-- First Name -->
            <label for="firstName">First Name:</label>
            <input type="text" id="firstName" name="firstName" required>

            <!-- Last Name -->
            <label for="lastName">Last Name:</label>
            <input type="text" id="lastName" name="lastName" required>

            <!-- Subscribe to Newsletter -->
            <div class="form-group">
                <label>Subscribe to Newsletter:</label>
                <div class="flex-input">
                    <input type="checkbox" id="newsletter" name="NewsLetter">
                    <label for="newsletter">Yes, I want to subscribe</label>
                </div>
            </div>

            <!-- Gender -->
            <div class="form-group">
                <label>Gender:</label>
                <div class="flex-input">
                    <input type="radio" id="male" name="gender" value="Male">
                    <label for="male">Male</label>
                </div>
                <div class="flex-input">
                    <input type="radio" id="female" name="gender" value="Female">
                    <label for="female">Female</label>
                </div>
                <div class="flex-input">
                    <input type="radio" id="other" name="gender" value="Other">
                    <label for="other">Other</label>
                </div>
            </div>

            <!-- Profile Picture -->
            <label for="profilePic">Profile Picture:</label>
            <input type="file" id="profilePic" name="profilePic" required>

            <!-- Message or Comments -->
            <label for="message">Message or Comments:</label>
            <textarea id="message" name="message" rows="4"></textarea>

            <!-- Submit Button -->
            <input type="submit" value="Register" class="register-btn">
        </form>
    </section>

    <!-- Footer -->
    <footer>
        <p>&copy; 2024 Your Website Name. All rights reserved.</p>
    </footer>
</body>
</html>

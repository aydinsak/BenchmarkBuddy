<%-- 
    Document   : homeAfterLogin
    Created on : 4 Dec 2024, 15.24.35
    Author     : Aydin Shidqi
--%>
<%@page import="java.util.List"%>
<%@page import="model.Device"%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Welcome - Benchmark Buddy</title>
        <style>
            /* General Reset */
            body, h1, h2, h3, p, ul, li, input {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: Arial, sans-serif;
            }

            header {
                background-color: #ff6a00;
                padding: 10px 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            header h1 {
                color: #fff;
                font-size: 1.5rem;
            }

            .search-bar {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .search-bar input {
                padding: 5px 10px;
                border: none;
                border-radius: 15px;
                outline: none;
            }

            .search-bar img {
                width: 20px;
                cursor: pointer;
            }

            header nav a {
                color: #fff;
                text-decoration: none;
                margin-left: 15px;
                font-size: 1rem;
            }

            .hero {
                display: flex;
                align-items: center;
                justify-content: center;
                text-align: left;
                background: linear-gradient(to bottom, #ff6a00, #fff);
                color: #fff;
                padding: 50px 20px;
            }

            .hero img {
                width: 200px;
                margin-right: 20px;
            }

            .hero-content {
                max-width: 600px;
            }

            .hero h2 {
                font-size: 2rem;
                margin-bottom: 10px;
            }

            .hero p {
                margin: 10px 0;
            }

            .hero button {
                margin-top: 20px;
                padding: 10px 20px;
                background-color: #fff;
                color: #ff6a00;
                border: none;
                cursor: pointer;
                font-size: 1rem;
                border-radius: 5px;
            }

            footer {
                background-color: #333;
                color: #fff;
                text-align: center;
                padding: 10px 20px;
                font-size: 0.9rem;
                position: absolute;
                bottom: 0;
                width: 100%;
            }

        </style>
    </head>
    <body>
        <header>
            <h1>Benchmark Buddy</h1>
        </header>
        <%
            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                // Redirect to login page if the user is not logged in
                response.sendRedirect("../UserServlet?action=invalid");
                return;
            }

            String username = user.getUsername();
        %>



        <section class="hero">
            <img src="${pageContext.request.contextPath}/PagesAssets/user-icon.png" alt="Laptop Illustration">
            <div class="hero-content">
                <h2>WELCOME <%= username%></h2>
                <p>Click below to choose your needs or Logout from website</p>

                <button type="button" class="btn btn-primary rounded-lg" onclick="window.location.href = '${pageContext.request.contextPath}/Pages/Rekomendasi.jsp'">
                    Start to choose your needs 
                </button>

                <form action="${pageContext.request.contextPath}/UserServlet" method="get">
                    <button type="submit" name="action" value="logout" class="btn btn-primary rounded-lg">
                        Logout User from <%= username%>
                    </button>
                </form>
            </div>
        </section>         

        <footer>
            © 2024 BenchmarkBuddy
        </footer>
    </body>
</html>

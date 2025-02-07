<%-- 
    Document   : index
    Created on : 26 Nov 2024, 20.50.54
    Author     : Aydin Shidqi
--%>

<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    User user = (User) request.getSession().getAttribute("user");
    if (user == null) {
        // Redirect to login page if the user is not logged in
        response.sendRedirect("../UserServlet?action=invalid");
        return;
    }
%>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Choose your preference - Benchmark Buddy</title>
        <!--<link rel="stylesheet" href="index.css">-->
        <script src="https://kit.fontawesome.com/26fcc6aee9.js" crossorigin="anonymous"></script>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            header {
                background-color: #ff6600;
                color: white;
                padding: 10px 20px;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            header h1 {
                margin: 0;
            }

            header input {
                padding: 5px;
                width: 50%;
            }

            header a {
                text-decoration: none;
                color: white;
                margin-left: 20px;
                font-weight: bold;
            }
            .content {
                max-width: 600px;
                margin: 20px auto;
                background-color: #fff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            h2 {
                background-color: #ff6600;
                color: white;
                padding: 10px;
                border-radius: 5px;
                margin-bottom: 20px;
                text-align: center;
            }

            .form-container {
                display: grid;
                gap: 15px;
            }

            .form-group {
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            label {
                flex: 0 0 30%;
                font-weight: bold;
            }

            select {
                flex: 1;
                padding: 10px;
                border-radius: 5px;
                border: 1px solid #ccc;
            }

            .submit-button {
                background-color: #ff6600;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
                text-align: center;
                width: 25%;
            }

            .submit-button:hover {
                background-color: #e55a00;
            }

            @media (max-width: 600px) {
                .form-group {
                    flex-direction: column;
                    align-items: flex-start;
                }

                label {
                    margin-bottom: 5px;
                }

                select{
                    width: 100%;
                }
            }
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>

        <main>
            <div class="content">
                <h2>Choose your preference</h2>
                <form action="${pageContext.request.contextPath}/UserServlet"  method="post"   class="form-container">
                    <input type="hidden" name="action" value="InsertPreference">
                    <div class="form-group">
                        <label for="processor">Prosesor</label>
                        <select id="processor" name="processor">
                            <option value="i3">Intel i3</option>
                            <option value="i5">Intel i5</option>
                            <option value="i7">Intel i7</option>
                            <option value="i9">Intel i9</option>
                            <option value="Ryzen 3">AMD Ryzen 3</option>
                            <option value="Ryzen 5">AMD Ryzen 5</option>
                            <option value="Ryzen 7">AMD Ryzen 7</option>
                            <option value="Ryzen 9">AMD Ryzen 9</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="graphics">Kartu Grafis</label>
                        <select id="graphics" name="graphics">
                            <option value="Dedicated">Dedicated</option>
                            <option value="Integrated">Integrated</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="memory">Memori</label>
                        <select id="memory" name="memory">
                            <option value="8">8 GB</option>
                            <option value="16">16 GB</option>
                            <option value="32">32 GB</option>
                        </select>
                    </div>
                    <button type="submit" class="submit-button">Cari!</button>
                </form>
            </div>
        </main>
    </body>
</html>


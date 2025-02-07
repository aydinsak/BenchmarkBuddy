<%-- 
    Document   : header
    Created on : 6 Dec 2024, 21.21.39
    Author     : Aydin Shidqi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
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

        header .search-container {
            display: flex;
            align-items: center;
            width: 50%;
        }

        header .search-container input {
            padding: 8px 15px;
            width: calc(100% - 40px);
            border: none;
            border-radius: 20px 0 0 20px;
            outline: none;
            font-size: 16px;
        }

        header .search-container button {
            background-color: white;
            border: none;
            border-radius: 0 20px 20px 0;
            padding: 8px 15px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #ff6600;
            font-size: 16px;
            border-left: 1px solid #ddd;
        }

        header .search-container button:hover {
            background-color: #ffe6cc;
        }

        header a {
            text-decoration: none;
            color: white;
            margin-left: 20px;
            font-weight: bold;
        }
    </style>
    <body>
        <header>
            <h1>Benchmark Buddy</h1>
            <div class="search-container">
                <form action="${pageContext.request.contextPath}/DeviceServlet" method="get" style="display: flex; width: 100%;">
                    <input type="hidden" name="action" value="searchDevice">
                    <input type="text" placeholder="Search..." name="deviceName">
                    <button type="submit">🔍</button>
                </form>
            </div>
            <a href="${pageContext.request.contextPath}/Pages/homeAfterLogin.jsp">HOME</a>
        </header>    
    </body>
</html>

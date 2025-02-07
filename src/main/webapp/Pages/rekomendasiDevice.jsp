<%-- 
    Document   : rekomendasiDevice
    Created on : 4 Dec 2024, 16.04.41
    Author     : Aydin Shidqi
--%>

<%@page import="model.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="model.Device"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Our Recommendation - Benchmark Buddy</title>
        <style>
            /* General Reset */
            body, h1, h2, h3, p, ul, li, input {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
            }

            header {
                background-color: #ff6a00;
                padding: 15px 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            header h1 {
                color: #fff;
                font-size: 1.8rem;
            }

            .search-bar {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .search-bar input {
                padding: 8px 12px;
                border: none;
                border-radius: 20px;
                outline: none;
            }

            .search-bar img {
                width: 25px;
                cursor: pointer;
            }

            header nav a {
                color: #fff;
                text-decoration: none;
                margin-left: 15px;
                font-size: 1rem;
            }

            header nav img {
                width: 30px;
                border-radius: 50%;
            }

            .container {
                display: flex;
                padding: 30px 20px;
                gap: 20px;
            }

            .filter-section {
                flex: 1;
                padding: 20px;
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            }

            .filter-section h2 {
                font-size: 1.5rem;
                color: #ff6a00;
                margin-bottom: 15px;
            }

            .filter-section h3 {
                margin: 20px 0 10px;
                font-size: 1.2rem;
                color: #333;
            }

            .filter-section input {
                width: calc(100% - 20px);
                padding: 10px;
                margin: 10px 0;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            .recommendation-section {
                flex: 3;
            }

            .recommendation-section h2 {
                color: #ff6a00;
                font-size: 1.8rem;
                margin-bottom: 20px;
            }

            .products-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 20px;
                justify-content: flex-start;
            }

            .product-card {
                background-color: #fff;
                border: 1px solid #ccc;
                border-radius: 10px;
                padding: 20px;
                text-align: center;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                width: 210px; /* Lebar tetap */
                height: 350px; /* Tinggi tetap */
            }

            .product-card:hover {
                transform: scale(1.015);
                box-shadow: 0 6px 15px rgba(0, 0, 0, 0.15);
            }

            .product-card img {
                width: 100%;
                height: 150px;
                object-fit: cover;
                margin-bottom: 15px;
                border-radius: 5px;
            }

            .product-card h3 {
                font-size: 1.2rem;
                margin: 15px 0;
            }

            .product-card p {
                margin: 5px 0;
                font-size: 1rem;
                color: #555;
            }

            .product-card button {
                background-color: #ff6a00;
                color: #fff;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                margin-top: 10px;
                cursor: pointer;
            }

            .product-card input[type="checkbox"] {
                margin-top: 10px;
            }

            .btn-primary {
                background-color: #ff6a00;
                color: #fff;
                border: none;
                padding: 10px 20px;
                font-size: 1rem;
                border-radius: 5px;
                cursor: pointer;
                text-align: center;
                transition: background-color 0.3s ease, transform 0.2s ease;
            }

            .btn-primary:hover {
                background-color: #e65a00;
                transform: scale(1.05);
            }
            .btn-back {
                margin: 10px 0 20px 20px; /* Atur jarak sesuai kebutuhan */
                background-color: #ff6a00;
                color: #fff;
                border: none;
                padding: 10px 20px;
                font-size: 1rem;
                border-radius: 5px;
                cursor: pointer;
                text-align: center;
                transition: background-color 0.3s ease, transform 0.2s ease;
            }

            .btn-back:hover {
                background-color: #e65a00;
                transform: scale(1.05);
            }

            .rounded-lg {
                border-radius: 10px;
            }

            ul {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            ul li {
                margin-bottom: 10px;
            }

            .compare-btn {
                background-color: #ff6a00;
                color: #fff;
                border: none;
                padding: 8px 15px;
                font-size: 0.9rem;
                border-radius: 8px;
                cursor: pointer;
                text-align: left;
                transition: all 0.3s ease;
                margin-left: 10px; /* Posisi ke kiri */
                margin-bottom: 10px; /* spacing biar tidak terlalu mepet bawahnya */
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                display: inline-block;
            }

            .compare-btn:hover {
                background-color: #e65a00;
                transform: scale(1.05);
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
            }

        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <%
        User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                // Redirect to login page if the user is not logged in
                response.sendRedirect("../UserServlet?action=invalid");
                return;
            }
        %>
        <button type="button" class="btn btn-back rounded-lg" onclick="window.location.href = '${pageContext.request.contextPath}/Pages/Rekomendasi.jsp'">
            Kembali ke pilihan Preference
        </button>
        <%
            // Retrieve the devices list from the session
            List<Device> displayDevices = (List<Device>) request.getSession().getAttribute("displayDevice");


        %>
        


        <div class="container">
            <!-- Filter Section -->
            <div class="filter-section">
                <h2>FILTER</h2>
                <h3>Kategori</h3>
                <ul>
                    <li>
                        <button type="button" class="btn btn-primary rounded-lg" onclick="window.location.href = '${pageContext.request.contextPath}/DeviceServlet?action=filterByCategory&category=Gaming'">
                            Gaming Laptop
                        </button>
                    </li>
                    <li>
                        <button type="button" class="btn btn-primary rounded-lg" onclick="window.location.href = '${pageContext.request.contextPath}/DeviceServlet?action=filterByCategory&category=Office'">
                            Office Laptop
                        </button>
                    </li>
                    <li>
                        <button type="button" class="btn btn-primary rounded-lg" onclick="window.location.href = '${pageContext.request.contextPath}/DeviceServlet?action=filterByCategory&category=Students'">
                            Students Laptop
                        </button>
                    </li>
                    <li>
                        <button type="button" class="btn btn-primary rounded-lg" onclick="window.location.href = '${pageContext.request.contextPath}/DeviceServlet?action=filterByCategory&category=Creators'">
                            Creator Laptop
                        </button>
                    </li>
                    <li>
                        <button type="button" class="btn btn-primary rounded-lg" onclick="window.location.href = '${pageContext.request.contextPath}/DeviceServlet?action=filterByCategory&category=Home'">
                            Home Laptop
                        </button>
                    </li>
                </ul>
                <!--                <h3>Rentang Harga</h3>
                                <input type="text" placeholder="Harga Minimum">
                                <input type="text" placeholder="Harga Maksimum">-->
            </div>
            <%                // Menghapus session preference ketika filter baru dipilih

            %>
            <!-- Recommendation Section -->
            <div class="recommendation-section">
                <h2>Our Recommendation</h2>
                <% if (displayDevices == null || displayDevices.isEmpty()) { %>
                <p>No recommended devices are available at the moment.</p>
                <%  if (request.getParameter("error") != null) {%>
                <p>message: <%=request.getParameter("error")%> </p>
                <%}%>
                <% } else { %>
                <form action="${pageContext.request.contextPath}/DeviceServlet" method="get" id="compareForm">
                    <button type="submit" class="compare-btn">
                        Compare Selected
                    </button>
                    <p id="error-message" class="error-message" style="display: none;"><b>Pilih minimal 2 atau maksimal 3 devices untuk membandingkan.</b></p>
                    <%  if (request.getParameter("Query") != null) { //search device%>
                    <p>Menampilkan device dengan query: <%=request.getParameter("Query")%> </p>
                    <%} else if (request.getParameter("Filter") != null) {//filter device%>
                    <p>Menampilkan device dengan filter: <%=request.getParameter("Filter")%> </p>
                    <%} else if (request.getParameter("Preference") != null) {//preference device%>
                    <p><%=request.getParameter("Preference")%></p>
                    <%}%>
                    <input type="hidden" name="action" value="compareDevices">
                    <div id="selectedDevices"></div> <!-- Hidden inputs for selected device IDs -->
                    <div class="products-grid">
                        <% for (Device device : displayDevices) {%>
                        <div class="product-card">
                            <%
                                String posterUrl = device.getPoster_url();
                                String finalUrl = posterUrl.contains("images_device")
                                        ? ((HttpServletRequest) request).getContextPath() + "/" + posterUrl
                                        : posterUrl;
                            %>
                            <img src="<%= finalUrl%>" alt="laptop-img" class="product-image">
                            <!--<img src="../PagesAssets/device-icon.png" alt="Laptop Image">-->
                            <h3><%= device.getName()%></h3>
                            <p>Price: <%= device.getPrice()%></p>
                            <button type="button" onclick="window.location.href = '${pageContext.request.contextPath}/DeviceServlet?action=showDevices&idDevices=<%=device.getDeviceId()%>'">Pelajari Lebih Lanjut</button> <br>
                            <!--<input type="checkbox"> Bandingkan-->
                            <label>
                                <input type="checkbox" class="compare-checkbox" value="<%= device.getDeviceId()%>" onchange="updateSelectedDevices(this)">
                                Compare
                            </label>
                        </div>
                        <% } %>

                    </div>

                </form>

                <script>
                    // Store selected device IDs
                    let selectedDeviceIds = new Set();

                    // Get the compare button element
                    const compareBtn = document.querySelector('.compare-btn');
                    const errorMessage = document.getElementById('error-message');

                    // Function to update selected devices when a checkbox is checked/unchecked
                    function updateSelectedDevices(checkbox) {
                        const deviceId = checkbox.value;
                        if (checkbox.checked) {
                            selectedDeviceIds.add(deviceId);
                        } else {
                            selectedDeviceIds.delete(deviceId);
                        }
                        updateHiddenInputs();
                        toggleCompareButton();
                    }

                    // Update hidden inputs in the form with selected device IDs
                    function updateHiddenInputs() {
                        const selectedDevicesContainer = document.getElementById('selectedDevices');
                        selectedDevicesContainer.innerHTML = ''; // Clear existing hidden inputs
                        selectedDeviceIds.forEach(deviceId => {
                            const input = document.createElement('input');
                            input.type = 'hidden';
                            input.name = 'deviceIds';
                            input.value = deviceId;
                            selectedDevicesContainer.appendChild(input);
                        });
                    }

                    function toggleCompareButton() {
                        const minCheckbox = 2;
                        const maxCheckbox = 3;

                        if (selectedDeviceIds.size >= minCheckbox && selectedDeviceIds.size <= maxCheckbox) {
                            compareBtn.style.display = 'block';
                            errorMessage.style.display = 'none';
                        } else {
                            compareBtn.style.display = 'none';
                            if (selectedDeviceIds.size > 0) {
                                errorMessage.style.display = 'block';
                            } else {
                                errorMessage.style.display = 'none';
                            }
                        }
                    }

                    toggleCompareButton();
                </script>
                <% }%>
            </div>
        </div>
    </body>
</html>

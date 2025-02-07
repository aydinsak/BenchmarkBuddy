<%@page import="model.User"%>
<%@page import="java.util.List"%>
<%@page import="model.Device"%>
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
        <title>Compare Devices - Benchmark Buddy</title>
        <style>
            main {
                max-width: 900px;
                margin: 20px auto;
                padding: 20px;
                background: white;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                border-radius: 5px;
            }

            .product-title {
                font-size: 24px;
                font-weight: bold;
                margin-bottom: 10px;
            }

            .product-price {
                font-size: 22px;
                color: #ff6600;
                margin: 10px 0;
            }

            .category {
                font-size: 16px;
                margin-bottom: 20px;
            }

            table {
                width: 100%; /* Perbesar lebar tabel */
                max-width: 1600px; /* Maksimal lebar tabel */
                border-collapse: collapse;
                margin: 30px auto; /* Tambahkan jarak di atas dan bawah */
                border: 1px solid #ddd;
                font-size: 16px; /* Perbesar ukuran font */
            }

            th, td {
                text-align: center; /* Mengatur teks di tengah untuk default */
                padding: 8px;
                border: 1px solid #ddd;
            }

            th {
                background-color: #ff6600;
                color: white;
            }

            /* Spesifikasi tetap rata kiri */
            td:first-child {
                text-align: left;
            }

            img.product-image {
                max-width: 50%; /* Ukuran gambar */
                border-radius: 5px;
                margin-bottom: 20px;
                position: relative; /* Tambahkan posisi relatif untuk referensi absolute */
            }

            .product-price {
                font-size: 22px;
                color: #ffffff;
                margin: 0;
                padding: 5px 20px; /* Jarak internal */
                border-radius: 5px; /* Tambahkan sudut membulat */
                font-weight: bold; /* Tambahkan ketebalan teks */
            }


            .comparison-container {
                display: flex;
                justify-content: space-between;
            }

            .device-column {
                width: 48%;
            }

            .btn-back {
                margin: 10px 0 20px 20px;
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
        </style>
    </head>

    <%
        // Ambil daftar perangkat dari session
        List<Device> devices = (List<Device>) request.getSession().getAttribute("selectedDevices");
    %>

    <body>
        <%@include file="header.jsp"%>
        <button type="button" class="btn btn-back rounded-lg" onclick="window.location.href = '${pageContext.request.contextPath}/Pages/rekomendasiDevice.jsp'">
            Kembali ke List Rekomendasi
        </button><br>
        <% if (devices != null && !devices.isEmpty()) { %>
        <table>
            <thead>
                <tr>
                    <th>Spesifikasi</th>
                        <% for (Device device : devices) {%>
                    <th>
                        <%
                            String posterUrl = device.getPoster_url();
                            String finalUrl = posterUrl.contains("images_device")
                                    ? ((HttpServletRequest) request).getContextPath() + "/" + posterUrl
                                    : posterUrl;
                        %>
                        <img src="<%=finalUrl%>" alt="<%= device.getName()%>" class="product-image"><br>
                        <%= device.getName()%>
                        <p class="product-price">Rp.<%= device.getPrice()%></p> 
                    </th>
                    <% } %>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Sistem Operasi</td>
                    <% for (Device device : devices) {%>
                    <td><%= device.getOperatingSystem()%></td>
                    <% } %>
                </tr>
                <tr>
                    <td>Prosesor</td>
                    <% for (Device device : devices) {%>
                    <td><%= device.getProcessor()%></td>
                    <% } %>
                </tr>
                <tr>
                    <td>Kartu Grafis</td>
                    <% for (Device device : devices) {%>
                    <td><%= device.getGraphicsCard()%></td>
                    <% } %>
                </tr>
                <tr>
                    <td>Jenis Kartu Grafis</td>
                    <% for (Device device : devices) {%>
                    <td><%= device.getGraphicsCardType()%></td>
                    <% } %>
                </tr>
                <tr>
                    <td>Penyimpanan</td>
                    <% for (Device device : devices) {%>
                    <td><%= device.getStorage()%></td>
                    <% } %>
                </tr>
                <tr>
                    <td>Display</td>
                    <% for (Device device : devices) {%>
                    <td><%= device.getDisplay()%></td>
                    <% } %>
                </tr>
                <tr>
                    <td>Baterai</td>
                    <% for (Device device : devices) {%>
                    <td><%= device.getBattery()%></td>
                    <% } %>
                </tr>
            </tbody>
        </table>
        <% } else { %>
        <p>Perangkat yang dipilih tidak valid atau tidak ditemukan. Harap pilih perangkat yang ingin dibandingkan.</p>
        <% }%>

    </body>
</html>

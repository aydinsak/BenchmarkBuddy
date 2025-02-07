<%-- 
    Document   : showDevice
    Created on : 6 Dec 2024, 20.57.19
    Author     : Aydin Shidqi
--%>

<%@page import="model.User"%>
<%@page import="model.Device"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User user = (User) request.getSession().getAttribute("user");
    if (user == null) {
        // Redirect to login page if the user is not logged in
        response.sendRedirect("../UserServlet?action=invalid");
        return;
    }
%>
<%
    Device device = (Device) request.getSession().getAttribute("singleDevice");
    String posterUrl = device.getPoster_url();
    String finalUrl = posterUrl.contains("images_device")
            ? ((HttpServletRequest) request).getContextPath() + "/" + posterUrl
            : posterUrl;
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title> <%= device.getBrand()%> <%= device.getName()%> - Benchmark Buddy</title>
        <style>
            main {
                max-width: 800px;
                margin: 20px auto;
                padding: 20px;
                background: white;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                border-radius: 5px;
            }

            .content-wrapper {
                display: flex;
                align-items: center; /* Menyelaraskan secara vertikal */
                justify-content: center; /* Menyelaraskan secara horizontal */
                margin: 20px;
                text-align: left; /* Atur teks agar rata kiri */
            }

            img.product-image {
                max-width: 40%; /* Batas lebar gambar */
                margin-right: 20px; /* Jarak antara gambar dan teks */
                border-radius: 5px;
            }

            .text-content {
                max-width: 60%; /* Batas lebar teks */
            }

            .text-content .product-title {
                font-size: 24px;
                font-weight: bold;
                margin-bottom: 10px;
            }

            .text-content .product-price {
                font-size: 22px;
                color: #ff6600;
                margin: 10px 0;
            }

            .text-content .category {
                font-size: 16px;
                margin-bottom: 20px;
            }

            .text-content .shop-button a {
                display: inline-block;
                background: linear-gradient(45deg, #ff6a00, #ff9500);
                color: white;
                text-decoration: none;
                padding: 10px 20px;
                border-radius: 5px;
                font-size: 16px;
                font-weight: bold;
                transition: all 0.3s ease;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            .text-content .shop-button a:hover {
                background: linear-gradient(45deg, #ff9500, #ff6a00);
                transform: scale(1.05);
                box-shadow: 0 6px 10px rgba(0, 0, 0, 0.15);
            }

            table {
                width: 80%;
                max-width: 1000px;
                border-collapse: collapse;
                margin: 20px auto;
                border: 1px solid #ddd;
            }

            th, td {
                text-align: left;
                padding: 8px;
                border: 1px solid #ddd;
            }

            th {
                background-color: #ff6600;
                color: white;
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

    <body>
        <%@include file="header.jsp"%>
        <button type="button" class="btn btn-back rounded-lg" onclick="window.location.href = '${pageContext.request.contextPath}/Pages/rekomendasiDevice.jsp'">
            Kembali ke List Rekomendasi
        </button><br>

        <div class="content-wrapper">
            <img src="<%= finalUrl%>" alt="laptop-img" class="product-image">
            <div class="text-content">
                <div class="product-title"><%= device.getName()%></div>
                <div class="product-brand">Merek: <%= device.getBrand()%></div>
                <div class="product-price">Rp.<%= device.getPrice()%></div>
                <div class="category">Kategori: <%= device.getCategory()%> Laptop</div>
                <% if (!device.getUrl().isEmpty()) {%>
                <div class="shop-button">
                    <a href="<%= device.getUrl()%>" target="_blank">Official Website</a>
                </div>
                <% }%>
            </div>
        </div>

        <table>
            <tr>
                <th>Spesifikasi</th>
                <th>Detail</th>
            </tr>
            <tr>
                <td>Sistem Operasi</td>
                <td><%= device.getOperatingSystem()%></td>
            </tr>
            <tr>
                <td>Prosesor</td>
                <td><%= device.getProcessor()%></td>
            </tr>
            <tr>
                <td>Kartu Grafis</td>
                <td><%= device.getGraphicsCard()%></td>
            </tr>
            <tr>
                <td>Jenis Kartu Grafis</td>
                <td><%= device.getGraphicsCardType()%></td>
            </tr>
            <tr>
                <td>Penyimpanan</td>
                <td><%= device.getStorage()%></td>
            </tr>
            <tr>
                <td>Display</td>
                <td><%= device.getDisplay()%></td>
            </tr>
            <tr>
                <td>Baterai</td>
                <td><%= device.getBattery()%></td>
            </tr>
        </table>
    </body>
</html>

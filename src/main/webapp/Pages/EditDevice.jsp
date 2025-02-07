<%-- 
    Document   : EditDevice
    Created on : 28 Dec 2024, 18.39.00
    Author     : mrafl
--%>

<%@page import="model.Device"%>
<%@page import="jakarta.servlet.http.HttpServletRequest"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Device</title>
        <style>
            main {
                max-width: 800px;
                margin: 20px auto;
                padding: 20px;
                background: white;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                border-radius: 5px;
            }

            header {
                background-color: #ff6600;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 10px 20px;
                background-color: #ffffff;
                color: #ff6600;
                font-family: Arial, sans-serif;

            }

            .logo{
                font-size: 20px;
                font-weight: bold;
            }

            .header-actions {
                display: flex;
                align-items: center;
            }

            .profile-icon {
                font-size: 24px;
                margin-left: 10px;
            }

            form {
                display: flex;
                flex-direction: column;
            }

            label {
                font-weight: bold;
                margin: 10px 0 5px;
            }

            input, select, textarea {
                padding: 10px;
                font-size: 16px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 5px;
                width: 100%;
            }

            button {
                background-color: #ff6a00;
                color: #fff;
                border: none;
                padding: 10px 20px;
                font-size: 1rem;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.2s ease;
            }

            button:hover {
                background-color: #e65a00;
                transform: scale(1.05);
            }

            .btn-back {
                margin: 10px 0 20px 0;
                background-color: #e65a00;
                color: #fff;
                margin-left: 50px;
            }
        </style>
        <script>
            function previewImage(event) {
                const reader = new FileReader();
                reader.onload = function () {
                    const output = document.getElementById('poster_preview');
                    output.src = reader.result;
                };
                reader.readAsDataURL(event.target.files[0]);
            }
        </script>
    </head>
    <body>
        <header>
            <div class="logo">Benchmark Buddy</div>
            <div class="header-actions">
                <div class="profile-icon">👤</div>
                <form action="${pageContext.request.contextPath}/UserServlet" method="get">
                    <button type="submit" name="action" value="logout" class="btn btn-primary rounded-lg">
                        Logout
                    </button>
                </form>
            </div>
        </header>

        <%
            Device device = (Device) request.getSession().getAttribute("singleDevice");
            if (device == null) {
                response.sendRedirect(request.getContextPath() + "/Pages/rekomendasiDevice.jsp");
            }
            String posterUrl = device.getPoster_url();
            String finalUrl = posterUrl.contains("images_device")
                    ? request.getContextPath() + "/" + posterUrl
                    : posterUrl;
        %>
        <button class="btn-back" onclick="window.location.href = '${pageContext.request.contextPath}/Pages/HalamanAdmin.jsp'">
            kembali
        </button>
        <main>
            <form action="${pageContext.request.contextPath}/DeviceServlet" method="post" enctype="multipart/form-data">
                <input type="hidden" name="idDevice" value="<%= device.getDeviceId()%>" />
                <input type="hidden" name="action" value="editDevice" />

                <label for="poster_url">Poster URL</label>
                <div>
                    <img id="poster_preview" src="<%= finalUrl%>" alt="Poster Preview" style="max-width: 100%; height: auto; margin-bottom: 10px;" />
                </div>
                <input type="file" id="poster_url" name="image" accept="image/*" onchange="previewImage(event)" required />

                <label for="name">Nama Perangkat</label>
                <input type="text" id="name" name="name" value="<%= device.getName()%>" required />

                <label for="brand">Brand</label>
                <input type="text" id="brand" name="brand" value="<%= device.getBrand()%>" required />

                <label for="price">Harga</label>
                <input type="number" id="price" name="price" value="<%= device.getPrice()%>" required />

                <label for="category">Kategori</label>
                <input type="text" id="category" name="category" value="<%= device.getCategory()%>" required />

                <label for="url">URL Resmi</label>
                <input type="text" id="url" name="url" value="<%= device.getUrl()%>" />

                <label for="operating_system">Sistem Operasi</label>
                <input type="text" id="operating_system" name="operatingSystem" value="<%= device.getOperatingSystem()%>" required />

                <label for="processor">Prosesor</label>
                <input type="text" id="processor" name="processor" value="<%= device.getProcessor()%>" required />

                <label for="graphics_card">Kartu Grafis</label>
                <input type="text" id="graphics_card" name="graphicsCard" value="<%= device.getGraphicsCard()%>" />

                <label for="graphics_card_type">Jenis Kartu Grafis</label>
                <input type="text" id="graphics_card_type" name="graphicsCardType" value="<%= device.getGraphicsCardType()%>" />

                <label for="storage">Penyimpanan</label>
                <input type="text" id="storage" name="storage" value="<%= device.getStorage()%>" required />

                <label for="display">Display</label>
                <input type="text" id="display" name="display" value="<%= device.getDisplay()%>" />

                <label for="display">Memory</label>
                <input type="text" id="memory" name="memory" value="<%= device.getMemory()%>" />

                <label for="battery">Baterai</label>
                <input type="text" id="battery" name="battery" value="<%= device.getBattery()%>" />

                <button type="submit">Simpan Perubahan</button>
            </form>
        </main>
    </body>
</html>

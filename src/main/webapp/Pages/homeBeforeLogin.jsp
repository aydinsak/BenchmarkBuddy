<%-- 
    Document   : homepaage
    Created on : 4 Dec 2024, 15.15.13
    Author     : Aydin Shidqi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Benchmark Buddy</title>
        <style>
            /* General Reset */
            body, h1, h2, h3, p, ul, li {
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

            header nav a {
                color: #fff;
                text-decoration: none;
                margin-left: 15px;
                font-size: 1rem;
            }

            .hero {
                text-align: center;
                background: linear-gradient(to bottom, #ff6a00, #fff);
                color: #fff;
                padding: 50px 20px;
            }

            .hero h2 {
                font-size: 2rem;
            }

            .hero p {
                margin: 10px auto;
                max-width: 600px; /* Membatasi lebar maksimal teks */
                line-height: 1.6; /* Menambahkan spasi antar baris untuk kenyamanan membaca */
                text-align: center; /* Memastikan teks tetap rata tengah */
            }

            .hero img {
                margin-top: 20px;
                width: 150px;
            }

            .hero button {
                margin-top: 20px;
                padding: 10px 20px;
                background-color: #fff;
                color: #ff6a00;
                border: none;
                cursor: pointer;
                font-size: 1rem;
            }

            .service, .team {
                text-align: center;
                padding: 50px 20px;
            }

            .service h2, .team h2 {
                color: #ff6a00;
                font-size: 2rem;
                margin-bottom: 20px;
            }

            .service p {
                margin: 20px 0;
            }

            .service img {
                width: 200px;
                margin: 20px 0;
            }

            .team-grid {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                gap: 20px;
            }

            .team-grid div {
                background-color: #ff6a00;
                color: #fff;
                padding: 20px;
                width: 150px;
                text-align: center;
                border-radius: 5px;
            }

            footer {
                background-color: #333;
                color: #fff;
                text-align: center;
                padding: 10px 20px;
                font-size: 0.9rem;
            }
            .hero img {
                margin-top: 20px;
                width: 250px;
            }

            .service img {
                width: 400px;
            }

        </style>
    </head>
    <body>
        <header>
            <h1>Benchmark Buddy</h1>
            <nav>
                <a href="#">HOME</a>
                <a href="Pages/login.jsp">LOGIN</a>
            </nav>
        </header>

        <section class="hero">
            <h2>WELCOME BUDDY :)</h2>
            <p>Hello everyone, we are from the BenchmarkBuddy team, and we are excited to present the application we have developed. Our team consists of 6 members, each with their own roles and responsibilities. This application offers laptop recommendations for those who are new to gadgets, especially laptops.</p>
            <img src="${pageContext.request.contextPath}/PagesAssets/laptop.png" alt="Laptop illustration">
            <br>

            <button type="button" class="btn btn-primary rounded-lg" onclick="window.location.href = 'Pages/login.jsp'">
                Login to Start
            </button>
        </section>

        <section class="service">
            <h2>Our Service</h2>
            <p>We provide service for people who are still new to gadgets, especially laptops</p>
            <img src="${pageContext.request.contextPath}/PagesAssets/service.png" width="" alt="Service illustration">
            <p><strong>LAPTOP RECOMMENDATION:</strong> We offer advice and the best laptop option for your needs.</p>
        </section>

        <section class="team">
            <h2>Our Team</h2>
            <div class="team-grid">
                <div>Aydin Shidqi Athalla K.<br>1301223179</div>
                <div>Aaron Barmichello Pattinama<br>1301223337</div>
                <div>Daffa Ananta Rachman<br>1301223140</div>
                <div>Frederico da Rosari<br>1301220215</div>
                <div>Khairunida Khumaira<br>1301223216</div>
                <div>M Rafi Aulhan S.<br>130122302</div>
            </div>
        </section>

        <footer>
            © 2024 BenchmarkBuddy
        </footer>
    </body>
</html>

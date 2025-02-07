/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package web;

import dao.UserDAO;
import java.io.IOException;
// import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Preference;
import model.User;

/**
 *
 * @author Aydin Shidqi
 */
@WebServlet(name = "UserServlet", urlPatterns = { "/UserServlet" })
public class UserServlet extends HttpServlet {

    private UserDAO userDAO;

    public UserServlet() {
        userDAO = new UserDAO();

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("login".equals(action)) {
            Login(request, response);
        } else if ("InsertPreference".equals(action)) {
            UpdatePreference(request, response);
        } else if ("register".equals(action)) {
            Register(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("login".equals(action)) {
            Login(request, response);
        } else if ("logout".equals(action)) {
            Logout(request, response);
        } else if ("invalid".equals(action)) {
            invalidSession(request, response);
        }
    }

    public void invalidSession(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("Pages/login.jsp?error=Session+invalid,+silakan+login+kembali");
    }

    protected void Login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        boolean validateUser = userDAO.validateUser(email, password);
        boolean validateAdmin = userDAO.validateAdmin(email, password);

        if (validateUser) {
            User user = userDAO.selectUser(email, password);
            request.getSession().setAttribute("user", user);
            response.sendRedirect("Pages/homeAfterLogin.jsp");

        } else if (validateAdmin) {
            User user = userDAO.selectUser(email, password);
            request.getSession().setAttribute("user", user);

            response.sendRedirect(request.getContextPath() + "/DeviceServlet?action=showAllDevicesAdmin");

        } else {
            // response.getWriter().print("Gagal");
            response.sendRedirect("Pages/login.jsp?error=username+atau+password+salah");
        }
    }

    protected void Logout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        // Redirect ke halaman login
        response.sendRedirect("http://localhost:8080/BenchmarkBuddy");
    }

    protected void Register(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String user = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        boolean validateUser = userDAO.insertUser(user, email, password);

        if (validateUser) {
            response.sendRedirect("Pages/login.jsp?regMsg=Register+berhasil");
        } else {
            response.sendRedirect("Pages/registration.jsp?error=Username+sudah+ada");
            // response.getWriter().print("Gagal");
        }
    }

    protected void UpdatePreference(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String processor = request.getParameter("processor");
        String graphics = request.getParameter("graphics");
        String memory = request.getParameter("memory");
        User user = (User) request.getSession().getAttribute("user");
        int user_id = user.getUser_id();
        Preference preference = userDAO.selectPreference(user_id);

        if (preference != null) {
            try {
                userDAO.updatePreference(user_id, processor, graphics, memory);
            } catch (SQLException ex) {
                Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            try {
                userDAO.insertPreference(user_id, processor, graphics, memory);
            } catch (SQLException ex) {
                Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        preference = userDAO.selectPreference(user_id);
        user.setPreference(preference);

        request.getSession().setAttribute("user", user);
        response.sendRedirect(request.getContextPath() + "/DeviceServlet?action=rekomendasiDevice");
    }

    protected void updateFilter(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String filter = request.getParameter("");
        User user = (User) request.getSession().getAttribute("user");

        request.getSession().setAttribute("user", user);
        response.sendRedirect(request.getContextPath() + "/DeviceServlet?action=rekomendasiDevice");
    }
}

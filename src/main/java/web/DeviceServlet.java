/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package web;

import dao.DeviceDAO;
import dao.UserDAO;
// import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
// import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.ArrayList;
import java.util.List;
import model.Device;
import model.Preference;
import model.User;

/**
 *
 * @author Aydin Shidqi
 */
@WebServlet(name = "DeviceServlet", urlPatterns = { "/DeviceServlet" })
@MultipartConfig
public class DeviceServlet extends HttpServlet {

    private final String uploadDirectory = "C:/images_device";

    private UserDAO userDAO;
    private DeviceDAO deviceDAO;

    public DeviceServlet() {
        userDAO = new UserDAO();
        deviceDAO = new DeviceDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("rekomendasiDevice".equals(action)) {
            getRekomendasiDevice(request, response);
        } else if ("filterByCategory".equals(action)) {
            getDeviceByCategory(request, response);
        } else if ("showDevices".equals(action)) {
            ShowDevices(request, response);
            response.sendRedirect(request.getContextPath() + "/Pages/showDevice.jsp");
        } else if ("showAllDevicesAdmin".equals(action)) {
            showAllDevices(request, response);
            String msg = request.getParameter("msg");
            if (msg != null) {
                if ("edit".equals(msg)) {
                    response.sendRedirect("Pages/HalamanAdmin.jsp?msg=Device+berhasil+diubah");
                } else if ("add".equals(msg)) {
                    response.sendRedirect("Pages/HalamanAdmin.jsp?msg=Device+berhasil+ditambah");
                } else if ("del".equals(msg)) {
                    response.sendRedirect("Pages/HalamanAdmin.jsp?msg=Device+berhasil+dihapus");
                }
            } else {
                response.sendRedirect("Pages/HalamanAdmin.jsp");
            }
        } else if ("showDeviceEdit".equals(action)) {
            ShowDevices(request, response);
            response.sendRedirect(request.getContextPath() + "/Pages/EditDevice.jsp");
        } else if ("deleteDevice".equals(action)) {
            deleteDevice(request, response);
        } else if ("searchDevice".equals(action)) {
            searchDevice(request, response);
        } else if ("compareDevices".equals(action)) {
            compareDevices(request, response);
        } else if ("invalid".equals(action)) {
            invalidSession(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("tambahDevice".equals(action)) {
            tambahDevice(request, response);
        } else if ("editDevice".equals(action)) {
            editDevice(request, response);
        }
    }

    protected void getRekomendasiDevice(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get user from session
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/DeviceServlet?action=invalid");
            // throw new ServletException("User is not logged in or session has expired.");
        }

        // Get user preferences
        Preference preference = user.getPreference();
        if (preference == null) {
            response.sendRedirect(request.getContextPath() + "/DeviceServlet?action=invalid");
            // throw new ServletException("User preferences are not set.");
        } else {
            List<Device> devices = deviceDAO.getRecommendedDevice(
                    preference.getProcessor(),
                    preference.getGraphicsCardType(),
                    preference.getMemory());
            // Set recommended devices to request and forward to JSP (or return as JSON)
            request.getSession().setAttribute("displayDevice", devices);
            response.sendRedirect(request.getContextPath()
                    + "/Pages/rekomendasiDevice.jsp?Preference=Menampilkan+device+dengan+preference:"
                    + "+prosesor+'" + preference.getProcessor() + ",'+jenis+kartu+'" + preference.getGraphicsCardType()
                    + "',+dan+memori+'" + preference.getMemory() + "'+GB");
        }

    }

    protected void getDeviceByCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String category = request.getParameter("category");

        List<Device> FilteredDevices = deviceDAO.selectFilter(category);
        if (FilteredDevices == null || FilteredDevices.isEmpty()) {
            request.getSession().setAttribute("displayDevice", null);
        } else {
            request.getSession().setAttribute("displayDevice", FilteredDevices);
        }

        response.sendRedirect(request.getContextPath() + "/Pages/rekomendasiDevice.jsp?Filter=" + category);

    }

    public void invalidSession(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("Pages/login.jsp?error=Session+invalid,+silakan+login+kembali");
    }

    protected void ShowDevices(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int device_id = Integer.parseInt(request.getParameter("idDevices"));

        Device singleDevice = deviceDAO.selectDevice(device_id);
        if (singleDevice == null) {
            request.getSession().setAttribute("singleDevice", null);
        } else {
            request.getSession().setAttribute("singleDevice", singleDevice);
        }
    }

    protected void deleteDevice(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idDevice = request.getParameter("idDevice");

        try {
            int deviceId = Integer.parseInt(idDevice);

            // Call the DAO to delete the device
            boolean isDeleted = deviceDAO.deleteDevice(deviceId);

            if (isDeleted) {
                // If successful, redirect to the admin page with updated device list
                response.sendRedirect(request.getContextPath() + "/DeviceServlet?action=showAllDevicesAdmin&msg=del");
            } else {
                // If failed, redirect to the admin page with an error message
                response.sendRedirect("Pages/HalamanAdmin.jsp?error=Device+gagal+dihapus");
            }
        } catch (NumberFormatException e) {
            // Handle invalid device ID format
            response.sendRedirect("Pages/HalamanAdmin.jsp?error=ID+perangkat+tidak+valid");
        }
    }

    protected void showAllDevices(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Device> devices = deviceDAO.showAllDevices();

        if (devices == null || devices.isEmpty()) {
            request.getSession().setAttribute("allDevices", null);
        } else {
            request.getSession().setAttribute("allDevices", devices);
        }
    }

    protected void searchDevice(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String deviceName = request.getParameter("deviceName");

        if (deviceName == null || deviceName.trim().isEmpty()) {
            request.getSession().setAttribute("displayDevice", null);
            response.sendRedirect(
                    request.getContextPath() + "/Pages/rekomendasiDevice.jsp?error=Nama+device+tidak+boleh+kosong");
            return;
        }

        List<Device> searchResult = deviceDAO.searchDevice(deviceName);

        if (searchResult == null || searchResult.isEmpty()) {
            request.getSession().setAttribute("displayDevice", null);
            response.sendRedirect(request.getContextPath() + "/Pages/rekomendasiDevice.jsp?error=Device+dengan+query+'"
                    + deviceName + "'+tidak+ditemukan");
        } else {
            request.getSession().setAttribute("displayDevice", searchResult);
            response.sendRedirect(request.getContextPath() + "/Pages/rekomendasiDevice.jsp?Query=" + deviceName);
        }
    }

    protected void tambahDevice(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Extract parameters from the request
        String name = request.getParameter("name");
        String brand = request.getParameter("brand");
        String category = request.getParameter("category");
        int price = Integer.parseInt(request.getParameter("price"));
        String operatingSystem = request.getParameter("operatingSystem");
        String battery = request.getParameter("battery");
        String storage = (request.getParameter("storage"));
        int memory = Integer.parseInt(request.getParameter("memory"));
        String display = request.getParameter("display");
        String graphicsCard = request.getParameter("graphicsCard");
        String graphicsCardType = request.getParameter("graphicsCardType");
        String processor = request.getParameter("processor");
        String url = request.getParameter("url");

        Part filePart = request.getPart("image");
        String fileName = filePart.getSubmittedFileName();
        String filePath = uploadDirectory + File.separator + fileName;

        // Save the file to the server4
        File fileSaveDir = new File(uploadDirectory);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdirs(); // Create the directory if it does not exist
        }
        filePart.write(filePath);

        // Relative path to store in the database
        String relativePath = "images_device/" + fileName;
        // Call the DAO to insert the device into the database
        boolean deviceAdded = deviceDAO.insertDevice(
                name, brand, category, price, operatingSystem, battery,
                storage, memory, display, graphicsCard, graphicsCardType,
                processor, url, relativePath);

        // Handle the result of the operation
        if (deviceAdded) {
            // response.getWriter().println("Berhasil");
            response.sendRedirect(request.getContextPath() + "/DeviceServlet?action=showAllDevicesAdmin&msg=add");

        } else {
            // response.getWriter().println("Failed to add the device. Please try again.");
            response.sendRedirect("Pages/HalamanAdmin.jsp?error=Device+gagal+ditambahkan");
        }
    }

    protected void editDevice(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Extract parameters from the request
        String name = request.getParameter("name");
        String brand = request.getParameter("brand");
        String category = request.getParameter("category");
        int price = Integer.parseInt(request.getParameter("price"));
        String operatingSystem = request.getParameter("operatingSystem");
        String battery = request.getParameter("battery");
        String storage = (request.getParameter("storage"));
        int memory = Integer.parseInt(request.getParameter("memory"));
        String display = request.getParameter("display");
        String graphicsCard = request.getParameter("graphicsCard");
        String graphicsCardType = request.getParameter("graphicsCardType");
        String processor = request.getParameter("processor");
        String url = request.getParameter("url");
        String idDevice = request.getParameter("idDevice");
        int id = Integer.parseInt(idDevice);

        Part filePart = request.getPart("image");
        String fileName = filePart.getSubmittedFileName();
        String filePath = uploadDirectory + File.separator + fileName;

        // Save the file to the server4
        File fileSaveDir = new File(uploadDirectory);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdirs(); // Create the directory if it does not exist
        }
        filePart.write(filePath);

        // Relative path to store in the database
        String relativePath = "images_device/" + fileName;
        // Call the DAO to insert the device into the database
        boolean deviceEdited = deviceDAO.editDevice(id,
                name, brand, category, price, operatingSystem, battery,
                storage, memory, display, graphicsCard, graphicsCardType,
                processor, url, relativePath);

        // Handle the result of the operation
        if (deviceEdited) {
            // response.getWriter().println("Berhasil");
            response.sendRedirect(request.getContextPath() + "/DeviceServlet?action=showAllDevicesAdmin&msg=edit");
        } else {
            // response.getWriter().println("Failed to add the device. Please try again.");
            response.sendRedirect("Pages/HalamanAdmin.jsp?error=Device+gagal+diubah");
        }
    }

    protected void compareDevices(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String[] deviceIds = request.getParameterValues("deviceIds");
        // Retrieve the selected device IDs

        if (deviceIds != null) {
            List<Device> selectedDevices = new ArrayList<>();
            for (String id : deviceIds) {
                // Fetch each device from the database or service
                Device device = deviceDAO.selectDevice(Integer.parseInt(id));
                selectedDevices.add(device);
            }

            // Forward the list to another JSP page
            request.getSession().setAttribute("selectedDevices", selectedDevices);
            response.sendRedirect("Pages/compare.jsp");
        }

    }
}

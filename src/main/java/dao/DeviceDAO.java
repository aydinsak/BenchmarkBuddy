/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Device;

/**
 *
 * @author Aydin Shidqi
 */
public class DeviceDAO {

    private final String url = "jdbc:mysql://localhost:3306/benchmarkbuddy";
    private final String user = "root";
    private final String pasword = "";

    public DeviceDAO() {
    }

    public List<Device> showAllDevices() {
        List<Device> devices = new ArrayList<>();
        String sql = "SELECT * FROM device";

        try (Connection conn = DriverManager.getConnection(url, user, pasword);
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int device_id = rs.getInt("device_id");
                String name = rs.getString("name");
                String brand = rs.getString("brand");
                String category = rs.getString("category");
                int price = rs.getInt("price");
                String operatingSystem = rs.getString("operatingSystem");
                String battery = rs.getString("battery");
                String storage = rs.getString("storage");
                int memory = rs.getInt("memory");
                String display = rs.getString("display");
                String graphicsCard = rs.getString("graphicsCard");
                String graphicsCardType = rs.getString("graphicsCardType");
                String processor = rs.getString("processor");
                // String url = rs.getString("url");
                String poster_url = rs.getString("poster_url");

                devices.add(new Device(device_id, name, brand, category, price, operatingSystem, battery, storage,
                        memory, display, graphicsCard, graphicsCardType, processor, poster_url));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return devices;
    }

    public List<Device> getRecommendedDevice(String processor, String GpuType, int RAM) {

        List<Device> devices = new ArrayList<>();
        String sql = "SELECT * FROM device WHERE processor LIKE ? AND graphicsCardType LIKE ? AND memory = ? ";

        try (Connection conn = DriverManager.getConnection(url, user, pasword);
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, "%" + processor + "%");
            stmt.setString(2, "%" + GpuType + "%");
            stmt.setInt(3, RAM);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int device_id = rs.getInt("device_id");

                String name = rs.getString("name");
                String brand = rs.getString("brand");
                String category = rs.getString("category");
                int price = rs.getInt("price");
                String operatingSystem = rs.getString("operatingSystem");
                String battery = rs.getString("battery");
                String storage = rs.getString("storage");
                int memory = rs.getInt("memory");
                String display = rs.getString("display");
                String graphicsCard = rs.getString("graphicsCard");
                String graphicsCardType = rs.getString("graphicsCardType");
                String Processor = rs.getString("processor");
                // String url = rs.getString("url");
                String poster_url = rs.getString("poster_url");

                devices.add(new Device(device_id, name, brand, category, price, operatingSystem, battery, storage,
                        memory, display, graphicsCard, graphicsCardType, Processor, poster_url));

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return devices;

    }

    public List<Device> selectFilter(String category) {
        String sql = "SELECT * FROM device WHERE category = ?";
        List<Device> devices = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection(url, user, pasword);
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, category);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int device_id = rs.getInt("device_id");

                String name = rs.getString("name");
                String brand = rs.getString("brand");
                String Category = rs.getString("category");
                int price = rs.getInt("price");
                String operatingSystem = rs.getString("operatingSystem");
                String battery = rs.getString("battery");
                String storage = rs.getString("storage");
                int memory = rs.getInt("memory");
                String display = rs.getString("display");
                String graphicsCard = rs.getString("graphicsCard");
                String graphicsCardType = rs.getString("graphicsCardType");
                String Processor = rs.getString("processor");
                // String url = rs.getString("url");
                String poster_url = rs.getString("poster_url");

                devices.add(new Device(device_id, name, brand, Category, price, operatingSystem, battery, storage,
                        memory, display, graphicsCard, graphicsCardType, Processor, poster_url));

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return devices;
    }

    public Device selectDevice(int device_id) {
        String sql = "SELECT * FROM device WHERE device_id = ?";

        try (Connection conn = DriverManager.getConnection(url, user, pasword);
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, device_id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {

                String name = rs.getString("name");
                String brand = rs.getString("brand");
                String Category = rs.getString("category");
                int price = rs.getInt("price");
                String operatingSystem = rs.getString("operatingSystem");
                String battery = rs.getString("battery");
                String storage = rs.getString("storage");
                int memory = rs.getInt("memory");
                String display = rs.getString("display");
                String graphicsCard = rs.getString("graphicsCard");
                String graphicsCardType = rs.getString("graphicsCardType");
                String Processor = rs.getString("processor");
                String url = rs.getString("url");
                String poster_url = rs.getString("poster_url");

                Device device = new Device(device_id, name, brand, Category, price, operatingSystem, battery, storage,
                        memory, display, graphicsCard, graphicsCardType, Processor, poster_url);

                device.setUrl(url);
                device.setPoster_url(poster_url);

                return device;

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean insertDevice(String name, String brand, String category, int price, String operatingSystem,
            String battery,
            String storage, int memory, String display, String graphicsCard, String graphicsCardType, String processor,
            String Url, String poster_url) {
        // SQL Query (excluding device_id)
        String sql = "INSERT INTO device (name, brand, category, price, operatingSystem, battery, storage, memory, display, graphicsCard, graphicsCardType, processor, url, poster_url) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            // Load MySQL Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish database connection and prepare statement
            try (Connection conn = DriverManager.getConnection(url, user, pasword);
                    PreparedStatement stmt = conn.prepareStatement(sql)) {

                // Set values for the query parameters
                stmt.setString(1, name);
                stmt.setString(2, brand);
                stmt.setString(3, category);
                stmt.setInt(4, price);
                stmt.setString(5, operatingSystem);
                stmt.setString(6, battery);
                stmt.setString(7, storage);
                stmt.setInt(8, memory);
                stmt.setString(9, display);
                stmt.setString(10, graphicsCard);
                stmt.setString(11, graphicsCardType);
                stmt.setString(12, processor);
                stmt.setString(13, Url);
                stmt.setString(14, poster_url);

                // Execute the query and check for success
                return stmt.executeUpdate() > 0; // Returns true if at least one row was inserted
            }
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL JDBC Driver not found: " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("SQL Exception: " + e.getMessage());
        }

        return false; // Returns false if the insertion fails
    }

    public boolean editDevice(int device_id, String name, String brand, String category, int price,
            String operatingSystem, String battery,
            String storage, int memory, String display, String graphicsCard, String graphicsCardType, String processor,
            String Url, String poster_url) {

        // SQL Query for updating the device
        String sql = "UPDATE device SET name = ?, brand = ?, category = ?, price = ?, operatingSystem = ?, battery = ?, "
                + "storage = ?, memory = ?, display = ?, graphicsCard = ?, graphicsCardType = ?, processor = ?, url = ?, poster_url = ? "
                + "WHERE device_id = ?";

        try {
            // Load MySQL Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish database connection and prepare statement
            try (Connection conn = DriverManager.getConnection(url, user, pasword);
                    PreparedStatement stmt = conn.prepareStatement(sql)) {

                // Set values for the query parameters
                stmt.setString(1, name);
                stmt.setString(2, brand);
                stmt.setString(3, category);
                stmt.setInt(4, price);
                stmt.setString(5, operatingSystem);
                stmt.setString(6, battery);
                stmt.setString(7, storage);
                stmt.setInt(8, memory);
                stmt.setString(9, display);
                stmt.setString(10, graphicsCard);
                stmt.setString(11, graphicsCardType);
                stmt.setString(12, processor);
                stmt.setString(13, Url);
                stmt.setString(14, poster_url);
                stmt.setInt(15, device_id);

                // Execute the query and check for success
                return stmt.executeUpdate() > 0; // Returns true if at least one row was updated
            }
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL JDBC Driver not found: " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("SQL Exception: " + e.getMessage());
        }

        return false; // Returns false if the update fails
    }

    public List<Device> searchDevice(String name) {
        List<Device> devices = new ArrayList<>();
        String sql = "SELECT * FROM device WHERE name LIKE ? OR brand LIKE ?";

        try (Connection conn = DriverManager.getConnection(url, user, pasword);
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, "%" + name + "%");
            stmt.setString(2, "%" + name + "%");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int device_id = rs.getInt("device_id");
                String deviceName = rs.getString("name");
                String brand = rs.getString("brand");
                String category = rs.getString("category");
                int price = rs.getInt("price");
                String operatingSystem = rs.getString("operatingSystem");
                String battery = rs.getString("battery");
                String storage = rs.getString("storage");
                int memory = rs.getInt("memory");
                String display = rs.getString("display");
                String graphicsCard = rs.getString("graphicsCard");
                String graphicsCardType = rs.getString("graphicsCardType");
                String processor = rs.getString("processor");
                // String url = rs.getString("url");
                String poster_url = rs.getString("poster_url");

                devices.add(new Device(device_id, deviceName, brand, category, price, operatingSystem, battery,
                        storage, memory, display, graphicsCard, graphicsCardType, processor, poster_url));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return devices;
    }

    public boolean deleteDevice(int device_id) {
        // SQL Query for deleting the device
        String sql = "DELETE FROM device WHERE device_id = ?";

        try {
            // Load MySQL Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish database connection and prepare statement
            try (Connection conn = DriverManager.getConnection(url, user, pasword);
                    PreparedStatement stmt = conn.prepareStatement(sql)) {

                // Set the device_id for the query
                stmt.setInt(1, device_id);

                // Execute the query and check for success
                return stmt.executeUpdate() > 0; // Returns true if at least one row was deleted
            }
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL JDBC Driver not found: " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("SQL Exception: " + e.getMessage());
        }

        return false; // Returns false if the deletion fails
    }

}

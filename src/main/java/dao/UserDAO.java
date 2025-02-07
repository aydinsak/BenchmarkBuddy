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
// import java.sql.Statement;
// import java.util.ArrayList;
// import java.util.List;
// import java.util.stream.Collectors;
import model.Preference;
import model.User;

/**
 *
 * @author Aydin Shidqi
 */
public class UserDAO {

    private final String url = "jdbc:mysql://localhost:3306/benchmarkbuddy";
    private final String user = "root";
    private final String pasword = "";

    public UserDAO() {
    }

    ;

    // Method to insert a new user
    public boolean insertUser(String username, String email, String password) {
        String checkQuery = "SELECT username FROM user WHERE username = ?";
        String insertQuery = "INSERT INTO user (username,email, password,isAdmin) VALUES (?,?,?,?)";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL JDBC Driver not found: " + e.getMessage());
        }

        try (Connection conn = DriverManager.getConnection(url, user, pasword);
                PreparedStatement checkStatement = conn.prepareStatement(checkQuery)) {

            // Check if the username already exists
            checkStatement.setString(1, username);
            ResultSet resultSet = checkStatement.executeQuery();

            if (resultSet.next()) {
                // Username already exists
                System.out.println("Username is already taken.");
                return false;
            }

            // Username is unique; proceed with insertion
            try (PreparedStatement insertStatement = conn.prepareStatement(insertQuery)) {
                insertStatement.setString(1, username);
                insertStatement.setString(2, email);
                insertStatement.setString(3, password);
                insertStatement.setString(4, "0");
                int rowsInserted = insertStatement.executeUpdate();
                return rowsInserted > 0; // Returns true if insertion is successful
            }

        } catch (SQLException e) {
            System.out.println("Error inserting user: " + e.getMessage());
            return false;
        }
    }

    public boolean validateUser(String email, String password) {
        String query = "SELECT email,password FROM user WHERE email = ? AND password = ? and isAdmin=?";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL JDBC Driver not found: " + e.getMessage());
        }
        try (Connection conn = DriverManager.getConnection(url, user, pasword);
                PreparedStatement statement = conn.prepareStatement(query)) {

            statement.setString(1, email);
            statement.setString(2, password);
            statement.setString(3, "0");
            ResultSet resultSet = statement.executeQuery();
            // Return true if a matching user is found
            return resultSet.next();

        } catch (SQLException e) {
            System.out.println("Error validating user: " + e.getMessage());
            return false;
        }
    }

    public boolean validateAdmin(String email, String password) {
        String query = "SELECT email,password FROM user WHERE email = ? AND password = ? and isAdmin = ?";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL JDBC Driver not found: " + e.getMessage());
        }
        try (Connection conn = DriverManager.getConnection(url, user, pasword);
                PreparedStatement statement = conn.prepareStatement(query)) {

            statement.setString(1, email);
            statement.setString(2, password);
            statement.setString(3, "1");

            ResultSet resultSet = statement.executeQuery();

            // Return true if a matching user is found
            return resultSet.next();

        } catch (SQLException e) {
            System.out.println("Error validating user: " + e.getMessage());
            return false;
        }
    }

    public User selectUser(String email, String password) {
        String query = "SELECT user_id, username, email,password, preference_id FROM user WHERE email = ? AND password = ?";
        User userr = null; // Initialize as null to return if not found

        // Load MySQL JDBC Driver
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL JDBC Driver not found: " + e.getMessage());
        }

        // Try to connect to the database and execute the query
        try (Connection conn = DriverManager.getConnection(url, user, pasword); // Use DB credentials, not user’s
                                                                                // password
                PreparedStatement statement = conn.prepareStatement(query)) {

            statement.setString(1, email);
            statement.setString(2, password);
            // Assuming 0 is for a regular user, not an admin

            ResultSet resultSet = statement.executeQuery();

            // If a matching user is found, create a User object
            if (resultSet.next()) {
                int userID = resultSet.getInt("user_id"); // Retrieve userID
                String dbUsername = resultSet.getString("username");
                String Email = resultSet.getString("email");
                String dbPassword = resultSet.getString("password");
                int preference_id = resultSet.getInt("preference_id");

                // Create a User object with userID, username, password, and fullname
                userr = new User(userID, dbUsername, Email, password, preference_id);

            }

        } catch (SQLException e) {
            System.out.println("Error validating user: " + e.getMessage());
        }

        return userr; // Returns the User object if found, or null if not found
    }

    public Preference selectPreference(int user_id) {
        String query = "SELECT * FROM preference WHERE user_id = ?";
        Preference preference = null; // Initialize as null to return if not found

        // Load MySQL JDBC Driver
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL JDBC Driver not found: " + e.getMessage());
        }

        // Try to connect to the database and execute the query
        try (Connection conn = DriverManager.getConnection(url, user, pasword); // Use DB credentials, not user’s
                                                                                // password
                PreparedStatement statement = conn.prepareStatement(query)) {

            statement.setInt(1, user_id);

            ResultSet resultSet = statement.executeQuery();

            // If a matching user is found, create a User object
            if (resultSet.next()) {
                int preference_id = resultSet.getInt("preference_id");
                String processor = resultSet.getString("processor");
                String graphicsCardType = resultSet.getString("graphicsCardType");
                int memory = resultSet.getInt("memory");

                preference = new Preference(preference_id, user_id, processor, graphicsCardType, memory);

            }

        } catch (SQLException e) {
            System.out.println("Error validating user: " + e.getMessage());
        }

        return preference; // Returns the User object if found, or null if not found
    }

    public boolean insertPreference(int user_id, String processor, String graphicsCardType, String memory)
            throws SQLException {
        String sql = "insert into preference (user_id,processor,graphicsCardType,memory) values(?,?,?,?)";
        try (Connection conn = DriverManager.getConnection(url, user, pasword);
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, user_id);
            stmt.setString(2, processor);
            stmt.setString(3, graphicsCardType);
            stmt.setString(4, memory);

            return stmt.executeUpdate() > 0; // Returns true if update was successful
        }
    }

    public boolean updatePreference(int user_id, String processor, String graphicsCardType, String memory)
            throws SQLException {
        String sql = "UPDATE preference SET processor = ?,graphicsCardType=?,memory= ? WHERE user_id = ?";
        try (Connection conn = DriverManager.getConnection(url, user, pasword);
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, processor);
            stmt.setString(2, graphicsCardType);
            stmt.setString(3, memory);
            stmt.setInt(4, user_id);

            return stmt.executeUpdate() > 0; // Returns true if update was successful
        }
    }
}

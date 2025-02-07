/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Aydin Shidqi
 */
public class User {
    private int user_id;
    private String username; 
    private String email; 
    private String password; 
    private int preference_id;
    private Preference preference;

    public User(int user_id, String username, String email, String password, int preference_id) {
        this.user_id = user_id;
        this.username = username;
        this.email = email;
        this.password = password;
        this.preference_id = preference_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getPreference_id() {
        return preference_id;
    }
    
     public Preference getPreference() {
        return preference;
    }

    public void setPreference_id(int preference_id) {
        this.preference_id = preference_id;
    }
    
    public void setPreference(Preference preference) {
        this.preference = preference;
    }
    
}

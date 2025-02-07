/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Aydin Shidqi
 */
public class Preference {

    private int preference_id;
    private int user_id;
    private String processor;
    private String graphicsCardType;
    private int memory;

    public Preference(int preference_id, int user_id, String processor, String graphicsCardType, int memory) {
        this.preference_id = preference_id;
        this.user_id = user_id;
        this.processor = processor;
        this.graphicsCardType = graphicsCardType;
        this.memory = memory;
    }

    public int getPreference_id() {
        return preference_id;
    }

    public void setPreference_id(int preference_id) {
        this.preference_id = preference_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getProcessor() {
        return processor;
    }

    public void setProcessor(String processor) {
        this.processor = processor;
    }

    public String getGraphicsCardType() {
        return graphicsCardType;
    }

    public void setGraphicsCardType(String graphicsCardType) {
        this.graphicsCardType = graphicsCardType;
    }

    public int getMemory() {
        return memory;
    }

    public void setMemory(int memory) {
        this.memory = memory;
    }

}

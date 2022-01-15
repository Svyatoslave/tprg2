package com.example.storehouse;

import jakarta.servlet.http.Cookie;

public class Account {
    private String login;
    private String password;
    //private Cookie accountLevel;
    private Client client;

    public Account(String login, String password, Client client){
        this.login = login;
        this.password = password;
        this.client = client;
        Admin.addClient(client.getName(), client.getAddress(), client.getEmail(), client.getPhone(), client.getRole());
    }

    public String getLogin() {
        return login;
    }

    public String getPassword() {
        return password;
    }

    public Client getClient() {
        return client;
    }
}

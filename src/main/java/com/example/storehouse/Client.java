package com.example.storehouse;

import java.util.Random;

public class Client  {
    private static int count = 0;
    private int id;
    private String name;
    private String address;
    private String phone;
    private String email;
    private String role;

    public Client (String name, String address, String email, String phone, String role){
        this.id = ++count;
        this.name = name;
        this.address = address;
        this.email = email;
        this.phone = phone;
        this.role = role;
    }

    public Client (){
        id = ++count;
        name = randomString(10);
        address = randomString(10);
        email = randomString(10);
        phone = "89999999999";
        role = (Math.random()>(0.5)) ? Role.consumer() : Role.provider();
    }

    private String randomString(int length) {
        int leftLimit = 97;
        int rightLimit = 122;
        Random random = new Random();

        return random.ints(leftLimit, rightLimit + 1)
                .limit(length)
                .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
                .toString();
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getAddress() {
        return address;
    }

    public String getPhone() {
        return phone;
    }

    public String getEmail() {
        return email;
    }

    public String getRole() {
        return role;
    }
}

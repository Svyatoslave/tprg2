package com.example.storehouse;

import java.util.Random;

public class Products {
    private static int count = 0;
    private int id;
    private String name;
    private String type;
    private int price;
    private String expireDate;
    private int quantity;
    private String location;

    public Products(String name, String type, int price, String expireDate, int quantity, String location){
        this.id = ++count;
        this.name = name;
        this.type = type;
        this.price = price;
        this.expireDate = expireDate;
        this.quantity = quantity;
        this.location = location;
    }

    public Products() {
        id = ++count;
        name = randomString(10);
        type = randomType();
        price = 1+((int) (Math.random() * 10));
        expireDate = "01.01.2022";
        quantity = 1+((int) (Math.random() * 100));
        location = randomString(10);
    }

    private String randomString(int length) {
        int leftLimit = 97; // letter 'a'
        int rightLimit = 122; // letter 'z'
        Random random = new Random();

        return random.ints(leftLimit, rightLimit + 1)
                .limit(length)
                .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
                .toString();
    }
        private String randomType() {
        String[] myString = new String[]{"Romans", "Horror", "Detective", "Fantasy", "Education"};
int n = (int)Math.floor(Math.random() * myString.length);
return myString[n];
    }

    public int getId() {
        return id;
    }

    public int getPrice() {
        return price;
    }

    public String getType() {
        return type;
    }

    public String getExpireDate() {
        return expireDate;
    }

    public int getQuantity() {
        return quantity;
    }

    public String getLocation() {
        return location;
    }

    public String getName() {return name;}

    public void setPrice(int price) {
        this.price = price;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}

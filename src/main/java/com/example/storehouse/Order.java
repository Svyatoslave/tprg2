package com.example.storehouse;

public class Order {
    public static int count = 0;
    private int id;
    private String dateTime;
    private Products product;
    private Client client;
    private int quantity;
    private String direction;

    public Order(String dateTime, Products product, int quantity, String  direction, Client client) {
        this.id = ++count;
        this.dateTime = dateTime;
        this.product = product;
        this.quantity = quantity;
        this.direction = direction;
        this.client = client;
    }

    public Order(){
        id = ++count;
        dateTime = "06.07.2022";
        product = new Products();
        quantity = 1+((int) (Math.random() * 10));
        direction = (Math.random()>(0.5)) ? Direction.in() : Direction.out();
        client = new Client();
    }

    public int getId() {
        return id;
    }

    public Products getProduct() {
        return product;
    }

    public String getDateTime() {
        return dateTime;
    }

    public int getQuantity() {
        return quantity;
    }

    public Client getClient() {
        return client;
    }

    public String getDirection() {
        return direction;
    }
}

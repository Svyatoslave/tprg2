package com.example.storehouse;

public class Warehouse {
    public static int maxQuantity = 1000;
    public static int getAvailableQuantity(){
        int counter = 0;
        for (Products product: Database.productList){
            counter += product.getQuantity();
        }
        return maxQuantity-counter;
    }
}

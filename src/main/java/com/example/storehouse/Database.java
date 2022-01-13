package com.example.storehouse;
import java.util.ArrayList;

public class Database {
    public static ArrayList<Products> productList = new ArrayList<>();
    public static ArrayList<Order> orderList = new ArrayList<>();
    public static ArrayList<Client> clientList = new ArrayList<>();
    public static ArrayList<Account> accountList = new ArrayList<>();
    public static boolean isEnable = false;

    public static void Init (int productNum, int clientNum, int orderNum){
//        productList = new ArrayList<>();
//        clientList = new ArrayList<>();
//        orderList = new ArrayList<>();
        for(int i = 0; i < productNum; i++){
            Database.productList.add(new Products());
        }
        for(int i = 0; i < clientNum; i++){
            Database.clientList.add(new Client());
        }
        for(int i = 0; i < orderNum; i++){
            Database.orderList.add(new Order());
        }
        isEnable = true;
    }
    public static Products getProductByID(int id){
        for (Products product : productList) {
            int productId = product.getId();
            if (id == productId) {
                return product;
            }
        }
        return null;
    }
    public static Products getProductByName(String name){
        for (Products product : productList) {
            String productName = product.getName();
            if (productName.equals(name)) {
                return product;
            }
        }
        return null;
    }
    public static Client getClientByID(int id){
        for (Client client : clientList) {
            int clientId = client.getId();
            if (id == clientId) {
                return client;
            }
        }
        return null;
    }

    public static Client getClientByName(String name){
        for (Client client : clientList) {
            String clientName = client.getName();
            if (clientName.equals(name)) {
                return client;
            }
        }
        return null;
    }

    public static Order getOrderByID(int id){
        for (Order order : orderList) {
            int orderId = order.getId();
            if (id == orderId) {
                return order;
            }
        }
        return null;
    }

    public static Account getAccountByLogin(String login) {
        for (Account account : accountList) {
            String accountLogin = account.getLogin();
            if (accountLogin.equals(login)) {
                return account;
            }
        }
        return null;
    }
}

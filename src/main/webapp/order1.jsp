<%@ page import="javax.xml.crypto.Data" %>
<%@ page import="com.example.storehouse.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Objects" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    if (!Database.isEnable) Database.Init(10, 10, 10);
    boolean isLoggedIn = false;
    boolean isAvailable = true;
    Cookie[] cookies = request.getCookies();
    String cookieName = "status";
    Cookie cookie = null;
    if(cookies != null) {
        for(Cookie c: cookies) {
            if(cookieName.equals(c.getName())) {
                cookie = c;
                break;
            }
        }
    }
    boolean isBigger = false;
    if (cookie != null) {
        isLoggedIn = true;
        if (request.getParameter("add-button1") != null) {
            String productName = request.getParameter("product-name");
            String clientName = request.getParameter("client-name");
            String date = request.getParameter("date");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String direction = "Выдача";
            Products product = Database.getProductByName(productName);
            Client client = Database.getClientByName(clientName);
            if (product != null && client != null) {
                int quantityDifference = product.getQuantity() - quantity;
                if (quantityDifference >= 0) {
                    if (quantityDifference == 0) {
                        Admin.removeProduct(product.getId());
                    }
                    Admin.addOrder(date, product, quantity, direction, client);
                    product.setQuantity(quantityDifference);
                } else {
                    isBigger = true;
                }
            }
        }
        if (request.getParameter("delete-button1") != null) {
            for (int i = Database.orderList.size() - 1; i >= 0; i--) {
                if (request.getParameter("checkbox" + Database.orderList.get(i).getId()) != null) {
                    System.out.println(request.getParameter("checkbox" + Database.orderList.get(i).getId()));
                    Admin.removeOrder(Database.orderList.get(i).getId());
                }
            }
        }
        if (request.getParameter("add-button2") != null) {
            String productName = request.getParameter("product-name");
            String productType = request.getParameter("product-type");
            String type = request.getParameter("product-type");
            int price = Integer.parseInt(request.getParameter("product-price"));
            String expireDate = request.getParameter("expire-date");
            String location =request.getParameter("product-location");
            String clientName = request.getParameter("client-name");
            String deliveryDate = request.getParameter("date");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String direction = "Поставка";
            Client client = Database.getClientByName(clientName);
            if (client != null) {
                if (Warehouse.getAvailableQuantity() >= quantity) {
                    Admin.addProduct(productName, productType, price, expireDate, quantity, location);
                    Admin.addOrder(deliveryDate, Database.getProductByName(productName), quantity, direction, client);
                }
                else{
                    isAvailable = false;
                }
            }
        }
        if (request.getParameter("delete-button2") != null) {
            for (int i = Database.orderList.size() - 1; i >= 0; i--) {
                if (request.getParameter("checkbox" + Database.orderList.get(i).getId()) != null) {
                    System.out.println(request.getParameter("checkbox" + Database.orderList.get(i).getId()));
                    Admin.removeOrder(Database.orderList.get(i).getId());
                }
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Заказы</title>
    <link rel='stylesheet' type='text/css' href='style/style.css' />
    <script>
        function searchByDate() {
            const date1 = new Date(document.getElementById('date1').value);
            const date2 = new Date(document.getElementById('date2').value);
            console.log(isNaN(date2.getTime()));
            if (!isNaN(date2.getTime()) && !isNaN(date1.getTime())) {
                const givenDiff = Math.ceil(date2 - date1) / (1000 * 60 * 60 * 24);
                console.log(givenDiff);
                if (givenDiff < 0) {
                    document.getElementById('wrong-date').innerHTML = "Первая дата больше второй (ошибка)";
                } else {
                    let firstTable = document.getElementById('table-id');
                    for (let i = 1; i < firstTable.rows.length; i++) {
                        let flag = false;
                        let date3 = new Date(firstTable.rows[i].cells[4].innerHTML);
                        console.log(date3);
                        let resultDiff = Math.ceil(date2 - date3) / (1000 * 60 * 60 * 24);
                        if (resultDiff <= givenDiff && resultDiff >= 0) {
                            console.log(givenDiff);
                            flag = true;
                        }
                        if (flag) {
                            firstTable.rows[i].style.display = "";
                        }
                        if (!flag) {
                            firstTable.rows[i].style.display = "none";
                        }
                    }
                    let secondTable = document.getElementById('table-id2');
                    for (let i = 1; i < secondTable.rows.length; i++) {
                        let flag = false;
                        let date3 = new Date(secondTable.rows[i].cells[4].innerHTML);
                        console.log(date3);
                        let resultDiff = Math.ceil(date2 - date3) / (1000 * 60 * 60 * 24);
                        if (resultDiff <= givenDiff && resultDiff >= 0) {
                            console.log(givenDiff);
                            flag = true;
                        }
                        if (flag) {
                            secondTable.rows[i].style.display = "";
                        }
                        if (!flag) {
                            secondTable.rows[i].style.display = "none";
                        }
                    }
                    document.getElementById('wrong-date').innerHTML = "";
                }
            }
        }
    </script>
</head>
<body>
<%if (isBigger){%>
<%="<script>alert(\"Превышено количество запрашиваемого товара\")</script>"%>
<%}%>
<%if (!isAvailable){%>
<%="<script>alert(\"Недостаточно места на складе\")</script>"%>
<%}%>
<%if (!isLoggedIn){
    if(request.getParameter("add-button1")!=null || request.getParameter("delete-button1")!=null ||
            request.getParameter("add-button2")!=null || request.getParameter("delete-button2")!=null){%>
<%="<script>alert(\"Вы не вошли в аккаунт чтобы работать с заказами\")</script>"%>
<%}}%>
<header>
    <img class="logo" src="images/temp.png" alt="logo pic">
     <nav>
        <ul class="nav-links">
            <li><a href="index.jsp">Главная</a></li>
            <li><a href="products1.jsp">Книги</a></li>
            <li><a href="order1.jsp">Мои Заказы</a></li>
            <% if (cookie != null){%>
            <%="<li style=\"color: aquamarine\">User: "+cookie.getValue()+"</li>"%>
            <%}%>
        </ul>
    </nav>
    <% if (cookie != null){%>
              <a class="cta" href="authorization.jsp"><button>Выйти</button></a>
            <%}else{%>
            <a class="cta" href="authorization.jsp"><button>Войти</button></a>
		<%}%>
</header>
<main>
    <div class="main-area" style="padding-left: 10%">
        <h3 style="margin-bottom: 15px">Поиск заказов по датам</h3>
        <input type="date" id="date1" class="input-background" onchange="searchByDate()">
        <input type="date" id="date2" class="input-background" onchange="searchByDate()">
        <span id="wrong-date"></span><br>
        <h3 style="margin-top: 30px">Мои заказы:</h3>
        <div class="flex-box" style="margin-bottom: 50px">
            <div class="table-form">
                <form action="" method="post">
                    <table id="table-id" class="product-table">
                        <thead>
                        <tr>
                            <th></th>
                            <th>ID</th>
                            <th>Названиие товара</th>
                            <th>Имя</th>
                            <th>Дата</th>
                            <th>Количество</th>
                            <th>Тип заказа</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
			if (cookie != null){
			String loginsh=cookie.getValue();
			 for (Order order : Database.orderList) {
			 if (loginsh.equals(order.getClient().getName()))
                            {
                        %>
                        <tr>
                            <td><input type="checkbox" name=<%="checkbox" + order.getId()%> value="<%=order.getId()%>"></td>
                            <td><%=order.getId()%></td>
                            <td><%=order.getProduct().getName()%></td>
                            <td><%=order.getClient().getName()%></td>
                            <td><%=order.getDateTime()%></td>
                            <td><%=order.getQuantity()%></td>
                            <td><%=order.getDirection()%></td>
                        </tr>
                        <%  }}%>
				<%}else{%>	
			<h1>Чтобы посмотреть заказы сначала авторизируйтесь</h1>
														      <%}%>	
                        </tbody>
                    </table>
                    <input class="input-background" type="submit" name="delete-button1" value="Удалить">
                </form>
            </div>
        </div>
    </div>
</main>
</body>
</html>

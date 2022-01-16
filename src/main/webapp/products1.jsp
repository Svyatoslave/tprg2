<%@ page import="javax.xml.crypto.Data" %>
<%@ page import="com.example.storehouse.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
//    String dateTime= LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-dd-MM")).toString();
//    System.out.println(dateTime);
    boolean isLoggedIn = false;
    boolean isAvailable = true;
    if (!Database.isEnable)Database.Init(10, 10, 10);
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
    if (cookie != null ) {
        isLoggedIn = true;
        if (request.getParameter("add-button") != null) {
            String name = request.getParameter("productName");
            String type = request.getParameter("productType");
            int price = Integer.parseInt(request.getParameter("productPrice"));
            String date = request.getParameter("expireDate");
            int quantity = Integer.parseInt(request.getParameter("productQuantity"));
            String location = request.getParameter("productLocation");
            if (Warehouse.getAvailableQuantity() >= quantity){
                Admin.addProduct(name, type, price, date, quantity, location);
            }
            else {
                isAvailable = false;
            }
        }
        if (request.getParameter("check-button") != null) {
            for (int i = Database.productList.size() - 1; i >= 0; i--) {
				String login=cookie.getValue();
				int quantity = 1;
				String direction="Processed";
                if (request.getParameter("checkbox" + Database.productList.get(i).getId()) != null) {
                    System.out.println(request.getParameter("checkbox" + Database.productList.get(i).getId()));
                    Admin.checkProduct(Database.productList.get(i).getId(),login,direction,quantity,Database.productList.get(i).getName(),Database.productList.get(i).getExpireDate());
                }
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Products</title>
    <link rel='stylesheet' type='text/css' href='style/style.css' />
    <script>
        function tableSearch() {
            var phrase = document.getElementById('search-text');
            var table = document.getElementById('table-id');
            var regPhrase = new RegExp(phrase.value, 'i');
            var flag = false;
            for (var i = 1; i < table.rows.length; i++) {
                flag = false;
                for (var j = table.rows[i].cells.length - 1; j >= 0; j--) {
                    flag = regPhrase.test(table.rows[i].cells[j].innerHTML);
                    if (flag) break;
                }
                if (flag) {
                    table.rows[i].style.display = "";
                } else {
                    table.rows[i].style.display = "none";
                }
            }
        }
    </script>
</head>
<body>
<%if (!isAvailable){%>
<%="<script>alert(\"Недостаточно места на складе\")</script>"%>
<%}%>
<%if (!isLoggedIn){
    if(request.getParameter("add-button")!=null || request.getParameter("delete-button")!=null){%>
<%="<script>alert(\"Вы не являетесь админом, зайдитие под аккаунтом админа чтобы работать с записями\")</script>"%>
    <%}}%>
<header>
    <img class="logo" src="images/temp.png" alt="logo pic">
     <nav>
        <ul class="nav-links">
            <li><a href="index.jsp">Главная</a></li>
            <li><a href="products1.jsp">КНиги</a></li>
            <li><a href="order1.jsp">Мои Заказы</a></li>
            <% if (cookie != null){%>
            <%="<li style=\"color: aquamarine\">User: "+cookie.getValue()+"</li>"%>
            <%}%>
        </ul>
    </nav>
    <a class="cta" href="autho
    <a class="cta" href="authorization.jsp"><button>Войти</button></a>
</header>
<main>
    <div class="main-area" style="padding-left: 10%">
        <div style="margin-bottom: 30px ">
            <h3>Поиск</h3>
            <input class="input-background" type="text" placeholder="Поиск" id="search-text" onkeyup="tableSearch()">
        </div>
        <div class="flex-box">
            <div class="table-form">
                <h3>Товары</h3>
                <form action="" method="post">
                    <table id="table-id" class="product-table">
                        <thead>
                        <tr>
                            <th></th>
                            <th>ID</th>
                            <th>Названиие книги</th>
                            <th>Жанр</th>
                            <th>Цена</th>
                            <th>Дата публикации</th>
                            <th>Кол-во</th>
                            <th>Автор</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            for(Products product: Database.productList) {%>
                        <tr>
                            <td><input type="checkbox" name=<%="checkbox"+product.getId()%> value="<%=product.getId()%>"></td>
                            <td><%=product.getId()%></td>
                            <td><%=product.getName()%></td>
                            <td><%=product.getType()%></td>
                            <td><%=product.getPrice()%></td>
                            <td><%=product.getExpireDate()%></td>
                            <td><%=product.getQuantity()%></td>
                            <td><%=product.getLocation()%></td>
                        </tr>
                        <%  }%>
                        </tbody>
                    </table>
                    <input class="input-background" type="submit" name="check-button" value="Заказать">
                </form>
            </div>
        </div>
    </div>
</main>
</body>
</html>
</body>
</html>

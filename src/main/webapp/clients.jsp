<%@ page import="javax.xml.crypto.Data" %>
<%@ page import="com.example.storehouse.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    if (!Database.isEnable)Database.Init(10, 10, 10);
    boolean isLoggedIn = false;
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
    if (cookie != null && cookie.getValue().equals("admin")) {
        isLoggedIn = true;
        if (request.getParameter("add-button") != null) {
            String fullName = request.getParameter("full-name");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String role = request.getParameter("role");
            System.out.println(role);
            Admin.addClient(fullName, address, email, phone, role);
            System.out.println(Database.clientList.get(Database.clientList.size() - 1).getRole());
        }
        if (request.getParameter("delete-button") != null) {
            for (int i = Database.clientList.size() - 1; i >= 0; i--) {
                if (request.getParameter("checkbox" + Database.clientList.get(i).getId()) != null) {
                    System.out.println(request.getParameter("checkbox" + Database.clientList.get(i).getId()));
                    Admin.removeClient(Database.clientList.get(i).getId());
                }
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Клиенты</title>
    <link rel='stylesheet' type='text/css' href='style/style.css' />
    <script>
        function tableSearch() {
            var phrase = document.getElementById('search-text');
            var firstTable = document.getElementById('table-id2');
            var regPhrase = new RegExp(phrase.value, 'i');
            var firstFlag = false;
            for (let i = 1; i < firstTable.rows.length; i++) {
                firstFlag = false;
                for (let j = firstTable.rows[i].cells.length - 1; j >= 0; j--) {
                    firstFlag = regPhrase.test(firstTable.rows[i].cells[j].innerHTML);
                    if (firstFlag) break;
                }
                if (firstFlag) {
                    firstTable.rows[i].style.display = "";
                } else {
                    firstTable.rows[i].style.display = "none";
                }
            }
            var secondTable = document.getElementById('table-id1');
            var secondFlag = false;
            for (let i = 1; i < secondTable.rows.length; i++) {
                secondFlag = false;
                for (let j = secondTable.rows[i].cells.length - 1; j >= 0; j--) {
                    secondFlag = regPhrase.test(secondTable.rows[i].cells[j].innerHTML);
                    if (secondFlag) break;
                }
                if (secondFlag) {
                    secondTable.rows[i].style.display = "";
                } else {
                    secondTable.rows[i].style.display = "none";
                }
            }
        }
    </script>
</head>
<body>
<%if (!isLoggedIn){
    if(request.getParameter("add-button")!=null || request.getParameter("delete-button")!=null){%>
<%="<script>alert(\"Вы не являетесь админом, зайдитие под аккаунтом админа чтобы работать с записями\")</script>"%>
<%}}%>
<header>
    <img class="logo" src="images/temp.png" alt="logo pic">
    <nav>
        <ul class="nav-links">
            <li><a href="index1.jsp">Главная</a></li>
            <li><a href="products.jsp">Книги</a></li>
            <li><a href="order.jsp">Заказы</a></li>
            <li><a href="clients.jsp">Клиенты</a></li>
            <% if (cookie != null){%>
            <%="<li style=\"color: white\">User: "+cookie.getValue()+"</li>"%>
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
    <div class="main-area">
        <div style="margin-bottom: 30px">
            <h3 style="margin: 15px 0 15px 10% ">Поиск</h3>
            <input style="margin-left: 10%" class="input-background" type="text" placeholder="Поиск по клиентам" id="search-text" onkeyup="tableSearch()">
        </div>
        <div class="content-area">
            <form action="" method="post">
                <h3 style="">Клиенты</h3>
                <div class="client-table">
                    <table id="table-id1" class="product-table">
                        <thead>
                        <tr>
                            <th></th>
                            <th>ID</th>
                            <th>Имя</th>
                            <th>Адресс</th>
                            <th>Телефон</th>
                            <th>Почта</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            for(Client client: Database.clientList) {
                                if(client.getRole().equals("Потребитель")) {continue;}
                        %>
                        <tr>
                            <td><input type="checkbox" name=<%="checkbox"+client.getId()%> value="<%=client.getId()%>"></td>
                            <td><%=client.getId()%></td>
                            <td><%=client.getName()%></td>
                            <td><%=client.getAddress()%></td>
                            <td><%=client.getPhone()%></td>
                            <td><%=client.getEmail()%></td>
                        </tr>
                        <%  }%>
                        </tbody>
                    </table>
                     <input type="submit" name="delete-button" class="input-background" value="Удалить">
                </div>
        </div>
    </div>
</main>
</body>
</html>

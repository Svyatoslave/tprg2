<%@ page import="com.example.storehouse.*" %>
<%@ page import="javax.xml.crypto.Data" %>
<%@ page import="com.example.storehouse.Database" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    if (!Database.isEnable)Database.Init(10, 10, 10);
    String registerMessage = null;
    boolean isDouble = false;
    if (request.getParameter("register-button") != null) {
        String login = request.getParameter("login");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String role = request.getParameter("role");
        for (Account account: Database.accountList){
            if (account.getLogin().equals(login)) {
                registerMessage = "Аккаунт с таким логином уже существует";
                isDouble = true;
                break;
            }
        }
        if (!isDouble){
            Client client = new Client(name, address, email, phone, role);
            Admin.addAccount(login, password, client);
            response.sendRedirect("authorization.jsp");
        }
    }
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
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registration</title>
    <link rel='stylesheet' type='text/css' href='style/style.css' />
</head>
<body>
<header>
    <img class="logo" src="images/temp.png" alt="logo pic">
    <nav>
        <ul class="nav-links">
            <li><a href="index.jsp">Главная</a></li>
            <li><a href="products.jsp">Товары</a></li>
            <li><a href="order.jsp">Заказы</a></li>
            <li><a href="clients.jsp">Клиенты</a></li>
            <% if (cookie != null){%>
            <%="<li style=\"color: aquamarine\">User: "+cookie.getValue()+"</li>"%>
            <%}%>
        </ul>
    </nav>
    <a class="cta" href="authorization.jsp"><button>Войти</button></a>
</header>
<main>
    <div class="main-area">
        <div class="login-area">
            <form action="" method="post">
                Логин: <input style="width: 192px;" class="input-background" required type="text" name="login"><br>
                Пароль: <input class="input-background" required type="password" name="password"><br>
                Имя: <input style="width: 205px;" class="input-background" required type="text" name="name"><br>
                Адресс: <input style="width: 185px;" class="input-background" required type="text" name="address"><br>
                Телефон: <input style="width: 177px;" class="input-background" required type="text" name="phone"><br>
                Почта: <input style="width: 192px;" class="input-background" required type="text" name="email"><br>
                Роль:
                <select style="width: 202px;" name="role" class="input-background" id="">
                    <option value="Поставщик">Поставщик</option>
                    <option value="Потребитель">Потребитель</option>
                </select><br>
                <input style="width: 150px; margin-left: 17%; text-align: center" class="input-background" type="submit" name="register-button" value="Зарегистрироваться">
            </form>
            <p><%if(registerMessage != null)%><%=registerMessage%></p>
        </div>
    </div>
</main>
</body>
</html>
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
        String name = login;
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String role = "Поставщик";
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
            <li><a href="products1.jsp">Книги</a></li>
            <li><a href="order1.jsp">Мои Заказы</a></li>
            <% if (cookie != null){%>
            <%="<li style=\"color: white\">User: "+cookie.getValue()+"</li>"%>
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
                Адресс: <input style="width: 185px;" class="input-background" required type="text" name="address"><br>
                Телефон: <input style="width: 177px;" class="input-background" required type="text" name="phone"><br>
                Почта: <input style="width: 192px;" class="input-background" required type="text" name="email"><br>
                <input style="width: 150px; margin-left: 17%; text-align: center" class="input-background" type="submit" name="register-button" value="Зарегистрироваться">
            </form>
            <p><%if(registerMessage != null)%><%=registerMessage%></p>
        </div>
    </div>
</main>
</body>
</html>

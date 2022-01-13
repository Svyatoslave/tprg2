<%@ page import="com.example.storehouse.*" %>
<%@ page import="javax.xml.crypto.Data" %>
<%@ page import="com.example.storehouse.Database" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    if (!Database.isEnable)Database.Init(10, 10, 10);
    String loginMessage = null;
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
    if (cookie == null) {
        if (request.getParameter("login-button") != null && request.getParameter("login") != null && request.getParameter("password") != null) {
            String login = request.getParameter("login");
            String password = request.getParameter("password");
            if (login.equals(Admin.login) && password.equals(Admin.password)){
                Cookie status = new Cookie("status", "admin");
                status.setMaxAge(24 * 60 * 60);
                response.addCookie(status);
                response.sendRedirect("index.jsp");
            }
            else {
                for (Account account : Database.accountList) {
                    if (login.equals(account.getLogin()) && password.equals(account.getPassword())) {
                        Cookie status = new Cookie("status", account.getLogin());
                        status.setMaxAge(24 * 60 * 60);
                        response.addCookie(status);
                        response.sendRedirect("index.jsp");
                    }
                }
            }
            loginMessage = "Неверный логин или пароль";
        }
    }
    else {
        if (request.getParameter("login-button") != null && request.getParameter("login") != null && request.getParameter("password") != null) {
            String login = request.getParameter("login");
            String password = request.getParameter("password");
            if (login.equals(Admin.login) && password.equals(Admin.password)){
                cookie.setValue("admin");
                cookie.setMaxAge(24 * 60 * 60);
                response.addCookie(cookie);
                System.out.println(cookie.getName() + "=" + cookie.getValue());
                response.sendRedirect("index.jsp");
            }
            else {
                for (Account account : Database.accountList) {
                    if (login.equals(account.getLogin()) && password.equals(account.getPassword())) {
                        cookie.setValue(account.getLogin());
                        cookie.setMaxAge(24 * 60 * 60);
                        response.addCookie(cookie);
                        System.out.println(cookie.getName() + "=" + cookie.getValue());
                        response.sendRedirect("index.jsp");
                    }
                }
            }
            loginMessage = "Неверный логин или пароль";
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Authorization</title>
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
                <input style="width: 100px; margin-left: 25%; text-align: center" class="input-background" type="submit" name="login-button" value="Войти">
            </form>
            <input style="width: 100px; margin-left: 25%; text-align: center"  class="input-background" type="submit" name="login-button" value="Регистрация" onclick="window.location.href = 'registration.jsp';">
            <p><%if(loginMessage != null)%><%=loginMessage%></p>
        </div>
    </div>
</main>
</body>
</html>
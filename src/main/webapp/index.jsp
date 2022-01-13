<%@ page import="com.example.storehouse.*" %>
<%@ page import="javax.xml.crypto.Data" %>
<%@ page import="com.example.storehouse.Database" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
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
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Main</title>
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
                <div class="content-area">
                    <div class="img-area">
                        <img src="images/warehouse.jpg" alt="">
                    </div>
                    <div class="text-area">
                    <span>
                        Добро пожаловать в приложение складского учета. <br>
                        Приложение создано для курса "Технологии программирования" в рамках лабораторной работы № 2.<br>
                        В данном приложении имеется возможность просматривать уже существующие товары, заказы и существующих клиентов.<br>
                        Помимо этого, для авторизованных пользователей (админов) имеется возможность добавлять/удалять клиентов, новые
                        товары и заказы (поставки и выдачи).<br>
                        Кроме того, имеется возможность получить данные и поставках и выдачах за указанный период времени.<br>
                        Приятного пользования!
                    </span>
                    </div>
                </div>
            </div>
        </main>
    </body>
</html>
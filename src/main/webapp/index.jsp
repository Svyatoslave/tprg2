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
		    <% if (cookie != null){%>
            <ul class="nav-links">
		<%if (cookie.getValue()!="admin"){%>
		<li><a href="index.jsp">Главная</a></li>
            <li><a href="products1.jsp">Книги</a></li>
            <li><a href="order1.jsp">Мои Заказы</a></li>
		<%}%>
		<%if (cookie.getValue()=="admin"){%>
            <li><a href="index.jsp">Главная</a></li>
            <li><a href="products.jsp">Книги</a></li>
            <li><a href="order.jsp">Заказы</a></li>
            <li><a href="clients.jsp">Клиенты</a></li>
            <%}%>
            <% if (cookie != null){%>
            <%="<li style=\"color: aquamarine\">User: "+cookie.getValue()+"</li>"%>
            <%}%>
        </ul>
		<%}else{%>
		    <li><a href="index.jsp">Главная</a></li>
            <li><a href="products1.jsp">Книги</a></li>
            <li><a href="order1.jsp">Мои Заказы</a></li>
      <%}%>
    </nav>
		<% if (cookie != null){%>
            <a class="cta" href="authorization.jsp"><button>Выйти</button></a>
            <%}else{%>
            <a class="cta" href="authorization.jsp"><button>Войти</button></a>
		<%}%>
        </header>
        <main>
            <div class="main-area">
                <div class="content-area">
                    <div class="text-area">
                    <span>
                        Добро пожаловать в книжный интернет-магазин. <br><br>
                        В данном приложении вы можете найти интересующую вас книгу и заказать одну или несколько книг.<br><br>
                        Помимо этого, для авторизованных как админ-пользователей имеется возможность добавлять/удалять клиентов, книги и заказы.<br><br>
                        Приложение создано для курса "Технологии программирования" в рамках лабораторной работы № 2.<br><br>
                        Над приложением работали: Холодов С.О., Плицын В.А., Варварин Я.Е.
                    </span>
                    </div>
                </div>
            </div>
        </main>
    </body>
</html>

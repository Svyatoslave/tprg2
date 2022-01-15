 <ul class="nav-links">
		<%if (!isLoggedIn){%>
		<li><a href="index.jsp">Главная</a></li>
            <li><a href="products1.jsp">Товары</a></li>
            <li><a href="order1.jsp">Заказы</a></li>
            <li><a href="clients1.jsp">Клиенты</a></li>
		<%}%>
		<%if (isLoggedIn){%>
            <li><a href="index.jsp">Главная</a></li>
            <li><a href="products.jsp">Товары</a></li>
            <li><a href="order.jsp">Заказы</a></li>
            <li><a href="clients.jsp">Клиенты</a></li>
            <%}%>
			
            <% if (cookie != null){%>
            <%="<li style=\"color: aquamarine\">User: "+cookie.getValue()+"</li>"%>
            <%}%>
        </ul>

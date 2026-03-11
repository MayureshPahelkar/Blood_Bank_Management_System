<%
String username=request.getParameter("username");
String password=request.getParameter("password");

if("admin@gmail.com".equals(username) && "admin123".equals(password))
{
    response.sendRedirect("home.jsp");
}
else{
    response.sendRedirect("adminLogin.jsp?msg=invalid");
}
%>
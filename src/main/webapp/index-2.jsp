<%--
  Created by IntelliJ IDEA.
  User: 10850
  Date: 2022/5/19
  Time: 22:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<jsp:forward page="/emps"></jsp:forward>--%>
<%
    pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>Title</title>
    <!--引入jquery-->
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.3.1.js"></script>
    <!--引入bootstrap样式-->
    <link href="${APP_PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css" rel="stylesheet">
    <!--引入js文件-->
    <script src="${APP_PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
</head>
<body>
    <button class="btn-success">提交</button>
    <a href="${APP_PATH}/emps">跳转</a>
</body>
</html>

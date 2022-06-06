<%--
  Created by IntelliJ IDEA.
  User: 10850
  Date: 2022/5/20
  Time: 14:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <!--
    web路径：
    不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题
    以/开始的相对路径，找资源，以服务器的路径为标准：（http://localhost:3306/crud）需要加上项目名
    -->
    <!--引入jquery-->
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.3.1.js"></script>
    <!--引入bootstrap样式-->
    <link href="${APP_PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css" rel="stylesheet">
    <!--引入js文件-->
    <script src="${APP_PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
</head>
<body>
    <!--搭建显示页面-->
    <div class="container">
        <!--标题-->
        <div class="row">
            <div class="col-md-12">
                <h1>SSM-CRUD</h1>
            </div>
        </div>
        <!--新增和删除按钮-->
        <div class="row">
            <div class="col-md-4 col-md-offset-6"></div>
            <button class="btn btn-primary">新增</button>
            <button class="btn btn-danger">删除</button>
        </div>
        <!--表格-->
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover">
                    <tr>
                        <th class="col-md-2">#</th>
                        <th class="col-md-2">empName</th>
                        <th class="col-md-2">gender</th>
                        <th class="col-md-2">email</th>
                        <th class="col-md-2">departName</th>
                        <th class="col-md-4">操作</th>
                    </tr>
                    <c:forEach items="${pageInfo.list}" var="emp">
                        <tr>
                            <th class="col-md-2">${emp.empId}</th>
                            <th class="col-md-2">${emp.empName}</th>
                            <th class="col-md-2">${emp.gender=="1"?"男":"女"}</th>
                            <th class="col-md-2">${emp.email}</th>
                            <th class="col-md-2">${emp.department.deptName}</th>
                            <th class="col-md-4">
                                <button class="btn btn-primary btn-sm">
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                    编辑</button>
                                <button class="btn btn-danger btn-sm">
                                    <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                    删除</button>
                            </th>
                        </tr>
                    </c:forEach>

                </table>
            </div>
        </div>
        <!--显示分页信息-->
        <div class="row">
            <!--分页文字信息-->
            <div class="col-md-6">
                当前${pageInfo.pageNum}页,共${pageInfo.pages}页,共${pageInfo.total}条记录
            </div>
            <!--分页条信息-->
            <div class="col-md-6">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <c:if test="${pageInfo.pageNum == 1}">
                            <li class="disabled"><a href="${APP_PATH}/emps?pn=1">首页</a></li>
                        </c:if>
                        <c:if test="${pageInfo.pageNum != 1}">
                            <li><a href="${APP_PATH}/emps?pn=1">首页</a></li>
                        </c:if>

                        <c:if test="${pageInfo.hasPreviousPage}">
                            <li>
                                <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>

                        <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
                            <c:if test="${page_Num == pageInfo.pageNum}">
                                <li class="active"><a href="#">${page_Num}</a></li>
                            </c:if>
                            <c:if test="${page_Num != pageInfo.pageNum}">
                                <li><a href="${APP_PATH}/emps?pn=${page_Num}">${page_Num}</a></li>
                            </c:if>

                        </c:forEach>
                        <c:if test="${pageInfo.hasNextPage}">
                            <li>
                                <a href="${APP_PATH}/emps?pn=${pageInfo.nextPage}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>

                        <c:if test="${pageInfo.pageNum == pageInfo.pages}">
                            <li class="disabled"><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">尾页</a></li>
                        </c:if>
                        <c:if test="${pageInfo.pageNum != pageInfo.pages}">
                            <li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">尾页</a></li>
                        </c:if>

                    </ul>
                </nav>
            </div>
        </div>
    </div>

</body>
</html>

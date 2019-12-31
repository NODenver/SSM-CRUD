<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/28
  Time: 20:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--导入tablib标签库--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--开启使用el表达式--%>
<%@ page isELIgnored="false" %>
<%
    pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<html>
<head>
    <title>员工列表</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
</head>
<body>

<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button type="button" class="btn btn-primary">添加</button>
            <button type="button" class="btn btn-danger">删除</button>
        </div>
    </div>
    <div class="row">
        <table class="table table-hover">
            <thead>
            <tr>
                <th>#</th>
                <th>empName</th>
                <th>email</th>
                <th>gender</th>
                <th>deptName</th>
                <th>操作</th>
            </tr>

            </thead>
            <tbody>
               <c:forEach items="${pageinfo.list}" var="emp">
                   <tr>
                       <td>${emp.empId}</td>
                       <td>${emp.empName}</td>
                       <td>${emp.email}</td>
                       <td>${emp.gender=="M"?"男":"女"}</td>
                       <td>${emp.department.deptName}</td>
                       <td>
                           <button class="btn btn-primary btn-sm">
                               <span class="glyphicon glyphicon-pencil"></span>编辑
                           </button>
                           <button class="btn btn-danger btn-sm">
                               <span class="glyphicon glyphicon-trash"></span>删除
                           </button>
                       </td>
                   </tr>
               </c:forEach>



            </tbody>
        </table>
    </div>
    <div class="row">
        <div class="col-md-6">
            当前第${pageinfo.pageNum}页,总共${pageinfo.pages}页，总记录数${pageinfo.total}条
        </div>
        <div class="col-md 6">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li><a href="${APP_PATH}/emps">首页</a></li>
                    <c:if test="${pageinfo.hasPreviousPage}">
                        <li>
                            <a href="${APP_PATH}/emps?pn=${pageinfo.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>


                    <c:forEach items="${pageinfo.navigatepageNums}" var="item">
                        <c:if test="${item == pageinfo.pageNum}">
                            <li class="active"><a href="${APP_PATH}/emps?pn=${item}">${item}</a></li>
                        </c:if>
                        <c:if test="${item != pageinfo.pageNum}">
                            <li><a href="${APP_PATH}/emps?pn=${item}">${item}</a></li>
                        </c:if>

                    </c:forEach>
                    <c:if test="${pageinfo.hasNextPage}">
                        <li>
                            <a href="${APP_PATH}/emps?pn=${pageinfo.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>

                    <li><a href="${APP_PATH}/emps?pn=${pageinfo.pages}">末页</a></li>
                </ul>
            </nav>
        </div>
    </div>
</div>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>

    <!-- web路径：
        不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
        以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306)；需要加上项目名
                http://localhost:3306/crud
         -->
    <!-- Bootstrap -->
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script type="javascript" src="${APP_PATH}/js/jquery-3.2.1.min.js"/>
    <script type="javascript" src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h1>SSM_CRUD</h1>
        </div>
    </div>

    <div class="row">
        <div class="col-md-3 col-lg-offset-9">
            <button type="button" class="btn btn-primary">新增</button>
            <button type="button" class="btn btn-danger">删除</button>
        </div>
    </div>

    <div class="row" style="margin-top: 24px;">
        <div class="col-md-12">
            <table class="table table-bordered table-hover">
                <thead>
                <tr>
                    <th style="text-align: center">#</th>
                    <th style="text-align: center">empName</th>
                    <th style="text-align: center">gender</th>
                    <th style="text-align: center">email</th>
                    <th style="text-align: center">deptName</th>
                    <th style="text-align: center">操作</th>
                </tr>
                </thead>

                <tbody>
                <c:forEach items="${pageInfo.list }" var="emp">
                    <tr class="text-center">
                        <td>${emp.empId }</td>
                        <td>${emp.empName }</td>
                        <td>${emp.gender=="M"?"男":"女" }</td>
                        <td>${emp.email }</td>
                        <td>${emp.department.deptName }</td>
                        <td class="col-md-2">
                            <button type="button" class="btn btn-primary">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                编辑
                            </button>
                            <button type="button" class="btn btn-danger">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                删除
                            </button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <div class="row">
        <div class="col-md-6">
            当前 ${pageInfo.pageNum }页,总${pageInfo.pages }
            页,总 ${pageInfo.total } 条记录
        </div>

        <div class="col-md-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">

                    <li>
                        <a href="${APP_PATH}/emps?pn=1">首页</a>
                    </li>

                    <c:if test="${pageInfo.hasPreviousPage == true}">
                        <li>
                            <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>

                    <c:forEach items="${pageInfo.navigatepageNums }" var="page_Num">
                        <c:if test="${page_Num == pageInfo.pageNum }">
                            <li class="active"><a href="#">${page_Num }</a></li>
                        </c:if>
                        <c:if test="${page_Num != pageInfo.pageNum}">
                            <li><a href="${APP_PATH}/emps?pn=${page_Num}">${page_Num }</a></li>
                        </c:if>
                    </c:forEach>

                    <c:if test="${pageInfo.hasNextPage==true}">
                        <li>
                            <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>


                    <li>
                        <a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</div>
</body>
</html>

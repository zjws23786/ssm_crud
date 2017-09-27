<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <!-- web路径：
    不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
    以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306)；需要加上项目名
            http://localhost:3306/crud
     -->
    <!-- Bootstrap -->
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="${APP_PATH}/js/jquery-3.2.1.min.js"/>
    <script type="text/javascript" src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
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

        <div class="row">
            <table id="emps_table" class="table table-bordered table-hover" style="margin-top: 20px">
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
                </tbody>

            </table>
        </div>

        <%--显示分页信息--%>
        <div class="row">
            <%--分页文字信息--%>
            <div class="col-md-6" id="page_info_area"></div>
                <%--分页条信息--%>
            <div class="col-md-6" id="page_nav_area"></div>
        </div>

    </div>


    <script type="text/javascript">
        $(function () {
            to_page(1);
        })

        function to_page(pn) {
            $.ajax({
                url:"${APP_PATH}/emps",
                data:"pn="+pn,
                type:"GET",
                success:function (result) {
//                    console.log(result);
                    //1、解析并显示员工数据
                    build_emps_table(result);
                    //2、解析并显示分页信息
                    build_page_info(result);
                    //3、解析显示分页条数据
                    build_page_nav(result);
                }
            })
        };

        var build_emps_table = function (result) {
            //清空table中tbody表格内容
            $("#emps_table tbody").empty();
            var emps = result.data.list;
            $.each(emps,function (index, item) {
                var empIdTd = $("<td></td>").append(item.empId);
                var empNameTd = $("<td></td>").append(item.empName);
                var genderTd = $("<td></td>").append(item.gender=='M'?"男":"女");
                var emailTd = $("<td></td>").append(item.email);
                var deptNameId = $("<td></td>").append(item.department.deptName);
                var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm")
                    .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                    .append("编辑");
                //为编辑按钮添加一个自定义属性，来表示当前员工id
                editBtn.attr("edit-id",item.empId);
                var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm")
                    .append($("<span></span>")).addClass("glyphicon glyphicon-trash")
                    .append("删除");
                delBtn.attr("del-id",item.empId);
                var btnTd = $("<td></td>").addClass("col-md-2")
                    .append(editBtn)
                    .append(" ")
                    .append(delBtn);

                //在这里需注意的是：append方法执行完成以后，还是返回原来的元素
                $("<tr></tr>").addClass("text-center")
                    .append(empIdTd)
                    .append(empNameTd)
                    .append(genderTd)
                    .append(emailTd)
                    .append(deptNameId)
                    .append(btnTd)
                    .appendTo("#emps_table tbody");
            })
        };

        var build_page_info = function (result) {
            //清空该标签下的所有内容
            $("#page_info_area").empty();
            $("#page_info_area").append("当前是第"+result.data.pageNum+"页，")
                .append("总"+result.data.pages+"页，")
                .append("总"+result.data.total+"条记录");
        };

        var build_page_nav = function (result) {
            $("#page_nav_area").empty();

            var ul = $("<ul></ul>").addClass("pagination");
            //构建元素
            var firstPageLi = $("<li></li>")
                .append($("<a></a>").append("首页").attr("href","#"));
            var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"))
            if (result.data.hasPreviousPage == false){
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            }else{
                //为元素添加点击
                firstPageLi.click(function () {
                    to_page(1);
                });

                prePageLi.click(function () {
                   to_page(result.data.pageNum -1)
                });

            }

            ul.append(firstPageLi)
                .append(prePageLi);


            var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
            var lastPageLi = $("<li></li>").append($("<a></a>").append("末页"));

            if (result.data.hasNextPage == false){
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            }else{
                nextPageLi.click(function(){
                    to_page(result.data.pageNum +1);
                });
                lastPageLi.click(function(){
                    to_page(result.data.pages);
                });
            }
            ul.append(nextPageLi).append(lastPageLi);

            //把ul加入到nav
            var navEle = $("<nav></nav>").append(ul);
            navEle.appendTo("#page_nav_area");



        };

    </script>

</body>
</html>

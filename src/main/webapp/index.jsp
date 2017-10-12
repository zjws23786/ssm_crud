<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <!-- web路径：
    不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
    以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:8080)；需要加上项目名
            http://localhost:8080/crud
     -->
    <!-- Bootstrap -->
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.2.1.min.js"></script>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
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
            <button type="button" class="btn btn-primary" id="add_emp_info">新增</button>
            <button type="button" class="btn btn-danger" id="del_choose_emp_all">删除</button>
        </div>
    </div>

    <div class="row">
        <table id="emps_table" class="table table-bordered table-hover" style="margin-top: 20px">
            <thead>
            <tr>
                <th style="text-align: center"><input type="checkbox" id="checkbox_all"/></th>
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


<!-- 新增 模态框Modal -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">新增员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <%--用户名--%>
                    <div class="form-group">
                        <label for="empName_add_modal" class="col-sm-2 control-label">用户名</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" name="empName" id="empName_add_modal" placeholder="用户名">
                            <span class="help-block"></span>
                        </div>
                    </div>
                        <%--性别--%>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-7">
                            <label class="radio-inline">
                                <input type="radio" name="gender" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" value="W"> 女
                            </label>
                        </div>
                    </div>
                        <%--email--%>
                    <div class="form-group">
                        <label for="email_add_modal" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-7">
                            <input name="email" class="form-control" id="email_add_modal" placeholder="邮箱">
                            <span class="help-block"></span>
                        </div>
                    </div>
                        <%--部门--%>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-7">
                            <select class="form-control" id="emp_add_modal_dept_list" name="deptid">
                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="emp_add_btn">新增</button>
            </div>
        </div>
    </div>
</div>

<!-- 修改 模态框Modal -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <%--用户名--%>
                    <div class="form-group">
                        <label for="empName_add_modal" class="col-sm-2 control-label">用户名</label>
                        <div class="col-sm-7">
                            <p class="form-control-static" id="empName_update_modal"></p>
                        </div>
                    </div>
                    <%--性别--%>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-7">
                            <label class="radio-inline">
                                <input type="radio" name="gender" value="M" id="man_update_id"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" value="W" id="woman_update_id"> 女
                            </label>
                        </div>
                    </div>
                    <%--email--%>
                    <div class="form-group">
                        <label for="email_add_modal" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-7">
                            <input name="email" class="form-control" id="email_update_modal" placeholder="邮箱">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <%--部门--%>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-7">
                            <select class="form-control" id="emp_update_modal_dept_list" name="deptid">
                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">修改</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var totalRecord; //总记录数，作用用于跳转到最后一页
    var currentPage; //当前页面
    $(function () {
        to_page(1);
    })

    function to_page(pn) {
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn=" + pn,
            type: "GET",
            success: function (result) {
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
        console.log(result);
        //清空table中tbody表格内容
        $("#emps_table tbody").empty();
        var emps = result.data.list;
        $.each(emps, function (index, item) {
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName==null ? "":item.empName);
            var genderTd = $("<td></td>").append(item.gender == 'M' ? "男" : "女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameId = $("<td></td>").append(item.department.deptName==null ? "":item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit-btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                .append("编辑");
            //为编辑按钮添加一个自定义属性，来表示当前员工id
            editBtn.attr("edit-id", item.empId);
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm del-btn")
                .append($("<span></span>")).addClass("glyphicon glyphicon-trash")
                .append("删除");
            delBtn.attr("del-id", item.empId);
            var btnTd = $("<td></td>").addClass("col-md-2")
                .append(editBtn)
                .append(" ")
                .append(delBtn);

            //在这里需注意的是：append方法执行完成以后，还是返回原来的元素
            $("<tr></tr>").addClass("text-center")
                .append(checkBoxTd)
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
        $("#page_info_area").append("当前是第" + result.data.pageNum + "页，")
            .append("总" + result.data.pages + "页，")
            .append("总" + result.data.total + "条记录");
        totalRecord = result.data.total;
        currentPage = result.data.pageNum;
    };

    var build_page_nav = function (result) {
        $("#page_nav_area").empty();

        var ul = $("<ul></ul>").addClass("pagination");
        //构建元素
        var firstPageLi = $("<li></li>")
            .append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").attr("href","#").append("&laquo;"))
        if (result.data.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            //为元素添加点击
            firstPageLi.click(function () {
                to_page(1);
            });

            prePageLi.click(function () {
                to_page(result.data.pageNum - 1)
            });
        }

        ul.append(firstPageLi)
            .append(prePageLi);

        $.each(result.data.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").attr("href","#").append(item));
            if (result.data.pageNum == item) {
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });

        var nextPageLi = $("<li></li>").append($("<a></a>").attr("href","#").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").attr("href","#").append("末页"));
        if (result.data.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            nextPageLi.click(function () {
                to_page(result.data.pageNum + 1);
            });
            lastPageLi.click(function () {
                to_page(result.data.pages);
            });
        }
        ul.append(nextPageLi).append(lastPageLi);

        //把ul加入到nav
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    };

    //点击新增弹出框
    $("#add_emp_info").click(function () {
        reset_form_data("#empAddModal form");
        getDepts("#emp_add_modal_dept_list");
        $("#empAddModal").modal({
            backdrop:"static"
        });
    });

    //获取所有部门数据
    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
            url:"${APP_PATH}/depts",
            type:"GET",
            success:function (deptResult) {
                $.each(deptResult.data,function (index,dept) {
                    var option = $("<option></option>").append(dept.deptName).attr("value",this.deptId);;
                    option.appendTo(ele);
                })
            }
        })
    }

    //清空表单数据
    function reset_form_data(ele) {
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }


    //保存新增的员工
    $("#emp_add_btn").click(function () {
        //1、先对要提交给服务器的数据进行校验
        if (!validate_add_form()){
            return false;
        }

        //检查用户名是否是唯一性
        if($(this).attr("ajax-va")=="error"){
            show_validate_msg("#empName_add_modal", "error", "用户名已存在");
            return false;
        }

        //2、发送ajax请求来保存新增的员工
        $.ajax({
            url:"${APP_PATH}/emp",
            type:"POST",
            data:$("#empAddModal form").serialize(), //表单系列化【要求表单中数据name值和业务层实体bean的名称一样】
            success:function (result) {
                if(result.rCode == 0){
                    //1、关闭模态框
                    $("#empAddModal").modal("hide");
                    //2、发送ajax请求显示最后一页数据
                    to_page(totalRecord);
                }else {
                    //有哪个字段的错误信息就显示哪个字段的；
                    if(undefined != result.data.email){
                        //显示邮箱错误信息
                        show_validate_msg("#email_add_modal", "error", result.data.email);
                    }
                    if(undefined != result.data.empName){
                        //显示员工名字的错误信息
                        show_validate_msg("#empName_add_modal", "error", result.data.empName);
                    }
                }
            }
        });
    });

    //校验表单数据
    function validate_add_form() {
        //1、部门名称  校验
        var empName = $("#empName_add_modal").val();
        //字母或数字长度6到16位，或者中文2到5位
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(empName)){
            //alert("用户名可以是2-5位中文或者6-16位英文和数字的组合");
            show_validate_msg("#empName_add_modal", "error", "用户名可以是2-5位中文或者6-16位英文和数字的组合");
            return false;
        }else{
            show_validate_msg("#empName_add_modal", "success", "");
        }

        //2、校验邮箱信息
        var email = $("#email_add_modal").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)){
            show_validate_msg("#email_add_modal", "error", "邮箱格式不正确");
            return false;
        }else{
            show_validate_msg("#email_add_modal", "success", "");
        }
        return true;
    }

    //显示校验结果的提示信息
    function show_validate_msg(ele, status,msg) {
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if ("success" == status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if ("error" ==  status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    //校验用户名是否可用（唯一性）
    $("#empName_add_modal").change(function () {
        //发送ajax请求校验用户名是否可用
        var empName = this.value;
        $.ajax({
            url:"${APP_PATH}/checkuser",
            data:"empName="+empName,
            type:"POST",
            success:function(result){
                if(result.rCode==0){
                    show_validate_msg("#empName_add_modal","success","用户名可用");
                    $("#emp_add_btn").attr("ajax-va","success");
                }else{
                    show_validate_msg("#empName_add_modal","error",result.data);
                    $("#emp_add_btn").attr("ajax-va","error");
                }
            }
        });
    });

    /**********************************修改模块************************************************/
    $(document).on("click",".edit-btn",function(){
        $("#empUpdateModal form")[0].reset(); //清空弹出框内容
        //1、获取部门
        getDepts("#emp_update_modal_dept_list");

        //2、获取员工数据
        var empId = $(this).attr("edit-id");
        $.ajax({
            url:"${APP_PATH}/emp",
            data:"empId="+empId,
            type:"GET",
            success:function (result) {
                $("#empName_update_modal").text(result.data.empName);
                $("#email_update_modal").val([result.data.email]);
                $("#empUpdateModal input[name=gender]").val([result.data.gender]);
                $("#empUpdateModal select").val([result.data.deptid]);
                $("#emp_update_btn").attr("update_emp_id",result.data.empId);
            }
        });


        $("#empUpdateModal").modal({
            backdrop:"static"
        });
    });

    //修改按钮事件处理
    $("#emp_update_btn").click(function () {
        var email = $("#email_update_modal").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)){
            show_validate_msg("#email_add_modal", "error", "邮箱格式不正确");
            return;
        }

        var empId = $(this).attr("update_emp_id");
        $.ajax({
            url:"${APP_PATH}/empupdate/"+empId,
            data:$("#empUpdateModal form").serialize(),
            type:"PUT",
            success:function (result) {
                //1、关闭对话框
                $("#empUpdateModal").modal("hide");
                //2、回到本页面
                to_page(currentPage);
            }
        });
    });

    /********************复选框全选或反选************************************************/
    $("#checkbox_all").click(function () {
        //attr获取checked是undefined;
        //我们这些dom原生的属性；attr获取自定义属性的值；
        //prop修改和读取dom原生属性的值
        $(".check_item").prop("checked",$(this).prop("checked"));
    });

    $(document).on("click",".check_item",function () {
        var flag = $(".check_item:checked").length == $(".check_item").length;
        $("#checkbox_all").prop("checked",flag);
    });

    /********************单个删除或多个删除**************************************************/
    //单个删除功能
    $(document).on("click",".del-btn",function(){
        var delId = $(this).attr("del-id");
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        if(confirm("确认删除【"+delId+"】吗？")){
            $.ajax({
                url:"${APP_PATH}/del/"+delId,
                type:"DELETE",
                success:function (result) {
                    to_page(currentPage);
                }
            });
        }
    });

    //批量删除
    $("#del_choose_emp_all").click(function () {
        var empNames = "";
        var delIds = "";
        $.each($(".check_item:checked"),function () {
           empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
           delIds += $(this).parents("tr").find("td:eq(1)").text() + "-";
        });
        empNames = empNames.substring(0,empNames.length-1);
        delIds = delIds.substring(0,delIds.length-1);
        if (empNames.length > 0){
            if (confirm("确认删除【"+empNames+"】吗？")){
                $.ajax({
                    url:"${APP_PATH}/del/"+delIds,
                    type:"DELETE",
                    success:function (rusult) {
                        to_page(currentPage)
                    }
                });
            }
        }

    });


</script>

</body>
</html>

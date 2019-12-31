<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/29
  Time: 14:59
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
<!-- 员工更新模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_update_input" placeholder="email@atguigu.com">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 员工添加模态框
-->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_add_input" placeholder="email@atguigu.com">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <!--项目标题-->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!--添加和删除按钮-->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button type="button" class="btn btn-primary" id="emp_modal_add_btn">添加</button>
            <button type="button" class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <!--员工信息表格-->
    <div class="row">
        <table class="table table-hover" id="emps_table">
            <thead>
            <tr>
                <th>
                    <input type="checkbox" id="check_all">
                </th>
                <th>#</th>
                <th>empName</th>
                <th>email</th>
                <th>gender</th>
                <th>deptName</th>
                <th>操作</th>
            </tr>

            </thead>
            <tbody>


            </tbody>
        </table>
    </div>
    <!--分页-->
    <div class="row">
        <!--分页信息显示-->
        <div class="col-md-6" id="page_info_area"></div>
        <!--分页栏-->
        <div class="col-md 6" id="page_nav_area"></div>
    </div>

</div>
<script type="application/javascript">
    // totalRecord：总记录数
    //currentPage：当前页
    var  totalRecord,currentPage;
    // 页面加载完成以后，获得第一页的数据并显示
    $(function () {
        to_page(1);
    });

    // 跳转到一个页面，并得到分页的数据
    function to_page(pn) {
        // 发送ajax请求，pn为页码
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn=" + pn,
            type: "get", //请求方式为get
            success: function (result) {
                // 1.构建员工信息表格
                build_emps_table(result);
                //2.构建分页信息
                build_page_info(result);
                //3.构建分页栏
                build_page_nav(result);
            }
        })
    }

    // 构建员工数据表格
    function build_emps_table(result) {
        //1.清空table中的数据，不然会叠加显示，ajax是无刷新方式
        $("#emps_table tbody").empty();
        //从返回的json字符串中的到员工信息
        let list = result.extend.pageinfo.list;
        //遍历员工数据并显示
        $.each(list, function (index, item) {
            //构建前面的单选框，并设置class为check_item
            let checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            //构建empId
            let empIdTd = $("<td></td>").append(item.empId);
            //构建empName
            let empNameTd = $("<td></td>").append(item.empName);
            //构建email
            let emailTd = $("<td></td>").append(item.email);
            //构建gender，并且通过三元运算，如果是'M'就显示男，'F'就显示女
            let genderTd = $("<td></td>").append(item.gender == "M" ? "男" : "女");
            //构建deptName
            let deptNameTd = $("<td></td>").append(item.department.deptName);
            //构建数据后面的编辑按钮，并添加自定义属性edit-id为当前这条数据的empId
            let editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn").append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑").attr("edit-id",item.empId);
            //构建数据后面的删除按钮，并添加自定义属性delete-id为当前这条数据的empId
            let delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn").append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除").attr("delete-id",item.empId);
            //将editBtn 和deleteBtn加入到一个td中，并且用空格分隔
            let btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            //将所有的td按顺序添加到一个tr中，最终添加到table中
            $("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(emailTd).append(genderTd).append(deptNameTd).append(btnTd).appendTo("#emps_table tbody");
        })
    }


    //构建分页信息
    function build_page_info(result) {
        //首先将分页信息清空
        $("#page_info_area").empty();
        $("#page_info_area").append("当前第" + result.extend.pageinfo.pageNum + "页,总共" + result.extend.pageinfo.pages + "页，总记录数" + result.extend.pageinfo.total + "条");
        //给totalRecord赋值为总记录数
        totalRecord = result.extend.pageinfo.total;
        //给currentPage赋值为当前页的页码
        currentPage = result.extend.pageinfo.pageNum;
    }

    // 构建分页栏
    function build_page_nav(result) {
        // 首先清空分页栏
        $("#page_nav_area").empty();
        //创建一个ul标签，并为他添加class属性为pagination
        let ul = $("<ul></ul>").addClass("pagination");
        //创建一个li标签，并在里面添加一个a标签，文字为首页，设置a标签的href属性为#防止跳转（首页跳转）
        let firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        //创建一个li标签，并在里面添加一个a标签，（上一页）
        let prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));


        if (result.extend.pageinfo.hasPreviousPage == false) {
            //如果没有上一页就禁用上一页和首页
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            //如果有，就跳转
            firstPageLi.click(function () {
                to_page(1);
            });

            prePageLi.click(function () {
                to_page(result.extend.pageinfo.pageNum - 1);
            });
        }
        //将首页和上一页添加到ul中（按顺序）
        ul.append(firstPageLi).append(prePageLi);
        //从返回的json字符串中得到分页栏需要显示的分页页码
        let nums = result.extend.pageinfo.navigatepageNums;
        $.each(nums, function (index, item) {
            let jQuery = $("<li></li>").append($("<a></a>").append(item));
            //如果页码为当前页就添加active属性，表示激活状态
            if (item == result.extend.pageinfo.pageNum) {
                jQuery.addClass("active");
            }
            //给按钮添加点击事件，点击就跳转
            jQuery.click(function () {
                to_page(item);
            });
            //添加到ul中
            ul.append(jQuery);
        });

        //创建一个li标签，并在里面添加一个a标签，（下一页）
        let nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        //创建一个li标签，并在里面添加一个a标签，文字为末页，设置a标签的href属性为#防止跳转（末页跳转）
        let lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));


        if (result.extend.pageinfo.hasNextPage == false) {
            // 如果没有下一页就禁用下一页和末页
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            //如果有就跳转
            nextPageLi.click(function () {
                to_page(result.extend.pageinfo.pageNum + 1);
            });

            lastPageLi.click(function () {
                to_page(result.extend.pageinfo.pages);
            });
        }
        // 将下一页和末页添加到ul中
        ul.append(nextPageLi).append(lastPageLi);
        let navEle = $("<nav></nav>").append(ul);
        //将数据添加到分页栏中显示
        navEle.appendTo("#page_nav_area");
    }

    // 清空表单中的信息
    function reset_form(element) {
        //清空表单的输入框中的内容
        $(element)[0].reset();
        //将表单中的标签含有has-error has-success属性的属性移除
        $(element).find("*").removeClass("has-error has-success");
        //将验证信息的span中的内容设置为空
        $(element).find(".help-block").text("");

    }

    // 为添加按钮添加点击事件
    $("#emp_modal_add_btn").click(function () {
        // $("#empAddModal form")[0].reset();
        //清空内容
        reset_form("#empAddModal form");
        //得到部门信息
        getDepts("#empAddModal select");
        $("#empAddModal").modal({
            backdrop:"static"
        });
    });


    // 得到部门信息
    function getDepts(element) {
        // 首先将部门信息的下拉框清空
        $(element).empty();
        // 发送ajax请求
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success:function (result) {
                //遍历数据，并显示到部门信息的下拉框中
                $.each(result.extend.depts, function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo(element);
                });

            }

        })
    }

    //前端校验，校验email和empName
    function validate_add_form() {
        let empName = $("#empName_add_input").val();
        let regName = /(^[A-Za-z0-9]{6,16}$)|(^[\u4e00-\u9fa5]{2,5}$)/;
        if (!regName.test(empName)) {
            show_validate_msg("#empName_add_input","error","用户名可以是2-5位中文，或者6-16位英文");

            // alert("用户名可以是2-5位中文，或者6-16位英文");
            return false;
        } else {
            show_validate_msg("#empName_add_input","success","")
            $("#empName_add_input").parent().addClass("has-success");
            $("#empName_add_input").next("span").text("");
        }

        let email = $("#email_add_input").val();
        let regEmail = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
        if (!regEmail.test(email)) {
            show_validate_msg("#email_add_input", "error", "邮箱格式出错");

            // alert("邮箱格式出错");
            return false;
        } else {
            show_validate_msg("#email_add_input", "success", "");
        }
        return true;
    }

    // 检验信息并显示
    function show_validate_msg(element, status, msg) {
        // 首先清楚has-success和has-error的class属性，防止叠加
        $(element).parent().removeClass("has-success has-error");
        //将提示信息框清空
        $(element).next("span").text("");
        if (status == "success") {
            $(element).parent().addClass("has-success");
            $(element).next("span").text("");
        } else {
            $(element).parent().addClass("has-error");
            $(element).next("span").text(msg);
        }
    }


    //对empName的输入框添加change事件，发送ajax进行后端校验
    $("#empName_add_input").change(function () {
        let empName = this.value;
        $.ajax({
            url: "${APP_PATH}/checkuser",
            data: "empName=" + empName,
            type: "POST",
            success: function (result) {
                if (result.code == 100) {
                    show_validate_msg("#empName_add_input", "success", "用户名可用");
                    $("#emp_save_btn").attr("ajax-va", "success");
                } else {
                    show_validate_msg("#empName_add_input", "error", result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va", "error");
                }
            }
        });
    });
    // 为保存按钮添加点击事件
    $("#emp_save_btn").click(function () {
        //1.前端校验
        if (!validate_add_form()) {
            return false;
        }
        //2.后端校验
        if ($(this).attr("ajax-va") == "error") {
            return false;
        }
        // 3.发送ajax请求进行保存
        $.ajax({
            url: "${APP_PATH}/emp",
            type: "POST",
            data: $("#empAddModal form").serialize(),
            success: function (result) {
                // 如果添加成功就关闭模态框，跳转到最后一页
                if (result.code == 100) {
                    $("#empAddModal").modal('hide');

                    to_page(totalRecord);
                } else {
                    // 如果失败就显示相应的错误信息
                    if (result.extend.errorFields.email != undefined) {
                        show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
                    }
                    if (result.extend.errorFields.empName != undefined) {
                        show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName);
                    }
                }

            }
        });
    });

    // 为有class属性edit_btn添加点击事件
    $(document).on("click", ".edit_btn", function () {
        //得到部门信息
        getDepts("#empUpdateModal select");
        //得到员工信息
        getEmp($(this).attr("edit-id"));
        // 为更新按钮添加自定义属性edit-id为当前数据的id
        $("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));
        $("#empUpdateModal").modal({
            backdrop: "static"
        });

    });

    //根据id获得员工信息，发送ajax请求
    function getEmp(id) {
        $.ajax({
            url: "${APP_PATH}/emp/" + id,
            type: "GET",
            success: function (result) {
                // console.log(result.extend.emp.empName);
                let empData = result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                $("#empUpdateModal select").val([empData.dId]);

            }
        });

    }

    //为更新按钮添加点击事件
    $("#emp_update_btn").click(function () {
        // 获得email的值进行验证
        let email = $("#email_update_input").val();
        let regEmail = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
        if (!regEmail.test(email)) {
            show_validate_msg("#email_update_input", "error", "邮箱格式出错");
            return false;
        } else {
            show_validate_msg("#email_update_input", "success", "");
        }
        //发送ajax请求
        $.ajax({
            url: "${APP_PATH}/emp/" + $(this).attr("edit-id"),
            type: "PUT",//还可以使用POST,在下面的data中添加"&_method=PUT"
            data: $("#empUpdateModal form").serialize(),
            success: function (result) {
                //如果成功了就关闭模态框，跳到当前页面
                $("#empUpdateModal").modal("hide");
                to_page(currentPage);
                // alert(result.msg);

            }
        });


    });

    // 为所有有delete_btn的class属性的按钮添加点击事件
    $(document).on("click", ".delete_btn", function () {
        //得到员工姓名
        let empName = $(this).parents("tr").find("td:eq(2)").text();
        //弹出确认框
        if (confirm("确认删除[" + empName + "]吗?")) {
            // 发送ajax请求进行删除
            $.ajax({
                url:"${APP_PATH}/emp/"+$(this).attr("delete-id"),
                type: "DELETE",
                success: function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }
            })
        }
    });

    // 为全选按钮添加点击事件
    $("#check_all").click(function () {
        // alert($(this).prop("checked"));
        //将所有有check_item class属性的单选框全部设置和全选按钮一样的状态
        $(".check_item").prop("checked", $(this).prop("checked"));
    })

    // 为所有check_item添加点击事件
    $(document).on("click", ".check_item", function () {
        // alert($(".check_item").length);
        //如果将所有的单选框都勾选起来了，全选框也要是选中的状态
        let flag = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked", flag);

    });

    //为删除按钮添加点击事件，进行批量删除
    $("#emp_delete_all_btn").click(function () {
        let empNames = "";
        let del_idstr = "";
        $.each($(".check_item:checked"), function () {
            empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
            del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-";
        });
        // 将删除的员工的empId用-进行连接
        // 将删除的员工的empName用，进行连接
        empNames = empNames.substring(0, empNames.length - 1);
        del_idstr = del_idstr.substring(0, empNames.length - 1);
        // 弹出确认框
        if (confirm("确认删除[" + empNames + "]吗?")) {
            //发送ajax请求进行删除
            $.ajax({
                url: "${APP_PATH}/emp/"+del_idstr,
                type: "DELETE",
                success: function (result) {
                    // 删除成功跳转到当前页面
                    alert(result.msg);
                    to_page(currentPage);

                }
            })
        }
    })
</script>
</body>
</html>

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

<!--员工修改的模态框-->
<!-- Modal -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@gmail.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="1" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="0"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <!--部门提交部门id即可-->

                            <select class="form-control" name="dId" id="dept_update_select">

                            </select>

                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>



<!--员工添加的模态框-->
<!-- Modal -->
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
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@gmail.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="1" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="0"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <!--部门提交部门id即可-->

                            <select class="form-control" name="dId" id="dept_add_select">

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
        <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
        <button class="btn btn-danger">删除</button>
    </div>
    <!--表格-->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th class="col-md-2">#</th>
                        <th class="col-md-2">empName</th>
                        <th class="col-md-2">gender</th>
                        <th class="col-md-2">email</th>
                        <th class="col-md-2">departName</th>
                        <th class="col-md-4">操作</th>
                    </tr>
                </thead>

                <tbody>

                </tbody>

            </table>
        </div>
    </div>
    <!--显示分页信息-->
    <div class="row">
        <!--分页文字信息-->
        <div class="col-md-6" id="page_info_area">

        </div>
        <!--分页条信息-->
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>

<script type="text/javascript">
    var totalRecord;
    //1.页面加载完成以后，直接去发送一个ajax请求，要到分页数据
    $(function () {
        //去首页
        to_page(1);
    });

    function to_page(pn) {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn="+pn,
            type:"GET",
            success:function (result) {
                // console.log(result);
                //1.解析并显示员工数据
                build_emps_table(result);
                //2.解析并显示分页信息
                build_page_info(result);
                //3.解析并显示分页条
                build_page_nav(result);
            }
        });
    }

    function build_emps_table(result) {
        //清空table表格
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps,function (index,item) {
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender=='1'?"男":"女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            /**
             *  <button class="btn btn-primary btn-sm">
                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                编辑</button>
             * @type {*|jQuery}
             */
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append("<span></span>")
                .addClass("glyphicon glyphicon-pencil")
                .append("编辑")
            editBtn.attr("edit_id",item.empId);

            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append("<span></span>")
                .addClass("glyphicon glyphicon-trash")
                .append("删除")
            delBtn.attr("delete_id",item.empId);

            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            //append方法执行完成后还是返回原来的元素，所以能接着添加
            $("<tr></tr>").append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        })
    }
    //解析显示分页信息
    function build_page_info(result) {
        //清空分页信息
        $("#page_info_area").empty();
        $("#page_info_area").append("当前"+
            result.extend.pageInfo.pageNum+"页,共"+
            result.extend.pageInfo.pages+"页,共"+
            result.extend.pageInfo.total+"条记录");
        totalRecord = result.extend.pageInfo.total;
    }
    //解析显示分页条
    function build_page_nav(result) {
        //清空分页条信息
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination")
        //构建元素
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (result.extend.pageInfo.hasPreviousPage == false){
            prePageLi.addClass("disabled");
            firstPageLi.addClass("disabled")
        }else {
            //为元素绑定翻页事件
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            });
        }

        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href","#"));
        if (result.extend.pageInfo.hasNextPage == false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled")
        }else {
            //为元素绑定翻页事件
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            });
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
        }

        ul.append(firstPageLi).append(prePageLi);
        $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item){
                // numLi = $($("<li></li>").addClass("active")).append($("<a></a>").append(item));
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        })
        ul.append(nextPageLi).append(lastPageLi);

        var navEle = $("<nav></nav>").append(ul);
        //page_nav_area
        navEle.appendTo("#page_nav_area");
    }

    //清空表单样式及内容
    function reset_form(ele) {
        $(ele)[0].reset();
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }

    //点击新增按钮弹出模态框
    $("#emp_add_modal_btn").click(function () {
        //清除表单数据（表单完整重置（表单数据重置，表单样式重置））
        reset_form("#empAddModal form");
        // $("#empAddModal form")[0].reset();
        //发送ajax请求，查出部门信息，显示在下拉列表中
        getDepts("#empAddModal select");
        //弹出模态框
        $("#empAddModal").modal({
            backdrop:"static",
        });
    });
    //查出所有的部门信息并显示在下拉列表
    function getDepts(ele) {
        //清空之前下拉列表里的信息
        $(ele).empty();
        $.ajax({
            url: "${APP_PATH}/depts",
            type:"GET",
            success:function (result) {
                // console.log(result);
                //显示部门信息在下拉列表中
                // $("#empAddModal select").append("");
                $.each(result.extend.depts,function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                    optionEle.appendTo(ele);
                });
            }
        });
    }

    //校验表单数据empName,email,gender,dept
    function validate_add_form() {
        //1.拿到要校验的数据，使用正则表达式
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9EEE]{2,5}$)/;
        if (!regName.test(empName)){
            // alert("用户名为2-5位中文或者6-16位英文字母和数字混合");
            //清空这个元素之前的样式
            show_validate_msg("#empName_add_input","error","用户名为2-5位中文或者6-16位英文字母和数字混合")
            return false;
        }else {
            show_validate_msg("#empName_add_input","success","有效")
        }

        //2.校验邮箱信息
        var email = $("#email_add_input").val();
        var regEmail = /^([a-zA-Z0-9_-]+)@([a-zA-Z0-9_-]+)\.([a-zA-Z0-9_-]+)$/;
        if (!regEmail.test(email)){
            // alert("请填写正确的邮箱地址");
            // $("#email_add_input").parent().addClass("has-error");
            // $("#email_add_input").next("span").text("请填写正确的邮箱地址");
            show_validate_msg("#email_add_input","error","请填写正确的邮箱地址");
            return false;
        } else {
            // $("#email_add_input").parent().addClass("has-success");
            // $("#email_add_input").next("span").text("有效");
            show_validate_msg("#email_add_input","success","有效");
        }
        return true;

    }

    function show_validate_msg(ele,status,msg){
        //清楚当前元素的校验状态
        $(ele).parent().removeClass("has-error has-success");
        $(ele).next("span").text("");
        if ("success" == status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" == status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    //校验用户名是否可用
    $("#empName_add_input").change(function () {
        //当输入框发生变化时，发送ajax请求校验用户名是否可用
        var empName = $(this).val();
        $.ajax({
            url:"${APP_PATH}/checkUser",
            data:"empName="+empName,
            type:"POST",
            success:function (result) {
                if (result.code == 100){
                    show_validate_msg("#empName_add_input","success","用户名可用");
                    $("#emp_save_btn").attr("ajax-va","success");
                }else {
                    show_validate_msg("#empName_add_input","error",result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va","error");
                }
            }
        });
    });

    //为新增员工的保存按钮绑定单击事件
    $("#emp_save_btn").click(function () {
        //模态框中填写的表单数据提交给服务器进行保存
        //先要数据校验
        if (!validate_add_form()){
            return false;
        }
        //1.判断之前的ajax用户名校验是否成功.不成功则不向下执行
        if($(this).attr("ajax-va") == "error") {
            return false;
        }
        //2.发送ajax请求保存员工
        $.ajax({
            url:"${APP_PATH}/emp",
            type:"POST",
            data:$("#empAddModal form").serialize(),
            success:function (result) {
                // alert(result.msg);
                if (result.code = 100) {
                    //员工保存成功：
                    // 1.关闭模态框，
                    $("#empAddModal").modal("hide");
                    // 2.显示刚保存的数据
                    //发送ajax请求，发送最有一页数据
                    to_page(totalRecord);
                } else {
                    //显示失败信息
                    //有哪个字段的错误信息就显示哪个字段的
                    if(undefined != result.extend.errorFields.email) {
                        //显示邮箱错误信息
                        show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
                    }
                    if(undefined != result.extend.errorFields.empName) {
                        //显示用户名错误信息
                        show_validate_msg("#empName", "error", result.extend.errorFields.empName);
                    }
                }
            }
        });
    });

    //我们页面的数据是在页面加载发送ajax请求时加载的，包括编辑和删除按钮
    //所以页面静止时，相当于按钮还没加载，自然无法直接通过 .edit_btn 绑定事件
    //方法：1。在创建按钮的时候绑定事件，但是创建按钮部分的代码已经很多，再加上这个功能，代码冗余比较明显了
    //     2。绑定点击 .live() ，这个功能是：即使是以后添加的元素，也有效，但是新版jquery没有live
    //     3。使用 on 替代 live
    $(document).on("click",".edit_btn",function (){
        //1.查出员工信息
        getEmp($(this).attr("edit_id"));
        //2.查出部门信息，并显示部门列表
        getDepts("#empUpdateModal select")

        $("#empUpdateModal").modal({
           backdrop: "static"
        });
    });

    function getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"GET",
            success:function (result) {
                // console.log(result)
                var empData = result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                $("#empUpdateModal select").val([empData.dId]);
            }
        });
    }

</script>
</body>
</html>

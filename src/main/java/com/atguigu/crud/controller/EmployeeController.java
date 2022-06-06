package com.atguigu.crud.controller;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.hibernate.validator.constraints.Email;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;

/**
 * @author 孙佳奇
 * 处理员工crud操作
 * 导入jakson包
 * @version 1.0
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /**
     * 查询员工信息
     */
    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id) {
        Employee employee = employeeService.getEmp(id);
        return  Msg.success().add("emp", employee);
    }

    /**
     * 校验员工姓名是否可用
     */
     @RequestMapping(value = "/checkUser",method = RequestMethod.POST)
    @ResponseBody
    public Msg checkUser(@RequestParam("empName") String empName) {
        //判断用户名是是否合法
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9EEE]{2,5}$)";
        if(!empName.matches(regx)) {
            return  Msg.fail().add("va_msg", "用户名为2-5位中文或者6-16位英文字母和数字混合");
        }
        //用户名重复校验
        boolean res = employeeService.checkUser(empName);
        if (res) {
            return Msg.success();
        } else {
            return Msg.fail().add("va_msg", "用户名不可用");
        }
    }

    /**
     * 新增员工并保存
     * 1。支持JSR303校验
     * 2。导入Hibernate-Validator
     * @return
     */

    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()) {
            //校验失败,在模态框中返回后端校验失败的信息
            HashMap<String, Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError  fieldError : errors) {
                System.out.println("错误的字段名: " + fieldError.getField());
                System.out.println("错误信息" + fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        } else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }

    }

    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 5);
        List<Employee> emps = employeeService.getAll();
        //使用pageInfo包装查询后的结果,只需要将pageInfo交给页面就行了
        // 封装了详细的分页信息，包括查询出来的数据
        PageInfo page = new PageInfo(emps, 5);
        return Msg.success().add("pageInfo", page);
    }


    /**
     * 查询员工数据（分页查询）
     * @return
     */
    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
        //引入PageHelper分页插件
        PageHelper.startPage(pn, 5);
        List<Employee> emps = employeeService.getAll();
        //使用pageInfo包装查询后的结果,只需要将pageInfo交给页面就行了
        // 封装了详细的分页信息，包括查询出来的数据
        PageInfo page = new PageInfo(emps, 5);
        model.addAttribute("pageInfo", page);
        return "list";
    }
}

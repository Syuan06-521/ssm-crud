package com.atguigu.crud.service;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.EmployeeExample;
import com.atguigu.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author 孙佳奇
 * @version 1.0
 */
@Service
public class EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;
    public List<Employee> getAll() {
        List<Employee> employees = employeeMapper.selectByExampleWithDept(null);
        return employees;
    }

    /**
     * 员工保存方法
     */
    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    /**
     * 检查用户名是否存在
     * count == 0，返回 true，否则返回 false。
     */
    public boolean checkUser(String empName) {
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(employeeExample);
        return count == 0;
    }

    /**
     * 按照员工id查询员工信息
     */
    public Employee getEmp(Integer id) {
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }
}

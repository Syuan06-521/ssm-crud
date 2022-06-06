package com.atguigu.crud.test;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.EmployeeExample;
import com.atguigu.crud.dao.DepartmentMapper;
import com.atguigu.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * @author 孙佳奇
 * 测试dao层的工作
 * 推荐使用spring的单元测试，可以自动注入我们需要的组件
 * 1.导入springTest
 * 2.使用@ContextConfiguration 指定spring配置文件的位置
 * 3.@RunWith(SpringJUnit4ClassRunner.class)
 * 4.直接autowire要使用的组件
 * @version 1.0
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;
    /**
     * 测试DepartmentMapper
     */
    @Test
    public void testCRUD() {
//        //1.创建SpringIOC容器
//        ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
//        //2.从容器中获取mapper
//        DepartmentMapper departmentMapper = ioc.getBean(DepartmentMapper.class);
        System.out.println(departmentMapper);
//        //1.插入部门
//        int i = departmentMapper.insertSelective(new Department(null, "开发部"));
//        int i1 = departmentMapper.insertSelective(new Department(null, "测试部"));
//        //2.插入员工
//        employeeMapper.insertSelective(new Employee(null, "孙佳奇", "1", "1085059522@qq.com", 1));
        //3.批量插入多个员工
//        EmployeeExample employee1 = new EmployeeExample(null, "周小兔", "0", "2242375232@qq.com", 2);
//        EmployeeExample employee2 = new EmployeeExample(null, "申奇", "1", "2216232@qq.com", 1);
//        EmployeeExample employee3 = new EmployeeExample(null, "王千策", "1", "28510759@qq.com", 2);
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 1000; i++){
            String uid = UUID.randomUUID().toString().substring(0, 5)+i;
            employeeMapper.insertSelective(new Employee(null, uid, "1", uid+"@atguigu.com", 1));
        }
        System.out.println("批量完成");

    }
}

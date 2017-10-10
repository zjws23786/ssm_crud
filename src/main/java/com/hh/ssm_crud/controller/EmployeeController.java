package com.hh.ssm_crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hh.ssm_crud.bean.TblEmp;
import com.hh.ssm_crud.bean.base.BaseObj;
import com.hh.ssm_crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    //跳页形式（只支持网页版，不支持移动客户端）
    @RequestMapping("/emps_model")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn,
                          Model model){
        //这里分页使用第三方插件
        //第三方分页插件PageHelper
        PageHelper.startPage(pn,5); //传入的是页码和每页的大小
        //startPage后面紧跟的是这个查询就是一个分页的查询了
        List<TblEmp> emps = employeeService.getAll();
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了
        //封装了详细的分页信息，包括我们查询出来的数据，传入连续显示的页数
        PageInfo pageInfo = new PageInfo(emps,5);
        model.addAttribute("pageInfo", pageInfo);
        return "list";
    }

    /**
     * 导入jackson包。
     * @param pn
     * @return   返回json格式数据，网页、移动客户端都支持
     */
    @RequestMapping("/emps")
    @ResponseBody
    public BaseObj getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn){
        PageHelper.startPage(pn,5); //传入的是页码和每页的大小
        List<TblEmp> emps = employeeService.getAll();
        PageInfo page = new PageInfo(emps, 5);
        return BaseObj.success().addDataObject(page);
    }

    /**
     * 新增员工保存
     * 1、前后台双重校验，确保数据的准确性
     *      1.1、使用spring自带的JSR303校验
     *      1.2、需要结合Hibernate-Validator
     * @return
     */
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public BaseObj saveEmp(@Valid TblEmp employee, BindingResult result){
        if (result.hasErrors()){
            //校验失败，应该返回失败，在模态框中显示校验失败的错误信息
            Map<String,Object> map = new HashMap<String,Object>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError : errors){
                System.out.println("错误的字段名："+fieldError.getField());
                System.out.println("错误信息："+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return BaseObj.fail(1,"校验失败").addDataObject(map);
        }else{

            boolean b = employeeService.checkUser(employee.getEmpName());
            if(b){
                employeeService.save(employee);
                return BaseObj.success();
            }else{
                Map<String,Object> map = new HashMap<String ,Object>();
                map.put("empName","用户名已存在");
                return BaseObj.fail(2,"用户名已存在").addDataObject(map);
            }

        }
    }

    /**
     * 检查用户名的唯一性
     * @return
     */
    @RequestMapping("/checkuser")
    @ResponseBody
    public BaseObj checkUser(@RequestParam("empName")String empName){
        //先判断用户名是否是合法的表达式;
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
        if(!empName.matches(regx)){
            return BaseObj.fail(1,"不符合规则").addDataObject("用户名必须是6-16位数字和字母的组合或者2-5位中文");
        }
        //数据库用户名重复校验
        boolean b = employeeService.checkUser(empName);
        if(b){
            return BaseObj.success();
        }else{
            return BaseObj.fail(2,"用户名已存在").addDataObject("用户名已存在");
        }

    }
}

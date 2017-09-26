package com.hh.ssm_crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hh.ssm_crud.bean.TblEmp;
import com.hh.ssm_crud.bean.base.BaseObj;
import com.hh.ssm_crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

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

    //跳页形式（只支持网页版，不支持移动客户端）
//    @RequestMapping("/emps")
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
}

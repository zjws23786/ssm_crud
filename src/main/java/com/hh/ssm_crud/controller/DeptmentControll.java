package com.hh.ssm_crud.controller;

import com.hh.ssm_crud.bean.TblDept;
import com.hh.ssm_crud.bean.base.BaseObj;
import com.hh.ssm_crud.service.DeptmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * Created by hjz on 2017/9/29 0029.
 * Describe：部门
 */
@Controller
public class DeptmentControll {

    @Autowired
    public DeptmentService deptmentService;

    @RequestMapping("/depts")
    @ResponseBody
    public BaseObj getAllDept(){
        List<TblDept> deptList = deptmentService.getAllDept();
        return BaseObj.success().addDataObject(deptList);
    }
}

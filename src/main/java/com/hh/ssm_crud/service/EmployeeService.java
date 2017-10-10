package com.hh.ssm_crud.service;

import com.hh.ssm_crud.bean.TblEmp;
import com.hh.ssm_crud.dao.TblEmpMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {

    @Autowired
    TblEmpMapper tblEmpMapper;

    public List<TblEmp> getAll() {
        return tblEmpMapper.selectByExampleWithDept(null);
    }

    public void save(TblEmp employee) {
        tblEmpMapper.insertSelective(employee);
    }
}
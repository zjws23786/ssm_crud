package com.hh.ssm_crud.service;

import com.hh.ssm_crud.bean.TblEmp;
import com.hh.ssm_crud.bean.TblEmpExample;
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


    /**
     * 检验用户名是否可用
     *
     * @param empName
     * @return  true：代表当前姓名可用   fasle：不可用
     */
    public boolean checkUser(String empName) {
        TblEmpExample example = new TblEmpExample();
        TblEmpExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = tblEmpMapper.countByExample(example);
        return count == 0;
    }
}
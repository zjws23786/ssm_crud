package com.hh.ssm_crud.service;

import com.hh.ssm_crud.bean.TblDept;
import com.hh.ssm_crud.dao.TblDeptMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by hjz on 2017/9/29 0029.
 * Describe：
 */
@Service
public class DeptmentService {

    @Autowired
    public TblDeptMapper tblDeptMapper;

    public List<TblDept> getAllDept() {
        return tblDeptMapper.selectByExample(null);
    }
}

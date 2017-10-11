package com.hh.ssm_crud.dao;

import com.hh.ssm_crud.bean.TblEmp;
import com.hh.ssm_crud.bean.TblEmpExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TblEmpMapper {
    long countByExample(TblEmpExample example);

    int deleteByExample(TblEmpExample example);

    int insert(TblEmp record);

    int insertSelective(TblEmp record);

    List<TblEmp> selectByExample(TblEmpExample example);

    List<TblEmp> selectByExampleWithDept(TblEmpExample example);

    TblEmp selectByPrimaryKeyWithDept(Integer empId);

    int updateByExampleSelective(@Param("record") TblEmp record, @Param("example") TblEmpExample example);

    int updateByExample(@Param("record") TblEmp record, @Param("example") TblEmpExample example);

    TblEmp selectByPrimaryKey(Integer empId);

    void updateByPrimaryKeySelective(TblEmp employee);
}
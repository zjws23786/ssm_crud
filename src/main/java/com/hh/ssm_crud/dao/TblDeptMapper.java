package com.hh.ssm_crud.dao;

import com.hh.ssm_crud.bean.TblDept;
import com.hh.ssm_crud.bean.TblDeptExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TblDeptMapper {
    long countByExample(TblDeptExample example);

    int deleteByExample(TblDeptExample example);

    int insert(TblDept record);

    int insertSelective(TblDept record);

    List<TblDept> selectByExample(TblDeptExample example);

    int updateByExampleSelective(@Param("record") TblDept record, @Param("example") TblDeptExample example);

    int updateByExample(@Param("record") TblDept record, @Param("example") TblDeptExample example);
}
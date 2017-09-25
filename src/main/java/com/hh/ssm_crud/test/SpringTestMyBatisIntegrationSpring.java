package com.hh.ssm_crud.test;

import com.hh.ssm_crud.bean.TblDept;
import com.hh.ssm_crud.bean.TblEmp;
import com.hh.ssm_crud.dao.TblDeptMapper;
import com.hh.ssm_crud.dao.TblEmpMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;
import java.util.Random;
import java.util.UUID;

/**
 * Created by hjz on 2017/9/25 0025.
 * Describe：spring和mybatis整合
 * 推荐Spring项目就用Spring的单元测试，可以自动注入我们需要的组件，配置的步骤
 * 1、导入SpringTest模块  spring-test
 * 2、@ContextConfiguration指定Spring配置文件的位置
 * 3、直接autowired（自动注入）要使用的组件即可
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class SpringTestMyBatisIntegrationSpring {

    @Autowired
    TblDeptMapper tblDeptMapper;

    @Autowired
    SqlSession sqlSession;

    @Test
    public void insertDept(){
        TblDept tblDept = new  TblDept();
        tblDept.setDeptName("策划部");
        tblDeptMapper.insert(tblDept);
    }

    @Test
    public void insetEmp(){
        TblEmpMapper bean = sqlSession.getMapper(TblEmpMapper.class);
        List<TblDept> deptList = tblDeptMapper.selectByExample(null);
        int[] deptId = new int[deptList.size()];
        for (int i=0; i<deptList.size(); i++){
            deptId[i] = deptList.get(i).getDeptId();
        }
        String[] sexStr = {"W","M"}; //女、男
//        for (int i=0; i<10; i++){
//            System.out.println("性别："+sexStr[(int)(Math.random()*sexStr.length)]);
//            System.out.println("部门id："+deptId[(int)(Math.random()*deptId.length)]);
//        }
        for(int i = 0;i<1000;i++){
            String uid = UUID.randomUUID().toString().substring(0,5)+i;
            bean.insertSelective(new TblEmp(null,uid, sexStr[(int)(Math.random()*sexStr.length)], uid+"@hh.com", deptId[(int)(Math.random()*deptId.length)]));
        }
        System.out.println("批量完成");
    }

}

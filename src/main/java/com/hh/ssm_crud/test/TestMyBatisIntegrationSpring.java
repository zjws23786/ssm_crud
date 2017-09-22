package com.hh.ssm_crud.test;

import com.hh.ssm_crud.bean.TblDept;
import com.hh.ssm_crud.bean.TblEmp;
import com.hh.ssm_crud.dao.TblDeptMapper;
import com.hh.ssm_crud.dao.TblEmpMapper;
import org.apache.ibatis.jdbc.SQL;
import org.apache.ibatis.session.SqlSession;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import javax.annotation.Resource;
import java.util.Random;
import java.util.UUID;

/**
 * Created by hjz on 2017/9/21 0021.
 * Describe：Mybatis和spring整合
 */
public class TestMyBatisIntegrationSpring {
    //创建SpringIOC容器【ioc把对象的创建不是通过new方式实现，而是交给spring配置创建类对象】
    private ApplicationContext ioc = null;

    @Resource
    SqlSession sqlSession;

    @Before
    public void setUp(){
        ioc = new ClassPathXmlApplicationContext("applicationContext.xml");

    }

    @Test
    public void insertDept(){
//        TblDeptMapper bean = ioc.getBean(TblDeptMapper.class);
//        TblDept tblDept = new  TblDept();
//        tblDept.setDeptName("开发部");
//        bean.insert(tblDept);

        TblDeptMapper bean = ioc.getBean(TblDeptMapper.class);
        TblDept tblDept = new  TblDept();
        tblDept.setDeptName("QA");
        bean.insert(tblDept);
    }

    @Test
    public void insetEmp(){
        sqlSession = (SqlSession) ioc.getBean("sqlSession");
        TblEmpMapper bean = sqlSession.getMapper(TblEmpMapper.class);
        Random rand = new Random();
        int[] randonInt = {1,2};
        String[] sexStr = {"M","M"}; //女、男
        for(int i = 0;i<1000;i++){
            String uid = UUID.randomUUID().toString().substring(0,5)+i;
            bean.insertSelective(new TblEmp(null,uid, sexStr[rand.nextInt(sexStr.length)], uid+"@atguigu.com", 1));
        }
        sqlSession.close();
        System.out.println("批量完成");
    }
}

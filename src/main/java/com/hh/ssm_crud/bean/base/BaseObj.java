package com.hh.ssm_crud.bean.base;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by hjz on 2017/9/26 0026.
 * Describe：封装json基类
 */
public class BaseObj {
    private int rCode;  //返回0代表成功，非0异常
    private String rInfo; //提示语

    private Object data; //返回数据集

    public BaseObj addDataObject(Object value){
        setData(value);
        return this;
    }

    public static BaseObj success(){
        BaseObj result = new BaseObj();
        result.setrCode(0);
        result.setrInfo("处理成功！");
        return result;
    }

    public static BaseObj fail(int code,String info){
        BaseObj result = new BaseObj();
        result.setrCode(code);
        result.setrInfo(info);
        return result;
    }

    public int getrCode() {
        return rCode;
    }

    public void setrCode(int rCode) {
        this.rCode = rCode;
    }

    public String getrInfo() {
        return rInfo;
    }

    public void setrInfo(String rInfo) {
        this.rInfo = rInfo;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}

package com.young.admin.controller;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public class BaseController {
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	

	//指定页面不缓存
    protected void setNocache(HttpServletResponse response){
        response.setDateHeader("Expires", -1);//IE
        response.setHeader("Cache-Control", "no-cache");
        response.setHeader("Pragma", "no-cache");
    }
 
	protected void logRequestParameter(String title, HttpServletRequest request) {
        Map<String, String[]> requestParams = request.getParameterMap();
        StringBuilder sb = new StringBuilder(title);
        sb.append("\r\n");
        for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext(); ) {
            String name = (String) iter.next();
            String[] values = (String[]) requestParams.get(name);
            String valueStr = "";
            for (int i = 0; i < values.length; i++) {
                valueStr = (i == values.length - 1) ? valueStr + values[i] : valueStr + values[i] + ",";
            }
            sb.append(name).append("=").append(valueStr).append("\r\n");
        }
        logger.info(sb.toString());
    }
	
}

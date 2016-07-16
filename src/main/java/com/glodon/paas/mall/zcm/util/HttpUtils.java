package com.glodon.paas.mall.zcm.util;

import java.io.Closeable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.StopWatch;
import org.apache.http.Header;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSON;

/**
 * 
 * @author hc
 *
 */
public class HttpUtils {

    private static final Logger   logger             = LoggerFactory.getLogger(HttpUtils.class);

    // 客户端IP查找顺序
    private static final String[] HTTP_IP_HEADER     = { "x-forwarded-for", "Proxy-Client-IP" };
    private static final String   FORM_ENTITY_ENCODE = "UTF-8";
    private static final String   APPLICATION_JSON = "application/json";
    

    public static class SimpleResult {
        private int			status;    //0表示有异常
        private String 		body;
        private Exception	exception;

        public SimpleResult(){
        }
        
        public SimpleResult(int status, String body){
        	this.status = status;
        	this.body = body;
        }
        public String getBody() {
            return body;
        }

        public void setBody(String body) {
            this.body = body;
        }

        public int getStatus() {
            return status;
        }

        public void setStatus(int status) {
            this.status = status;
        }

		public Exception getException() {
			return exception;
		}

		public void setException(Exception eception) {
			this.exception = eception;
		} 
    }

    /**
     * 通过HttpClient发送get请求，并返回response的文本内容和状态码status code
     * 
     * @param url
     * @param header
     * @return
     */
    public static SimpleResult doGet(String url, Header header) {
        StopWatch watch = new StopWatch();
        watch.start();
        logger.info("doPost() start, url: {}", url);
        CloseableHttpClient httpClient = HttpClients.createDefault();
        HttpGet method = new HttpGet(url);
        method.setConfig(RequestConfig.custom().setSocketTimeout(2000).setConnectTimeout(2000).build());

        // 准备：header
        method.addHeader(header);
        HttpResponse response = null;
        
        // 执行和返回
        SimpleResult result = new SimpleResult();
        try {
            response = httpClient.execute(method);
            result.setBody(EntityUtils.toString(response.getEntity()));
            result.setStatus(response.getStatusLine().getStatusCode());
        } catch (Exception e) {
            logger.error("http client error", e);
            result.setException(e);
        } finally {
        	close(httpClient);
        }

        // HttpClient请求结束
        watch.stop();
        logger.info("doGet() status:" + result.getStatus());
        logger.info("doGet() end, cost time: " + watch.getTime());
        return result;
    }

    public static SimpleResult doget(String url, Map<String, String> header) {
        StopWatch watch = new StopWatch();
        watch.start();
        logger.info("doPost() start, url: {}", url);
        CloseableHttpClient httpClient = HttpClients.createDefault();
        HttpPost method = new HttpPost(url);

        // 准备：header
        if(header != null && header.size() > 0){
        	for (String name:header.keySet()) {
        		method.addHeader(name, header.get(name));
			}
        }
        
        //执行和返回
        SimpleResult result = new SimpleResult();
        try {
        	HttpResponse response = httpClient.execute(method);
            result.setBody(EntityUtils.toString(response.getEntity()));
            result.setStatus(response.getStatusLine().getStatusCode());
        } catch (Exception e) {
            logger.error("http client error", e);
            result.setException(e);
        } finally {
        	close(httpClient);
        }
        watch.stop();
        logger.info("doPost() status:" + result.getStatus());
        logger.info("doPost() end, cost time: " + watch.getTime());
        return result;
    }

    /**
     * 通过HttpClient发送post请求，并返回response的文本内容
     * 
     * @param url
     * @param params
     * @return
     */
    public static SimpleResult doPost(String url, Map<String, String> params, Map<String, String> header) {
        StopWatch watch = new StopWatch();
        watch.start();
        logger.info("doPost() start, url: {}", url);
        CloseableHttpClient httpClient = HttpClients.createDefault();
        HttpPost method = new HttpPost(url);

        // 准备：header
        if(header!=null && header.size()>0){
        	for (String name:header.keySet()) {
        		method.addHeader(name, header.get(name));
			}
        }
        
        // 准备：params
        if (params != null && params.size() > 0) {
            try { 
                List<NameValuePair> formParams = new ArrayList<NameValuePair>();
                for (Map.Entry<String, String> e : params.entrySet()) {
                    formParams.add(new BasicNameValuePair(e.getKey(), e.getValue()));
                }
                UrlEncodedFormEntity entity = new UrlEncodedFormEntity(formParams, FORM_ENTITY_ENCODE);
    			method.setEntity(entity);
    		} catch (Exception e) {
    			logger.error(e.getMessage(), e);
    		}
        }
        
        //执行和返回
        SimpleResult result = new SimpleResult();
        try {
        	HttpResponse response = httpClient.execute(method);
            result.setBody(EntityUtils.toString(response.getEntity()));
            result.setStatus(response.getStatusLine().getStatusCode());
        } catch (Exception e) {
            logger.error("http client error", e);
            result.setException(e);
        } finally {
        	close(httpClient);
        }
        watch.stop();
        logger.info("doPost() status:" + result.getStatus());
        logger.info("doPost() end, cost time: " + watch.getTime());
        return result;
    }
    
    /**
     * post json字符串
     * 
     * @param url
     * @param jsonStr
     * @param header
     * @return
     */
    public static SimpleResult doPostJsonStr(String url, String jsonStr, Map<String, String> header) {
        StopWatch watch = new StopWatch();
        watch.start();
        logger.info("doPostJsonStr() start, url: {}", url);
        CloseableHttpClient httpClient = HttpClients.createDefault();
        HttpPost method = new HttpPost(url);

        // 准备：header
        header.put(HTTP.CONTENT_TYPE, APPLICATION_JSON);
        if(header!=null && header.size()>0){
        	for (String name:header.keySet()) {
        		method.addHeader(name, header.get(name));
			}
        }
         
        // 准备：params
        method.setEntity(new StringEntity(jsonStr,FORM_ENTITY_ENCODE));
        
        // 执行和返回
        SimpleResult result = new SimpleResult();
        try {
        	HttpResponse response = httpClient.execute(method);
            result.setBody(EntityUtils.toString(response.getEntity()));
            result.setStatus(response.getStatusLine().getStatusCode());
        } catch (Exception e) {
            logger.error("http client error", e);
            result.setException(e);
        } finally {
        	close(httpClient);
        }
        watch.stop();
        logger.info("doPostJsonStr() status:" + result.getStatus());
        logger.info("doPostJsonStr() end, cost time: " + watch.getTime());
        return result;
    }
 
    /**
     * 获取客户端IP
     * 
     * @param request
     * @return
     */
    public static String getClientIp(HttpServletRequest request) {
        if (null == request) {
            return null;
        }
        String ip = null;
        for (String key : HTTP_IP_HEADER) {
            ip = request.getHeader(key);
            if (StringUtils.isNotBlank(ip) && !"unknown".equalsIgnoreCase(ip)) {
                break;
            }
        }
        // default
        if (StringUtils.isBlank(ip) || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip == null ? "" : ip.split(",")[0];
    }
    

    public static Map<String, String> getCookies(HttpServletRequest request) {
    	Cookie[] cookies = request.getCookies();
    	Map<String,String> map = new HashMap<String,String>();
    	if(cookies == null || cookies.length == 0){
    		return map;
    	}
    	for(Cookie cookie : cookies){
    		map.put(cookie.getName(), cookie.getValue());
    	}
    	return map;
    }
    
    
    public static String getCookie(HttpServletRequest request, String name) {
    	if(name == null){
    		return null;
    	}
    	
    	Cookie[] cookies = request.getCookies();
    	if(cookies == null || cookies.length == 0){
    		return null;
    	}
    	
    	for(Cookie cookie : cookies){
    		if(name.equals(cookie.getName())){
    			return cookie.getValue();
    		}
    	}
    	return null;
    }

    /**
     * 获取referer
     * 
     * @param request
     * @return
     */
    public static String getHttpReferr(HttpServletRequest request) {
        return request.getHeader("referer");
    }
    
    
    private static void close(Closeable o){
    	try {
			o.close();
		} catch (Exception e) {
		}
    }
    public static void main(String[] args) {
    		String url = "https://yun.glodon.com/authorizing/test/updateUserId?appId="+8;
    		for (int i = 0; i < 10000; i++) {
    			String result = HttpUtils.doPost(url, null, null).body;
    			System.out.println(result);
    			com.alibaba.fastjson.JSONObject json = JSON.parseObject(result);
    			if(json.getIntValue("total") == 0){
    				break;
    			}
    		}
	}
}

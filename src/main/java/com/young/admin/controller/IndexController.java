package com.young.admin.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value = "/")
public class IndexController extends BaseController {
	private static Logger LOGGER = LoggerFactory.getLogger(IndexController.class);
	String INDEX_PAGE = "index";

    @RequestMapping(method = RequestMethod.GET)
    public String index(HttpServletRequest request, Model model) {
        return "index";
    }
    
	/**
	 * 需要登陆访问，用于登陆返回
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String indexNeedLogin(HttpServletRequest request) {
    	LOGGER.debug("/index");
        return INDEX_PAGE;
    }
}

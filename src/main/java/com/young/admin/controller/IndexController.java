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

    @RequestMapping(method = RequestMethod.GET)
    public String index(HttpServletRequest request, Model model) {
        return "index";
    }
    
    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String indexNeedLogin(HttpServletRequest request) {
        return "index";
    }
    
    @RequestMapping(value = "/order/place", method = RequestMethod.GET)
    public String orderPlace(HttpServletRequest request) {
        return "admin/placeOrder";
    }
    
    @RequestMapping(value = "/order/draft", method = RequestMethod.GET)
    public String orderDraft(HttpServletRequest request) {
    	LOGGER.debug("/index");
        return "admin/draftOrderList";
    }
    
    @RequestMapping(value = "/order/list", method = RequestMethod.GET)
    public String orderList(HttpServletRequest request) {
        return "admin/orderList";
    }
    
    @RequestMapping(value = "/authority", method = RequestMethod.GET)
    public String authority(HttpServletRequest request) {
        return "admin/authority";
    }
}

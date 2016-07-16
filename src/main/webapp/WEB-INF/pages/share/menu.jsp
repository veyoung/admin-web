<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul class="menu-content"> 
    <li>
        <h4 class="first menu">
            <i class="icon-product"></i>
            <span class="text"  style="font-size:14px;"> <i class="img-icon fa fa-cubes"></i><strong>代客下单</strong><i class="fa fa-chevron-down fa-arrow"></i></span>
        </h4>
        <ul class="navi first">
            <li class="dropdown" data-id="/order/place">
				<a href="/admin/order/place" class="stateful"><i class="fa fa-angle-double-right img-icon"></i>新建订单页</a>
			</li>
            <li class="dropdown" data-id="/order/draft">
                <a href="/admin/order/draft" class="stateful"><i class="fa fa-angle-double-right img-icon"></i>草稿箱</a>
            </li>
        </ul>
    </li>
    <li>
        <h4 class="second menu">
            <i class="icon-product"></i>
            <span class="text"  style="font-size:14px;"> <i class="img-icon fa fa-bar-chart"></i><strong>订单管理</strong><i class="fa fa-chevron-down fa-arrow"></i></span>
        </h4>
        <ul class="navi second">
            <li class="dropdown" data-id="/order/list">
				<a href="/admin/order/list" class="stateful"><i class="fa fa-angle-double-right img-icon"></i>订单列表页</a>
			</li>
        </ul>
    </li>
    
    <li>
        <h4 class="third menu">
            <i class="icon-product"></i>
            <span class="text"  style="font-size:14px;"> <i class="img-icon fa fa-file-text"></i><strong>权限管理</strong><i class="fa fa-chevron-down fa-arrow"></i></span>
        </h4>
        <ul class="navi third">
            <li class="dropdown" data-id="/authority">
				<a href="/admin/authority" class="stateful"><i class="fa fa-angle-double-right img-icon"></i>管理员权限</a>
			</li>
        </ul>
    </li>
</ul>


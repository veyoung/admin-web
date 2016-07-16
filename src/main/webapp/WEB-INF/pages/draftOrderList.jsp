<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="generateOrder-container" >
<h4 class="header"><b>代客下单-草稿箱</b></h4>
<div class="row">
    <div class="col-xs-12">
    	<form class="form-horizontal" id="draft-form">
            <input type="hidden" id="page" name="page"/>
            <input type="hidden" name="totalPages" value="${page.totalPages}">
        	<input type="hidden" name="currentPage" value="${page.number}">
        </form>
        <table class="table table-hover table-striped">
            <thead>
                <tr style="background-color:#5799da;color:white;">
                    <th class="col-1" width="6%">订单ID</th>
                    <th class="col-2" width=9%>订单日期</th>
                    <th class="col-3" width="6%">商品名称</th>
                    <th class="col-4" width="4%">成交金额</th>
                    <th class="col-5" width="8%">加密锁号/VIP账号</th>
                    <th class="col-6" width="10%">联系人/手机号</th>
                    <th class="col-7" width="12%">收货地址</th>
                    <th class="col-9" width="5%">业务员</th>
                    <th class="col-10" width="8%">操作</th>
                </tr>
            </thead>
            <tbody>
            	<c:forEach items="${page.content}" var="order">
	                <tr>
	                    <td>${order.id}</td>
	                    <td><fmt:formatDate value="${order.createTime}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
	                    <td>${order.firstProductName}</td>
	                    <td><c:if test="${order.dealPrice > 0}"><fmt:formatNumber  value="${order.dealPrice/100.0}" pattern="0.00" /></c:if></td>
	                    <td>${order.firstAuthContainerId}</td>
	                    <td>${order.orderAddress.name}/${order.orderAddress.mobile}</td>
	                    <td>${order.orderAddress.detail}</td>
	                    <td>${order.bizOperatorName}</td>
	                    <td>
	                    	<a href="${path}/order/place?id=${order.id}" style="color:#428bca;text-decoration:none;"><i class="fa fa-edit fa-offset"></i>完善订单</a>&nbsp;&nbsp;&nbsp;
	                    	<a href="javascript:void(0);" class="delete-order" data-id="${order.id}" style="color:#ff892a;text-decoration:none;"><i class="fa fa-trash fa-offset"></i>删除</a>
	                    </td>
	                </tr>            		
            	</c:forEach>
            	<c:if test="${empty page.content}">
            		<tr>
	                    <td colspan="10">无任何记录!</td>
	            	</tr>
            	</c:if>
            </tbody>
        </table>
        
        <div class="row">
        	<c:if test="${not empty page.content}">
				<div class="page-panel f-r" id="page-panel"></div>
			</c:if>
        </div>
    </div>
</div>
<div class="row">
	<div class="modal fade" id="delete-modal" tabindex="-1" role="dialog" aria-labelledby="order-modalLabel" aria-hidden="true" data-backdrop="static">
	    <div class="modal-dialog" style="width: 900px;">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close modal-close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <div class="" id="order-modalLabel" style="font-size: 16px;color:#428bca;">
	                    <strong><i class="fa fa-check"></i>删除记录</strong>
	                </div>
	            </div>
	            <div class="modal-body modal-detail">
	            	<form class="form-horizontal" id="delete-order-form" method="post">
		            	<div class="form-group">
		            		<input type="hidden" name="id">
		            		<span style="font-size: 17px;margin-left: 40px;">您确认要删除该记录?</span>
		            	</div>
		            </form>
	            </div>
	            <div class="modal-footer">
	            	<button type="button" class="btn btn-danger btn-close btn-width btn-delete">确认</button>
	                <button type="button" class="btn btn-default btn-close btn-width" data-dismiss="modal">关闭</button>
	            </div>
	        </div>
	    </div>
	</div>
</div>
</div>

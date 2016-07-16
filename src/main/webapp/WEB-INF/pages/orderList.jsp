<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="generateOrder-container" >
<h4 class="header"><b>订单管理-订单列表页</b></h4>
<div class="row">
    <div class="col-xs-12">
	    <div>
		    <form class="form-horizontal" id="order-search-form">
	            <input type="hidden" id="page" name="page"/>
	            <input type="hidden" name="totalPages" value="${page.totalPages}">
		        <input type="hidden" name="currentPage" value="${page.number}">
		        <input type="hidden" name="orderBy" value="${queryParam.orderBy}">
	            <div class="form-group" style="margin-bottom:8px;">
		           <label class="form-label">订单状态:</label>
		           <div class="form-content">
		             <div class="btn-group" data-toggle="buttons">
		               <label class="btn btn-white btn-default btn-sm <c:if test='${empty queryParam.status}'>active</c:if>" >
		                 <input class="status-default" type="radio" name="status" value="" <c:if test='${empty queryParam.status}'>checked</c:if> />全部
		               </label>
		               <label class="btn btn-white btn-default btn-sm <c:if test='${queryParam.status == 1}'>active</c:if>" >
		                 <input type="radio" name="status" value="1" <c:if test='${queryParam.status == 1}'>checked</c:if> />待支付
		               </label>
		               <label class="btn btn-white btn-default btn-sm <c:if test='${queryParam.status == 2}'>active</c:if>" >
		                 <input type="radio" name="status" value="2" <c:if test='${queryParam.status == 2}'>checked</c:if> />已支付
		               </label>
		               <label class="btn btn-white btn-default btn-sm <c:if test='${queryParam.status == 9}'>active</c:if>" >
		                 <input type="radio" name="status" value="9" <c:if test='${queryParam.status == 9}'>checked</c:if> />已取消
		               </label>
		            </div>
		          </div>
			    </div>
			    <div class="form-group" style="margin-bottom:8px;">
		           <label class="form-label">审核状态:</label>
		           <div class="form-content">
		             <div class="btn-group" data-toggle="buttons">
		               <label class="btn btn-white btn-default btn-sm <c:if test='${empty queryParam.approveResult}'>active</c:if>" >
		                 <input class="approve-result-default" type="radio" name="approveResult" value="" <c:if test='${empty queryParam.approveResult}'>checked</c:if> />全部
		               </label>
		               <label class="btn btn-white btn-default btn-sm <c:if test='${queryParam.approveResult == 0}'>active</c:if>" >
		                 <input type="radio" name="approveResult" value="0" <c:if test='${queryParam.approveResult == 0}'>checked</c:if> />不需要
		               </label>
		               <label class="btn btn-white btn-default btn-sm <c:if test='${queryParam.approveResult == 1}'>active</c:if>" >
		                 <input type="radio" name="approveResult" value="1" <c:if test='${queryParam.approveResult == 1}'>checked</c:if> />未提交
		               </label>
		               <label class="btn btn-white btn-default btn-sm <c:if test='${queryParam.approveResult == 2}'>active</c:if>" >
		                 <input type="radio" name="approveResult" value="2" <c:if test='${queryParam.approveResult == 2}'>checked</c:if> />审核中
		               </label>
		               <label class="btn btn-white btn-default btn-sm <c:if test='${queryParam.approveResult == 3}'>active</c:if>" >
		                 <input type="radio" name="approveResult" value="3" <c:if test='${queryParam.approveResult == 3}'>checked</c:if> />通过
		               </label>
		               <label class="btn btn-white btn-default btn-sm <c:if test='${queryParam.approveResult == 4}'>active</c:if>" >
		                 <input type="radio" name="approveResult" value="4" <c:if test='${queryParam.approveResult == 4}'>checked</c:if> />拒绝
		               </label>
		               <label class="btn btn-white btn-default btn-sm <c:if test='${queryParam.approveResult == 5}'>active</c:if>" >
		                 <input type="radio" name="approveResult" value="5" <c:if test='${queryParam.approveResult == 5}'>checked</c:if> />取消
		               </label>
		               <label class="btn btn-white btn-default btn-sm <c:if test='${queryParam.approveResult == 6}'>active</c:if>" >
		                 <input type="radio" name="approveResult" value="6" <c:if test='${queryParam.approveResult == 6}'>checked</c:if> />完成
		               </label>
		               <label class="btn btn-white btn-default btn-sm <c:if test='${queryParam.approveResult == 7}'>active</c:if>" >
		                 <input type="radio" name="approveResult" value="7" <c:if test='${queryParam.approveResult == 7}'>checked</c:if> />失败
		               </label>
		            </div>
		          </div>
			    </div>
			    <div class="form-group" style="margin-bottom:8px;">
		           <label class="form-label">授权状态:</label>
		           <div class="form-content">
		             <div class="btn-group" data-toggle="buttons">
		               <label class="btn btn-white btn-default btn-sm <c:if test='${empty queryParam.authorizeStatus}'>active</c:if>" >
		                 <input class="authorize-status-default" type="radio" name="authorizeStatus" value="" <c:if test='${empty queryParam.authorizeStatus}'>checked</c:if> />全部
		               </label>
		               <label class="btn btn-white btn-default btn-sm <c:if test='${queryParam.authorizeStatus == 0}'>active</c:if>" >
		                 <input type="radio" name="authorizeStatus" value="0" <c:if test='${queryParam.authorizeStatus == 0}'>checked</c:if>/>未处理
		               </label>
		               <label class="btn btn-white btn-default btn-sm <c:if test='${queryParam.authorizeStatus == 1}'>active</c:if>" >
		                 <input type="radio" name="authorizeStatus" value="1" <c:if test='${queryParam.authorizeStatus == 1}'>checked</c:if>/>成功
		               </label>
		               <label class="btn btn-white btn-default btn-sm <c:if test='${queryParam.authorizeStatus == 2}'>active</c:if>" >
		                 <input type="radio" name="authorizeStatus" value="2" <c:if test='${queryParam.authorizeStatus == 2}'>checked</c:if>/>不需要
		               </label>
		               <label class="btn btn-white btn-default btn-sm <c:if test='${queryParam.authorizeStatus == 3}'>active</c:if>" >
		                 <input type="radio" name="authorizeStatus" value="3" <c:if test='${queryParam.authorizeStatus == 3}'>checked</c:if>/>失败
		               </label>
		               <label class="btn btn-white btn-default btn-sm <c:if test='${queryParam.authorizeStatus == 12}'>active</c:if>" >
		                 <input type="radio" name="authorizeStatus" value="12" <c:if test='${queryParam.authorizeStatus == 12}'>checked</c:if>/>取消失败
		               </label>
		               <label class="btn btn-white btn-default btn-sm <c:if test='${queryParam.authorizeStatus == 11}'>active</c:if>" >
		                 <input type="radio" name="authorizeStatus" value="11" <c:if test='${queryParam.authorizeStatus == 11}'>checked</c:if>/>取消成功
		               </label>
		               <label class="btn btn-white btn-default btn-sm <c:if test='${queryParam.authorizeStatus == 99}'>active</c:if>" >
		                 <input type="radio" name="authorizeStatus" value="99" <c:if test='${queryParam.authorizeStatus == 99}'>checked</c:if>/>失败(不继续)
		               </label>
		            </div>
		          </div>
			    </div>
			    <div class="form-group" style="margin-bottom:8px;">
		           <label class="form-label">支付平台:</label>
		           <div class="form-content">
		             <div class="btn-group" data-toggle="buttons">
		               <label class="btn btn-white btn-default btn-sm <c:if test='${empty queryParam.payProvider}'>active</c:if>" >
		                 <input class="pay-provider-default" type="radio" name="payProvider" value="" <c:if test='${empty queryParam.payProvider}'>checked</c:if> />全部
		               </label>
		               <label class="btn btn-white btn-default btn-sm <c:if test='${queryParam.payProvider eq "3"}'>active</c:if>" >
		                 <input type="radio" name="payProvider" value="3" <c:if test='${queryParam.payProvider eq "3"}'>checked</c:if> />支付宝
		               </label>
		               <label class="btn btn-white btn-default btn-sm <c:if test='${queryParam.payProvider eq "4"}'>active</c:if>" >
		                 <input type="radio" name="payProvider" value="4" <c:if test='${queryParam.payProvider eq "4"}'>checked</c:if> />微信支付
		               </label>
		               <label class="btn btn-white btn-default btn-sm <c:if test='${queryParam.payProvider eq "1"}'>active</c:if>" >
		                 <input type="radio" name="payProvider" value="1" <c:if test='${queryParam.payProvider eq "1"}'>checked</c:if> />财付通
		               </label>
		            </div>
		          </div>
			    </div>
			    <div class="form-group" style="margin-bottom:8px;">
		           <label class="form-label">订单ID/支付ID:</label>
		           <div class="form-content">
		             <input class="form-control" type="text" name="id" placeholder="请填写订单ID/支付ID进行搜索" style="width:335px;" value="${queryParam.id}">
		          </div>
			    </div>
			    <div class="form-group" style="margin-bottom:8px;">
		           <label class="form-label">订单搜索:</label>
		           <div class="form-content" style="width:335px;">
		             <input class="form-control" type="text" name="searchText" placeholder="请填写商品名称/联系人/联系人电话/发票抬头" style="width:335px;" value="${queryParam.searchText}">
		          </div>
		          <div style="line-height:34px;">
		          	&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" id="search-category" style="text-decoration:none;">高级检索</a>
		          </div>
			    </div>
			    <div id="add-on-form" class="hide">
			    <div class="form-group" style="margin-bottom:8px;">
	                <label class="form-label">成交金额：</label>
	                <div class="form-content" style="width:335px;">
	                    <div class="input-group input-daterange col-sm-12">
	                    	<c:if test="${queryParam.minDealPrice == null}">
		                        <input type="text" name="minDealPrice" class="form-control" placeholder="请填写最低金额"/>
	                    	</c:if>
	                    	<c:if test="${queryParam.minDealPrice != null}">
		                        <input type="text" name="minDealPrice" class="form-control" placeholder="请填写最低金额" value="${queryParam.minDealPrice/100.0}"/>
	                    	</c:if>
	                        <span class="input-group-addon"><i class="fa fa-exchange" aria-hidden="true"></i></span>
	                        <c:if test="${queryParam.maxDealPrice == null}">
		                        <input type="text" name="maxDealPrice" class="form-control" placeholder="请填写最高金额"/>
	                    	</c:if>
	                    	<c:if test="${queryParam.maxDealPrice != null}">
		                        <input type="text" name="maxDealPrice" class="form-control" placeholder="请填写最高金额" value="${queryParam.maxDealPrice/100.0}"/>
	                    	</c:if>
	                    </div>
	                </div>
            	</div>
            	<div class="form-group" style="margin-bottom:8px;">
	                <label class="form-label">订单日期：</label>
	                <div class="form-content" style="width:335px;">
	                    <div class="input-group input-daterange col-sm-12">
	                        <input type="text" name="beginCreateTime" class="form-control time" placeholder="请选择起始日期" data-date-format="yyyy-mm-dd" value="${queryParam.beginCreateTimeStr}"/>
	                        <span class="input-group-addon"><i class="fa fa-exchange" aria-hidden="true"></i></span>
	                        <input type="text" name="endCreateTime" class="form-control time" placeholder="请选择截止日期" data-date-format="yyyy-mm-dd" value="${queryParam.endCreateTimeStr}"/>
	                    </div>
	                </div>
            	</div>
            	<div class="form-group" style="margin-bottom:8px;">
	                <label class="form-label">支付日期：</label>
	                <div class="form-content" style="width:335px;">
	                    <div class="input-group input-daterange col-sm-12">
	                        <input type="text" name="beginPayTime" class="form-control time" placeholder="请选择起始日期" data-date-format="yyyy-mm-dd" value="${queryParam.beginPayTimeStr}"/>
	                        <span class="input-group-addon"><i class="fa fa-exchange" aria-hidden="true"></i></span>
	                        <input type="text" name="endPayTime" class="form-control time" placeholder="请选择截止日期" data-date-format="yyyy-mm-dd" value="${queryParam.endPayTimeStr}"/>
	                    </div>
	                </div>
            	</div>
			    </div>
			    <div class="form-group" style="margin-bottom:8px;">
		           <label class="form-label"></label>
		           <div class="form-content">
		             <span>
		             	<button class="btn btn-sm btn-primary btn-query">查询 </button>
		             	<button class="btn btn-sm btn-primary btn-clean">清空</button>
		             	<button class="btn btn-sm btn-primary btn-export">导出EXCEL</button>
		             </span>
		          </div>
			    </div>
	        </form>        
	    </div>
	           
	    <table class="table table-hover table-striped table-bordered ">
            <thead>
                <tr class="table-header">
                    <th class="col-1" width="10%">操作</th>
                    <th class="col-2" width=8%>订单ID/支付ID</th>
                    <th class="col-3" width="10%">商品名称</th>
                    <th class="col-4" width="7%">
                    	订单日期
                    	<i class="fa fa-sort-up sort-up create-time-up"></i>
                    	<i class="fa fa-sort-desc sort-down create-time-down"></i>	
                    </th>
                    <th class="col-5" width="7%">
                    	支付日期
                    	<i class="fa fa-sort-up sort-up  pay-time-up"></i>
                    	<i class="fa fa-sort-desc sort-down pay-time-down"></i>	
                    </th>
                    <th class="col-6" width="7%">
                    	成交金额
                    	<i class="fa fa-sort-up sort-up deal-price-up"></i>
                    	<i class="fa fa-sort-desc sort-down deal-price-down"></i>	
                    </th>
                    <th class="col-7" width="5%">联系人/手机号</th>
                    <th class="col-8" width="5%">发票类型</th>
                    <th class="col-9" width="5%">支付平台</th>
                    <th class="col-10" width="5%">订单状态</th>
                </tr>
            </thead>
            <tbody class="tbody-order-list">
				<c:forEach items="${page.content}" var="zcmOrder">
            		  <tr>
	                	<td>
	                	<div style="text-align: center;margin-top:5px;">
	                			<c:if test="${zcmOrder.status == 1 && zcmOrder.approveResult == 3}">
		                			<a class="anchor" href="submit?zcmOrderId=${zcmOrder.id}" target="blank"><span style="color:#5799da;">客户付款</span></a>&nbsp;&nbsp;&nbsp;
	                			</c:if>
	                			<c:if test="${zcmOrder.status != 1 || zcmOrder.approveResult != 3}">
		                			<a class="anchor" href="javascript:void(0);" target="_blank" style="cursor:default;"><span style="color:#cccccc;">客户付款</span></a>&nbsp;&nbsp;&nbsp;
	                			</c:if>
	                			<a class="anchor" href="detail?orderId=${zcmOrder.id}" target="_blank"><span style="color:#5799da;">查看详情</span></a>
	                		</div>
	                		<div style="text-align: center;margin-top:5px;">
	                			<c:if test="${zcmOrder.status == 2 && zcmOrder.approveResult != 6}">
	                				<a class="anchor newLockGrant" href="javascript:void(0)" data-id="${zcmOrder.id}"><span style="color:#5799da;">资产授权</span></a>&nbsp;&nbsp;&nbsp;
	                			</c:if>
	                			<c:if test="${zcmOrder.status != 2 || zcmOrder.approveResult == 6}">
		                			<a class="anchor" href="javascript:void(0)" data-id="${zcmOrder.id}" style="cursor:default;"><span style="color:#cccccc;">资产授权</span></a>&nbsp;&nbsp;&nbsp;
	                			</c:if>
	                			<c:if test="${zcmOrder.status != 9 && zcmOrder.status != 2}">
		                			<a class="anchor cancelOrder" data-id="${zcmOrder.id}"><span style="color:#5799da;">取消订单</span></a>
	                			</c:if>
	                			<c:if test="${zcmOrder.status == 9 || zcmOrder.status == 2}">
	                				<a class="anchor" href="javascript:void(0)"><span style="color:#cccccc;">取消订单</span></a>
	                			</c:if>
	                		</div>
	                	</td>
	                    <td style="text-align:left;">
	                    	<span>订单ID：${zcmOrder.id}<br></span>
							<span>支付ID：${zcmOrder.payId}</span>
						</td>
	                    <td class="table-row-col" style="text-align:left;">
							<!-- z只显示第一级商品名称  -->
							<c:forEach items="${zcmOrder.zcmOrderItems}" var="orderItem" >
								<c:if test="${orderItem.level eq 0}">
									<c:forEach items="${orderItem.subItems}" var="subItem" >
										${subItem.lineNum} ${subItem.productName}-${subItem.limitConcurrent}节点<br>
									</c:forEach>
								</c:if>
								<c:if test="${orderItem.level eq 1}">
									${orderItem.lineNum} ${orderItem.productName}-${orderItem.limitConcurrent}节点<br>
								</c:if>
							</c:forEach>
						</td>
	                    <td><fmt:formatDate value="${zcmOrder.createTime}" type="both"/></td>
	                    <td><fmt:formatDate value="${zcmOrder.payTime}" type="both"/></td>
	                    <td style="text-align:right"><span style="color:#00CC00;"><fmt:formatNumber value="${zcmOrder.dealPrice/100.0}" pattern="0.00"/></td>
	                    <td>${zcmOrder.orderAddress.name}<br>${zcmOrder.orderAddress.mobile}</td>
	                    <td>
							<c:if test="${zcmOrder.orderInvoice.type == 1}">普通发票</c:if>
							<c:if test="${zcmOrder.orderInvoice.type == 2}">增值税发票</c:if>
						</td>
	                    <td>
	                    	<c:if test="${zcmOrder.payProvider == 1}">财付通</c:if>
							<c:if test="${zcmOrder.payProvider == 2}">快钱</c:if>
	                    	<c:if test="${zcmOrder.payProvider == 3}">支付宝</c:if>
							<c:if test="${zcmOrder.payProvider == 4}">微信</c:if>
	                    </td>
	                    <td>
	                    	<!--  
	                    	<c:if test="${zcmOrder.status == 0}"><span class="label label-primary">支付-创建中</span></c:if>
							<c:if test="${zcmOrder.status == 1}"><span class="label label-primary">支付-待支付</span></c:if>
							<c:if test="${zcmOrder.status == 2}"><span class="label label-success">支付-已支付</span></c:if>
							<c:if test="${zcmOrder.status == 9}"><span class="label label-danger">支付-已取消</span></c:if>
							
							<c:if test="${zcmOrder.approveResult == 0}"><span class="label label-primary">审核-不需要</span></c:if>
							<c:if test="${zcmOrder.approveResult == 1}"><span class="label label-danger">审核-未提交</span></c:if>
							<c:if test="${zcmOrder.approveResult == 2}"><span class="label label-primary">审核-审核中</span></c:if>
							<c:if test="${zcmOrder.approveResult == 3}"><span class="label label-success">审核-已通过</span></c:if>
							<c:if test="${zcmOrder.approveResult == 4}"><span class="label label-warning">审核-已拒绝</span></c:if>
							<c:if test="${zcmOrder.approveResult == 5}"><span class="label label-danger">审核-已取消</span></c:if>
							<c:if test="${zcmOrder.approveResult == 6}"><span class="label label-success">审核-完成</span></c:if>
							<c:if test="${zcmOrder.approveResult == 7}"><span class="label label-danger">审核-已失败</span></c:if>
							
							<c:if test="${zcmOrder.authorizeStatus == 0}"><span class="label label-primary">授权-未处理</span></c:if>
							<c:if test="${zcmOrder.authorizeStatus == 1}"><span class="label label-success">授权-成功</span></c:if>
							<c:if test="${zcmOrder.authorizeStatus == 2}"><span class="label label-primary">授权-不需要</span></c:if>
							<c:if test="${zcmOrder.authorizeStatus == 3}"><span class="label label-danger">授权-失败</span></c:if>
							<c:if test="${zcmOrder.authorizeStatus == 11}"><span class="label label-info">授权-取消成功</span></c:if>
							<c:if test="${zcmOrder.authorizeStatus == 12}"><span class="label label-warning">授权-取消失败</span></c:if>
							<c:if test="${zcmOrder.authorizeStatus == 99}"><span class="label label-danger">授权-授权失败</span></c:if>
							-->
							
							<c:if test="${zcmOrder.zcmOrderPageStatus == 'Crm未提交'}"><span class="label label-primary">Crm未提交</span></c:if>
							<c:if test="${zcmOrder.zcmOrderPageStatus == '审核中'}"><span class="label label-primary">审核中</span></c:if>
							<c:if test="${zcmOrder.zcmOrderPageStatus == '已拒绝'}"><span class="label label-danger">已拒绝</span></c:if>
							<c:if test="${zcmOrder.zcmOrderPageStatus == '待支付'}"><span class="label label-primary">待支付</span></c:if>
							<c:if test="${zcmOrder.zcmOrderPageStatus == '已支付'}"><span class="label label-primary">已支付</span></c:if>
							<c:if test="${zcmOrder.zcmOrderPageStatus == '创建资产失败'}"><span class="label label-danger">创建资产失败</span></c:if>
							<c:if test="${zcmOrder.zcmOrderPageStatus == '授权完成'}"><span class="label label-success">授权完成</span></c:if>
							<c:if test="${zcmOrder.zcmOrderPageStatus == '授权失败'}"><span class="label label-danger">授权失败</span></c:if>
							<c:if test="${zcmOrder.zcmOrderPageStatus == '取消授权失败'}"><span class="label label-danger">取消授权失败</span></c:if>
							<c:if test="${zcmOrder.zcmOrderPageStatus == '已取消'}"><span class="label label-danger">已取消</span></c:if>
						</td>
	                </tr>
            	</c:forEach> 
            	<c:if test="${empty page.content}">
					<tr>
	                	<td colspan="10" style="text-align:left;">您要查询的订单不存在</td>
	                </tr>
				</c:if>
            </tbody>
        </table>
        
        <div class="row">
        	<!-- 
         	<c:if test="${not empty page.content}">
           		<div class="page-panel" id="page-panel"></div>
            </c:if>       	
        	 -->
        	<c:if test="${not empty page.content}">
				<div class="page-panel f-r" id="page-panel"></div>
			</c:if>
        </div>
    </div>
</div>

<div class="row">
	<div class="modal fade" id="newLockGrant-modal" tabindex="-1" role="dialog" aria-labelledby="order-modalLabel" aria-hidden="true" data-backdrop="static">
	    <div class="modal-dialog" style="width: 1100px;">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close modal-close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <div class="" id="order-modalLabel" style="font-size: 16px;color:#428bca;">
	                    <strong><i class="fa fa-check"></i>资产授权  </strong>
	                </div>
	            </div>
	            <div class="modal-body modal-detail">
		            <form class="form-horizontal asset-form">
		            	<input type="hidden" name="zcmOrderId">
		            	<div class="form-group">
			            		<div class="col-sm-12">
			            			<div style="height:400px;overflow-y:auto;">
				            			<table class="table table-hover table-striped table-bordered grant-table">
								            <thead>
								                <tr style="background-color:#f3f3f3;">
								                    <th class="col-1" width="4%">行号</th>
								                    <th class="col-2" width=22%>产品名称</th>
								                    <th class="col-3" width="8%">产品助记符</th>
								                    <th class="col-4" width="6%">购买日期</th>
								                    <th class="col-5" width="9%">密码开始时间</th>
								                    <th class="col-6" width="9%">密码截止时间</th>
								                    <th class="col-7" width="8%">时效性产品</th>
								                    <th class="col-8" width="10%">加密锁/VIP账号</th>
								                    <th class="col-9" width="4%">节点</th>
								                </tr>
								            </thead>
								            <tbody></tbody>
								        </table>
			            			</div>
			            		</div>
			            	</div>
		            </form>
	            </div>
	            <div class="modal-footer">
	            	<button type="button" class="btn btn-primary btn-save">创建crm资产并授权</button>
	                <button type="button" class="btn btn-default btn-close btn-width" data-dismiss="modal">关闭</button>
	            </div>
	        </div>
	    </div>
	</div>
</div>

<div class="row">
	<div class="modal fade" id="cancel-modal" tabindex="-1" role="dialog" aria-labelledby="order-modalLabel" aria-hidden="true" data-backdrop="static">
	    <div class="modal-dialog" style="width: 700px;">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close modal-close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <div class="" id="order-modalLabel" style="font-size: 16px;color:#428bca;">
	                    <strong><i class="fa fa-check fa-offset"></i>确认</strong>
	                </div>
	            </div>
	            <div class="modal-body modal-detail">
		            <form class="form-horizontal" id="" method="post">
		            	<input type="hidden" name="id">
		            	<div class="form-group">
		            		<span style="font-size: 17px;margin-left: 40px;">您确认要取消订单?</span>
		            	</div>
		            </form>
	            </div>
	            <div class="modal-footer">
	            	<button type="button" class="btn btn-danger btn-save btn-width" data-dismiss="modal">确认</button>
	                <button type="button" class="btn btn-default btn-width" data-dismiss="modal">关闭</button>
	            </div>
	        </div>
	    </div>
	</div>
</div>
</div>

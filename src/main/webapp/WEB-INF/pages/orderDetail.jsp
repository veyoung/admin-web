<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="generateOrder-container" >
<h4 class="header"><b>订单管理-订单列表页-订单详情页</b></h4>
<div class="row">
	<span class="title">发票信息</span>
    <div class="col-xs-12">
	    <table class="detail-table">
            <tbody>
                <tr>
                	<td>发票类型：</td>
                	<td>
                		<c:if test="${order.orderInvoice.type == 1}">普通发票</c:if>
						<c:if test="${order.orderInvoice.type == 2}">增值税专用发票</c:if>
                	</td>
                </tr>
                <tr>
                	<td>发票抬头：</td>
                	<td>
                		<c:if test="${order.orderInvoice.type == 1}">${order.orderInvoice.name}</c:if>
						<c:if test="${order.orderInvoice.type == 2}">${order.orderInvoice.taxPayerCompany}</c:if>
                	</td>
                </tr>
                <tr>
                	<td>纳税人识别号：</td><td>${order.orderInvoice.taxPayerId}</td>
                </tr>
                <tr>
                	<td>开户银行：</td><td>${order.orderInvoice.taxPayerBank}</td>
                </tr>
                <tr>
                	<td>银行账户：</td><td>${order.orderInvoice.bankAccount}</td>
                </tr>
                <tr>
                	<td>注册电话：</td><td>${order.orderInvoice.registerPhone}</td>
                </tr>
                <tr>
                	<td>注册地址：</td><td>${order.orderInvoice.registerAddr}</td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<div class="row">
	<span class="title">订单详情</span>
    <div class="col-xs-12">
	    <table class="detail-table">
            <tbody>
                <tr>
                	<td>订单ID：</td><td width="300px">${order.id}</td>                 
                	<td>支付ID：</td><td>${order.payId}</td>
                </tr>
                <tr>
                	<td>联系人：</td><td>${order.orderAddress.name}</td>                
                	<td>手机号：</td><td>${order.orderAddress.mobile}</td>
                </tr>
                <tr>
                	<td>业务员：</td><td>${order.bizOperatorName}</td>
                	<td>产值所属部门：</td><td>${order.incomeBranchName}</td>
                </tr>
                <tr>
                	<td>总价：</td><td><fmt:formatNumber value="${order.dealPrice/100.0}" pattern="0.00"/></td>
                	<td>客户名称：</td><td>${customerName}</td>
                </tr>
                <tr>
                	<td>退款状态：</td>
                	<td>
                		<span>无需退款&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                		<c:if test="${order.status == 2}">
                		<a href="" style="cursor:pointer;">申请退款</a>
                		</c:if>
                	</td>
                	<td>快递单号：</td>
                	<td>
                		<input type="hidden" name="orderId" value="${order.id}">
                		<input type="text" name="expressId" placeholder="输入快递单号" style="height: 29px;width: 200px;" value="${order.expressId}">
                		<a href="javascript:void(0);" class="expressInput" style="cursor:pointer;">保存</a>
                	</td>
                </tr>
                
                <tr>
                	<td>收件地址：</td><td colspan="3">${order.orderAddress.provinceName}&nbsp;${order.orderAddress.cityName}&nbsp;${order.orderAddress.countryName}&nbsp;${order.orderAddress.detail}</td>
                </tr>
                <tr>
                	<td >CRM订单编号：</td>
                	<td > ${order.crmNum}</td>
                	<td >CRM订单ID：</td>
                	<td > ${order.crmId}</td>
                </tr>
                <tr>
                	<td valign="top">加密锁号：</td>
                	<td colspan="3">
						<c:forEach items="${itemList}" var="item">
							<c:if test="${empty item.parentId and item.authContainerIdType eq 'usbKey' and not empty item.authContainerId}">
								<div style="width: 300px;float: left;">${item.authContainerId}</div>
								<!-- <div style="width: 260px;float: left;">CRM订单ID： ${order.crmId}</div> -->
								<div style="width: 300px;float: left;">锁管理员账号：GLODON-${item.customerNum}</div>
								<br>
							</c:if>
						</c:forEach>
					</td>
                </tr>
                <!-- 
                <tr>
                	<td>订单管理员账号：</td><td>${order.contactAccount}</td>
                </tr>
                 -->
            </tbody>
        </table>
    </div>
</div>

<div class="row">
	<span class="title">商品清单</span>
    <div class="col-xs-12" style="margin-bottom:30px;">
        <div class="col-sm-10 col-sm-offset-1">
	       <table class="table table-hover table-striped table-bordered">
	           <thead>
	               <tr style="background-color:#f3f3f3;">
	                   <th class="col-1" width="4%">行号</th>
	                   <th class="col-2" width=10%>产品名称</th>
	                   <th class="col-3" width="8%">产品助记符</th>
	                   <th class="col-4" width="9%">购买日期</th>
	                   <th class="col-5" width="9%">密码开始时间</th>
	                   <th class="col-6" width="9%">密码截止时间</th>
	                   <th class="col-7" width="6%">时效性产品</th>
	                   <th class="col-8" width="8%">加密锁/VIP账号</th>
	                   <th class="col-9" width="4%">节点</th>
	                   <th class="col-10" width="6%">密码值</th>
	                   <th class="col-11" width="6%">授权状态</th>
	               </tr>
	           </thead>
	           <tbody>
	           	   <c:forEach items="${itemList}" var="zcmOrderItem">
		            <tr>
	                    <td>${zcmOrderItem.lineNum}</td>
	                    <td>${zcmOrderItem.productName}</td>
	                    <td>${zcmOrderItem.productPartNum}</td>
	                    <td><fmt:formatDate value="${zcmOrderItem.createTime}" type="both"/></td>
	                    <td><c:if test="${zcmOrderItem.authTimeBase == 'Y'}"><fmt:formatDate value="${zcmOrderItem.authStartTime}" type="both"/></c:if></td>
	                    <td><c:if test="${zcmOrderItem.authTimeBase == 'Y'}"><fmt:formatDate value="${zcmOrderItem.authEndTime}" type="both"/></c:if></td>
	                    <td>${zcmOrderItem.authTimeBase}</td>
	                    <td>${zcmOrderItem.authContainerId}</td>
	                    <td>${zcmOrderItem.limitConcurrent}</td>
	                    <td>-</td>
	                    <td>
							<c:if test="${order.authorizeStatus == 0}"><span class="label label-default">授权-未处理</span></c:if>
							<c:if test="${order.authorizeStatus == 1}"><span class="label label-success">授权-成功</span></c:if>
							<c:if test="${order.authorizeStatus == 2}"><span class="label label-default">授权-不需要</span></c:if>
							<c:if test="${order.authorizeStatus == 3}"><span class="label label-danger">授权-失败</span></c:if>
							<c:if test="${order.authorizeStatus == 11}"><span class="label label-info">授权-取消成功</span></c:if>
							<c:if test="${order.authorizeStatus == 12}"><span class="label label-warning">授权-取消失败</span></c:if>
							<c:if test="${order.authorizeStatus == 99}"><span class="label label-danger">授权-授权失败</span></c:if>
						</td>
	                </tr>
		        </c:forEach>
	           </tbody>
	       </table>
	       <div>
		       <form class="submit-crm-form">
		       		<input type="hidden" name="orderId" value="${order.id}">
			       	<!--<button class="btn btn-sm btn-primary">前往材价授权</button>-->
			       	<a href="http://bg.gldjc.com/" target="_blank" class="btn btn-sm btn-primary">前往材价授权</a>
			       	<c:if test="${order.approveResult == 1}">
				       	<button class="btn btn-sm btn-default btn-submit-crm">提交CRM审批<i></i></button>
			       	</c:if>
			       	<c:if test="${order.status == 2 && order.approveResult == 6  && (order.authorizeStatus == 0 || order.authorizeStatus == 3 || order.authorizeStatus == 99)}">
				       	<button class="btn btn-sm btn-default btn-auth-again">再次授权<i></i></button>
			       	</c:if>
		       </form>
		   </div>
        </div>
    </div>
</div>
</div>

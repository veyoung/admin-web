<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="generateOrder-container" >
<h4 class="header"><b>代客下单-找客户付款-付款结果页</b></h4>
<span class="result-tip">恭喜，订单已成功提交，请确认信息后选择联系人支付方式</span>

<div class="row">
	<span class="title">订单信息</span>
    <div class="col-xs-12">
	    <table class="detail-table">
            <tbody>
                <tr>
                	<td>所选商品：</td>
                	<td>
                		<table class="product-detail">
							<c:forEach items="${zcmOrder.zcmOrderItems}" var="orderItem">
								<tr>
									<td style="text-align:left;width: 80px;">
										<c:if test="${orderItem.saleType == 1}">新购:</c:if>
										<c:if test="${orderItem.saleType == 2}">加购:</c:if>
									</td>
									<td style="width: 100px;">
										<c:if test="${orderItem.usbKeyType == 1}">单机锁</c:if>
										<c:if test="${orderItem.usbKeyType == 2}">网络锁</c:if>
										<br>${orderItem.authContainerId}
									</td>
									<td>
										<c:forEach items="${orderItem.subItems}" var="subOrderItem">
											${subOrderItem.productName}-${subOrderItem.limitConcurrent}节点<br>
										</c:forEach>
									</td>
								</tr>
							</c:forEach>
                		</table>
                	</td>
                </tr>
                <tr>
                	<td>订单总价：</td><td><fmt:formatNumber value="${(zcmOrder.dealPrice)/100.0}" pattern="0.00元" /></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<div class="row">
	<span class="title">联系人信息</span>
    <div class="col-xs-12">
	    <table class="detail-table">
            <tbody>
                <tr>
                	<td>广联达账号：</td><td>${zcmOrder.contactAccount}</td>
                </tr>
                <tr>
                	<td>联系人：</td><td>${zcmOrder.orderAddress.name}</td>
                </tr>
                <tr>
                	<td>手机号：</td><td>${zcmOrder.orderAddress.mobile}</td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<div class="row">
	<span class="title">联系人支付方式</span>
    <div class="col-xs-12">
	    <table class="detail-table">
            <tbody>
                <tr>
                	<td>手机号：</td>
                	<td>${zcmOrder.orderAddress.mobile}</td>
                	<td></td>
                </tr>
                <tr>
                	<td>支付链接：</td>
                	<td>
                	<a href="https://shop.glodon.com/pay/select?zcmOrderId=${zcmOrder.id}" target="_blank">
                		https://shop.glodon.com/pay/select?zcmOrderId=${zcmOrder.id}
                	</a>
                	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                	</td>
                	<td></td>
                </tr>
                <!-- 
                <tr>
                	<td>支付二维码：</td>
                	<td><img class="qrCode"/></td>
                	<td><a>复制二维码</a></td>
                </tr>
                 -->
                <tr>
                	<td></td>
                	<td></td>
                </tr>
                <tr>
                	<td></td>
                	<td colspan="2"><a href="${path}" class="btn btn-primary">返回首页</a></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>
</div>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="generateOrder-container" >
<h4 class="header"><b>代客下单-找客户付款</b></h4>

<form id="submitOrderForm" class="form-horizontal" >
 <span class="title">联系人信息</span>
 <div class="row col-sm-8 col-sm-offset-2">
  <div class="form-group">
  	<input type="hidden" name="id" value="${zcmOrder.id}">
  	<input type="hidden" name="saveOrSubmit" value="submit">
    <label class="col-sm-2 control-label"><span class="required">*</span>手机号码:</label>
    <div class="col-sm-3">
      <input type="text" name="orderAddress.mobile" class="form-control" placeholder="请输入手机号" value="${zcmOrder.orderAddress.mobile}">
      <label class="error mobile-alert">手机号码不能为空</label>
    </div>
    <label class="col-sm-2 control-label"><span class="required">*</span>广联达账号:</label>
    <div class="col-sm-3">
      <input type="text" name="contactAccount" class="form-control" placeholder="请输入广联达账号" value="${zcmOrder.contactAccount}">
      <label class="error account-alert">广联达账号不能为空</label>
      <input type="hidden" name="orderAddress.userId">
    </div>
  </div>
  <div class="form-group">
    <div class="col-sm-8 col-sm-offset-2">
      <button class="btn btn-primary btn-search-address btn-width">查找地址</button>
    </div>
  </div>
  <div class="form-group">
    <label class="col-sm-2 control-label"><span class="required">*</span>所在地区:</label>
    <div class="col-sm-8">
	    <div class="input-group area"></div>
	    <input type="hidden" name="orderAddress.province" value="${zcmOrder.orderAddress.province}">
	    <input type="hidden" name="orderAddress.city" value="${zcmOrder.orderAddress.city}">
	    <input type="hidden" name="orderAddress.county" value="${zcmOrder.orderAddress.county}">
	    <input type="hidden" name="orderAddress.provinceName" value="${zcmOrder.orderAddress.provinceName}">
	    <input type="hidden" name="orderAddress.cityName" value="${zcmOrder.orderAddress.cityName}">
	    <input type="hidden" name="orderAddress.countryName" value="${zcmOrder.orderAddress.countryName}">
	    <label class="error area-alert">所在地区不能为空</label>
    </div>
    
  </div>
  <div class="form-group">
    <label class="col-sm-2 control-label"><span class="required">*</span>详细地址:</label>
    <div class="col-sm-8">
      <input type="text" name="orderAddress.detail" class="form-control" placeholder="请输入详细地址" value="${zcmOrder.orderAddress.detail}">
      <label class="error detail-alert">详细地址不能为空</label>
    </div>
  </div>
  <div class="form-group">
    <label class="col-sm-2 control-label"><span class="required">*</span>联系人:&nbsp;&nbsp;&nbsp;</label>
    <div class="col-sm-8">
      <input type="text" name="orderAddress.name" class="form-control" placeholder="请输入联系人" value="${zcmOrder.orderAddress.name}">
      <label class="error name-alert">联系人不能为空</label>
    </div>
  </div>
  </div>
  
  <span class="title">开票信息</span>
  <div class="row col-sm-8 col-sm-offset-3">
  	<div class="row step-content" style="margin-left:-42px;">
		<div class="invoice-type a">
			<label class="radio-label selected"> <input type="radio"
				class="invoice-type-radio" name="orderInvoice.type" value="" /> <span
				class="txt">不开发票</span> <i class="icon icon-version-selected"></i>
			</label>	
			<label class="radio-label choose-ordinary-invoice"> <input type="radio"
				class="invoice-type-radio" name="orderInvoice.type" value="1" /> <span
				class="txt">普通发票</span> <i class="icon icon-version-selected"></i>
			</label> 
			<label class="radio-label choose-extra-invoice"> <input type="radio"
				class="invoice-type-radio" name="orderInvoice.type" value="2" /> <span
				class="txt">增值税发票</span> <i class="icon icon-version-selected"></i>
			</label>
			
		</div>
		<div class="mod-invoice">
			<div class="invoice-wrap" data-invoice-status="${zcmOrder.orderInvoice.type}">
				<div class="clr row hide invoice-container" id="personal-invoice">
					<div class="row-l"  style="width:75px;">发票抬头：</div>
					<div class="row-r">
						<select class="form-control f-l" name="orderInvoice.title" style="width:80px;">
							<option value="1" <c:if test='${zcmOrder.orderInvoice.title == 1}'>selected</c:if>>个人</option>
							<option value="2" <c:if test='${zcmOrder.orderInvoice.title == 2}'>selected</c:if>>公司</option>
						</select> 
						<input class="form-control f-l" name="orderInvoice.name" type="text" placeholder="请输入发票抬头"
							class="inp" maxlength="100" style="margin-left:10px;width:300px;" value="${zcmOrder.orderInvoice.name}"/>
					</div>
					
				</div>
				<div class="rows-wrap hide invoice-container" id="company-invoice">
					<p class="title-tip">
						请认真填写下述信息，确保您所填写的开票信息与贵司税务登记证信息一致，避免因开票信息错误给贵司带来损失！</p>
					<div class="clr row">
						<div class="row-l">单位名称：</div>
						<div class="row-r">
							<input type="text" placeholder="单位名称"
								name="orderInvoice.taxPayerCompany" class="inp" value="${zcmOrder.orderInvoice.taxPayerCompany}"/>
						</div>
					</div>
					<div class="clr row">
						<div class="row-l">纳税人识别号：</div>
						<div class="row-r">
							<input type="text" placeholder="纳税人识别号"
								name="orderInvoice.taxPayerId" class="inp" value="${zcmOrder.orderInvoice.taxPayerId}"/>
						</div>
					</div>
					<div class="clr row">
						<div class="row-l">注册地址：</div>
						<div class="row-r">
							<input type="text" placeholder="注册地址"
								name="orderInvoice.registerAddr" class="inp" value="${zcmOrder.orderInvoice.registerAddr}"/>
						</div>
					</div>
					<div class="clr row">
						<div class="row-l">注册电话：</div>
						<div class="row-r">
							<input type="text" placeholder="注册电话"
								name="orderInvoice.registerPhone" class="inp" value="${zcmOrder.orderInvoice.registerPhone}"/>
						</div>
					</div>
					<div class="clr row">
						<div class="row-l">开户银行：</div>
						<div class="row-r">
							<input type="text" placeholder="开户银行"
								name="orderInvoice.taxPayerBank" class="inp" value="${zcmOrder.orderInvoice.taxPayerBank}"/>
						</div>
					</div>
					<div class="clr row">
						<div class="row-l">银行账户：</div>
						<div class="row-r">
							<input type="text" placeholder="银行账户"
								name="orderInvoice.bankAccount" class="inp" value="${zcmOrder.orderInvoice.bankAccount}"/>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
  </div>
  <div class="row col-sm-8 col-sm-offset-2" style="margin-top:20px;">
	  <div class="form-group">
	    <div class="col-sm-offset-1 col-sm-10">
	      <button class="btn btn-primary btn-submit-order">提交订单</button>
	      <button class="btn btn-success btn-save-order">保存订单</button>
	      <a href="${path}/order/place?id=${zcmOrder.id}" class="btn btn-default">&nbsp;&nbsp;上一步&nbsp;&nbsp;</a>
	    </div>
	  </div>
  </div>
</form>

<div class="row">
	<div class="modal fade" id="searchAddressModal" tabindex="-1" role="dialog" aria-labelledby="order-modalLabel" aria-hidden="true" data-backdrop="static">
	    <div class="modal-dialog" style="width: 700px;">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close modal-close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <div class="" id="order-modalLabel" style="font-size: 16px;color:#428bca;">
	                    <strong><i class="fa fa-check"></i>查找广联达账号-确认地址</strong>
	                </div>
	            </div>
	            <div class="modal-body modal-detail">
		            <form class="form-horizontal row" id="" method="post">
		            	<div style="margin-left:60px;width:600px;">
			            	<div class="address-tip">您输入的手机号<span style="color:#468CCA" class="addressMobile"></span></div>
			            	<div class="address-tip">您的账号是<span style="color:#468CCA" class="addressIdentity"></span></div>
			            	<div class="address-tip">您可选择一个账号下已有地址</div>
							<div id="address-content">
							</div>
		            	</div>
		            </form>
	            </div>
	            <div class="modal-footer">
	            	<button type="button" class="btn btn-primary btn-close btn-select-address btn-width" data-dismiss="modal">确定</button>
	                <button type="button" class="btn btn-default btn-close btn-width" data-dismiss="modal">取消</button>
	            </div>
	        </div>
	    </div>
	</div>
</div>

<div class="row">
	<div class="modal fade" id="reminderModal" tabindex="-1" role="dialog" aria-labelledby="order-modalLabel" aria-hidden="true" data-backdrop="static">
	    <div class="modal-dialog" style="width: 900px;">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close modal-close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <div class="" id="order-modalLabel" style="font-size: 16px;color:#428bca;">
	                    <strong><i class="fa fa-check fa-offset"></i>提示</strong>
	                </div>
	            </div>
	            <div class="modal-body modal-detail">
	            	<span>该账号下找不到任何地址,请切换关键词重新查找!</span>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-default btn-close btn-width" data-dismiss="modal">关闭</button>
	            </div>
	        </div>
	    </div>
	</div>
</div>
</div>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="generateOrder-container" >
<h4 class="header"><b>代客下单-新建订单页</b></h4>
<!--
<div class="caijia"> 
	<div style="float:left;">广材意向订单&nbsp;:&nbsp;</div>
	<div style="float:left;">
	2345761234-2016/4/28  14:48:30-郭微  18509289093-开票单位：广联达软件股份有限公司<br>
	 广材信息服务 x1 ；<br>
	 广材信息基础套餐 x1,加购：建筑数据包 x5,加购：市政数据包 x2<br>
	 支付总金额：￥13600<br>
	</div>
</div>
-->
${order.sourceContentParsed}

<c:set var="level1_authTimeBase" value=""/>
<div class="row">
    <div class="col-xs-12">
	    <div style="margin-bottom:10px;">
			<button class="btn btn-success btn-add-lock-modal" ><i class="fa fa-plus-circle" style="margin-right: 5px;"></i>添加新锁</button>
			<button class="btn btn-success btn-edit-lock-modal"><i class="fa fa-plus-circle" style="margin-right: 5px;"></i>原锁加购/续费</button>
			<button class="btn btn-success btn-add-product-modal"><i class="fa fa-plus-circle" style="margin-right: 5px;"></i>添加产品</button>
		</div>
        <table class="table table-order">
            <thead>
                <tr style="background-color:#5799da;color:white;">
                    <th class="col-1" width="12%">产品名称</th>
                    <th class="col-2" width="5%">产品助记符</th>
                    <th class="col-3" width="7%">节点数/授权数</th>
                    <th class="col-4" width="8%">加密锁号/VIP账号</th>
                    <th class="col-5" width="12%">密码开始日期-截止日期</th>
                    <th class="col-6" width="4%">单价</th>
                    <th class="col-7" width="4%">计算价</th>
                    <th class="col-8" width="4%">时效性</th>
                    <th class="col-9" width="6%">操作</th>
                </tr>
            </thead>
            <tbody>
            	 <c:forEach items="${orderList}" var="zcmOrderItem">
            	 	<c:if test="${zcmOrderItem.level == 0}">
            	 		<tr class='row-lock' data-id="${zcmOrderItem.id}" data-line-num="${zcmOrderItem.lineNum}" data-product-id="${zcmOrderItem.productId}" data-price-id="${zcmOrderItem.priceId}"
	           	 			style='<c:if test="${zcmOrderItem.id == orderItemId}">background-color: rgb(191, 255, 255);</c:if>'>
		                    <td colspan="9">
	                    		<span class="level-${zcmOrderItem.level}">
			                    	<c:if test="${zcmOrderItem.subItems != null}">
			                			<span style="color:#5799da;margin-right:5px;">
			                				<a class="minusOrPlus" data-line-num="${zcmOrderItem.lineNum}">
			                					<c:if test="${zcmOrderItem.level != 1}">
			                						<i class="fa fa-minus"></i>
			                					</c:if>
			                					<c:if test="${zcmOrderItem.level == 1}">
			                						<i class="fa fa-plus"></i>
			                					</c:if>
			                				</a>
			                			</span>
			                		</c:if>
			                		<c:if test="${zcmOrderItem.subItems == null}">
			                			<span style="width:11px;">&nbsp;&nbsp;&nbsp;&nbsp;</span>
			                		</c:if>
			                    	${zcmOrderItem.lineNum}&nbsp;&nbsp;
			                    	<span>${zcmOrderItem.productName}</span>
			                    	<span>-
			                    	    <c:if test="${zcmOrderItem.usbKeyMode == 'Y'}">可补锁</c:if>
										<c:if test="${zcmOrderItem.usbKeyMode == 'N'}">普通锁</c:if>-
										(所属客户:${zcmOrderItem.customerName == null ? "空": zcmOrderItem.customerName})
									</span>
		                    	</span>
		                        
		                        <div style="float:right;">
			                        <c:if test="${zcmOrderItem.level == 0 && zcmOrderItem.saleType == 2}">
				                    	<span style="color:#428bca"><i class="fa fa-eye fa-offset"></i><a class="detail-view" data-id="${order.id}" data-item-id="${zcmOrderItem.id}" style="cursor:pointer;">查看详情</a></span>&nbsp;&nbsp;
			                    	</c:if>
			                    	<c:if test="${zcmOrderItem.level <= 1}">
			                    		<span style="color:#ff892a"><i class="fa fa-trash fa-offset"></i><a class="delete-item" data-item-id="${zcmOrderItem.id}" style="cursor:pointer;color:#ff892a;">删除</a></span>
			                    	</c:if>
		                        </div>
		                    </td>
		                </tr>
            	 	</c:if>
           	 		<c:if test="${zcmOrderItem.level > 0}">
           	 			<tr data-id="${zcmOrderItem.id}" data-line-num="${zcmOrderItem.lineNum}" data-product-id="${zcmOrderItem.productId}" data-price-id="${zcmOrderItem.priceId}"
	           	 			style='<c:if test="${zcmOrderItem.level > 1 && zcmOrderItem.parentZcmOrderItemId != openItemId}">display:none;</c:if><c:if test="${zcmOrderItem.id == orderItemId}">background-color: rgb(191, 255, 255);</c:if>'>
		                    <td>
		                    	<span class="level-${zcmOrderItem.level}">
			                    	<c:if test="${zcmOrderItem.subItems != null}">
			                			<span style="color:#5799da;margin-right:5px;">
			                				<a class="minusOrPlus" data-line-num="${zcmOrderItem.lineNum}">
			                					<c:if test="${zcmOrderItem.level > 1}">
			                						<i class="fa fa-plus"></i>
			                					</c:if>
			                					<c:if test="${zcmOrderItem.level == 1 && zcmOrderItem.id != openItemId}">
			                						<i class="fa fa-plus"></i>
			                					</c:if>
			                					<c:if test="${zcmOrderItem.level == 1 && zcmOrderItem.id == openItemId}">
			                						<i class="fa fa-minus"></i>
			                					</c:if>
			                				</a>
			                			</span>
			                		</c:if>
			                		<c:if test="${zcmOrderItem.subItems == null}">
			                			<span style="width:11px;">&nbsp;&nbsp;&nbsp;&nbsp;</span>
			                		</c:if>
			                    	${zcmOrderItem.lineNum}&nbsp;&nbsp;
			                    	<span class="hide-col">${zcmOrderItem.productName}</span>
		                    	</span>
		                    </td>
		                    <td>${zcmOrderItem.productPartNum}</td>
		                    <td class="limitConcurrent">
	                    		<c:if test="${zcmOrderItem.level == 1 && zcmOrderItem.usbKeyType == 2}">
	                    			<div style="overflow: auto;margin:0 auto;width: 67px;">
		                    			<a class="minus" data-item-id="${zcmOrderItem.id}">-</a>
		                    			<input class="input-node" type="text" name="limitConcurrent" value="${zcmOrderItem.limitConcurrent}" data-origin-val="${zcmOrderItem.limitConcurrent}" data-item-id="${zcmOrderItem.id}"/>
		                    			<a class="plus" data-item-id="${zcmOrderItem.id}">+</a>
	                    			</div>
	                    		</c:if>
	                    		<c:if test="${zcmOrderItem.level == 1 && zcmOrderItem.usbKeyType == 1 || zcmOrderItem.level > 1}">
									${zcmOrderItem.limitConcurrent}
	                    		</c:if>
		                    </td>
		                    <td>${zcmOrderItem.authContainerId}</td>
		                    <td>
		                    	<%-- set level1_authTimeBase = Y/N --%>
		                    	<c:set var="showPrice" value="0"/>
		                    	<c:if test="${zcmOrderItem.level == 1}">
		                    		<c:set var="level1_authTimeBase" value="${zcmOrderItem.authTimeBase}"/>
		                    		<c:set var="showPrice" value="1"/>
		                    	</c:if>
		                    	
		                    	
		                    	<c:if test="${(zcmOrderItem.level == 1 and zcmOrderItem.authTimeBase == 'Y') 
		                    		or (zcmOrderItem.level == 2 and zcmOrderItem.authTimeBase == 'Y' and level1_authTimeBase == 'N')}">
		                    		<c:set var="showPrice" value="1"/>
		                    		<input class="startTime form-control" type="text" name="authStartTime" data-item-id="${zcmOrderItem.id}"
		                    		value="<fmt:formatDate value='${zcmOrderItem.authStartTime}' pattern='yyyy-MM-dd'/>"/>
									-
		                    		<input class="endTime form-control" type="text" name="authEndTime" data-item-id="${zcmOrderItem.id}"
		                    		value="<fmt:formatDate value='${zcmOrderItem.authEndTime}' pattern='yyyy-MM-dd'/>"/>
		                    	</c:if>
		                    </td>
		                    <td>
			                    <c:if test="${showPrice == 1}">
			                    	<span calss="price"><fmt:formatNumber  value="${zcmOrderItem.price/100.0}" pattern="0.00"/></span>
			                    </c:if>
		                    </td>
		                    <td>
			                     <c:if test="${showPrice == 1}">
			                    	<span calss="price"><fmt:formatNumber  value="${zcmOrderItem.totalPrice/100.0}" pattern="0.00"/></span>
			                    </c:if>
			                </td>
		                    <td>${zcmOrderItem.authTimeBase}</td>
		                    <td style="text-align:right">
		                    	<c:if test="${zcmOrderItem.level == 0 && zcmOrderItem.saleType == 2}">
			                    	<span style="color:#428bca"><i class="fa fa-eye fa-offset"></i><a class="detail-view" data-id="${order.id}" data-item-id="${zcmOrderItem.id}" style="cursor:pointer;">查看详情</a></span>&nbsp;&nbsp;
		                    	</c:if>
		                    	<c:if test="${zcmOrderItem.level <= 1}">
		                    		<span style="color:#ff892a"><i class="fa fa-trash fa-offset"></i><a class="delete-item" data-item-id="${zcmOrderItem.id}" style="cursor:pointer;color:#ff892a;">删除</a></span>
		                    	</c:if>
		                    </td>
		                </tr>
           	 		</c:if>
		        </c:forEach>
            </tbody>
        </table>
        
        <c:if test="${orderList != null}">
	        <div style="background-color:#E6E6E6;padding:5px 0 5px 0;">
		        <form class="form-horizontal form-find-pay" method="post">
		        	<div class="form-group">
		             <label class="col-sm-10 control-label" style="font-weight: normal;">订单总价：</label>
		             <div class="col-sm-2 form-content">
		                 <span style="color:red;font-size:19px;"><span id="originalPriceText" data-original-price="${order.originalPrice/100.0}">
		                 <fmt:formatNumber value="${order.originalPrice/100.0}" type="currency" pattern="0.00元"/></span></span>
		                 <input type="hidden" name="originalPrice">
		             </div>
		        	</div>
		        	<div class="form-group">
		             <label class="col-sm-10 control-label" style="font-weight: normal;">成交价：</label>
		             <div class="col-sm-2 form-content">
		                 <div class="input-group col-sm-10">
		                 	 <input type="hidden" name="id" value="${order.id}">
		                 	 <c:if test="${order.dealPrice != null}">
					         	<input type="text" name="dealPriceReal" class="form-control" placeholder="请输入成交价" value="${order.dealPrice/100.0}">
					         </c:if>
					         <c:if test="${order.dealPrice == null}">
					         	<input type="text" name="dealPriceReal" class="form-control" placeholder="请输入成交价" value="${order.originalPrice/100.0}">
					         </c:if>
					         <input type="hidden" name="dealPrice" >
					         <span class="input-group-addon">元</span>
					     </div>
		             </div>
		        	</div>
		        	<div class="form-group">
		             <label class="col-sm-10 control-label" style="font-weight: normal;">订单折扣：</label>
		             <div class="col-sm-2 form-content">
		                 <span style="color:red;font-size:19px;"><span id="discountText"></span></span>
		             </div>
		        	</div>
		        	<div class="form-group">
		             <label class="col-sm-10 control-label" style="font-weight: normal;">业务员：</label>
		             <div class="col-sm-2 form-content">
		                 <div class="input-group col-sm-10">
					         <select name="bizOperatorId" class="form-control" style="cursor:pointer;">
					         	<c:if test="${operators == null}">
					         		<option value="-1">请选择业务员</option>
					         	</c:if>
					         	<c:forEach var="operator" items="${operators}">
	                        		<option value="${operator.id}">${operator.name}</option>
	                        	</c:forEach>
	                         </select>
					     </div>
		             </div>
		        	</div>
		        	<div class="form-group">
		             <label class="col-sm-10 control-label" style="font-weight: normal;">产值所属部门：</label>
		             <div class="col-sm-2 form-content">
		             	 <input type="hidden" name="incomeBranchName" value="${operator.branchName}">
		                 <strong><span id="incomeBranchCode">${operators[0].branchName}</span></strong>
		             </div>
		        	</div>
		        	<div class="form-group">
		             <label class="col-sm-10 control-label"></label>
		             <div class="col-sm-2">
		             	 <c:if test="${order == null || fn:length(orderList) <= 0}">
		                 	<button class="btn btn-danger btn-confirm col-sm-10" disabled="disabled">下一步</button>
		                 </c:if>
		                 <c:if test="${order != null && fn:length(orderList) > 0}">
		                 	<button class="btn btn-danger btn-confirm col-sm-10">下一步</button>
		                 </c:if>
		             </div>
		        	</div>
		        </form>        
	        </div>
        </c:if>
        
        <c:if test="${orderList == null}">
        	<div class="alert alert-warning alert-dismissible" role="alert">
			  <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			  	<div style="text-align:center">订单暂时为空，请先添加锁</div>
			</div>
        </c:if>
        
    </div>
</div>

<div class="row">
	<div class="modal fade" id="addLock-modal" tabindex="-1" role="dialog" aria-labelledby="order-modalLabel" aria-hidden="true" data-backdrop="static">
	    <div class="modal-dialog" style="width:1000px;">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close modal-close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <div class="" id="order-modalLabel" style="font-size: 16px;color:#428bca;">
	                    <strong><i class="fa fa-check"></i>添加新锁</strong>
	                </div>
	            </div>
	            <div class="modal-body modal-detail">
		            <form class="form-horizontal form-add-lock">
		            	<div class="form-group">
				            <input name="orderId" type="hidden" value="${order.id}"/>
				            <input name="level" type="hidden" value="0"/>
				            <input name="saleType" type="hidden" value="1"/>
				            <input name="usbKeyType" type="hidden"/>
				            <input name="usbKeyMode" type="hidden"/>
				            <input name="authContainerIdType" type="hidden" value="1"/>
				            <input name="customerNum" type="hidden"/>
				            <input style="display:none"/>
		            	</div>
		            	<!--  
		            	<div class="form-group input-wrapper">
		            		<span><i class="fa fa-search fa-offset" style="color:#428bca;"></i>
				            <input name="addLockSearch" type="text" class="customizedInput" placeholder="请输入客户编号或客户名称进行搜索..."/></span>
		            	</div>
		            	-->
		            	<div class="form-group">
			            	<div class="input-group">
							  <input type="text" class="form-control" name="addLockSearch" placeholder="请输入客户编号或客户名称进行搜索..." style="font-size: 12px;">
							  <!-- 
								  <span class="input-group-addon" style="background-color: #4285f4;">
								  	<a class="add-lock-search" style="cursor:pointer">&nbsp;&nbsp;&nbsp;&nbsp;
								  		<i class="fa fa-search fa-offset" style="color:white;"></i>&nbsp;&nbsp;&nbsp;&nbsp;
								  	</a>
								  </span> 
							  -->
							  <a class="add-lock-search input-group-addon" style="cursor:pointer;background-color: #4285f4;">
							  	<i class="fa fa-search fa-offset" style="color:white;width: 37px;"></i>
							  </a>
							</div>
						</div>
		            	
		            	<div class="form-group">
	            			<div style="height:360px;overflow-y:auto;">
		            			<table class="table table-hover table-striped table-bordered">
			            			<thead>
						                <tr style="background-color:#f3f3f3;">
						                    <th width="3%"></th>
						                    <th width="10%">客户编号</th>
						                    <th width="23%">客户名称</th>
						                    <th width="10%">单位级别</th>
						                    <th width="30%">地址</th>
						                    <th width="7%">团队</th>
						                    <th width="7%">组织</th>
						                </tr>
						            </thead>
						            <tbody></tbody>
							    </table>
		            		</div>
							<span class="error-alert"><i class="fa fa-exclamation-triangle fa-offset"></i>选择客户是必填字段，请选择或更换检索词</span>
		            	</div>
		            	
		           		<div class="form-group">
			           		<label class="control-label" style="width:70px;text-align:left;font-weight:normal;float:left;">锁类型：</label>
			                <div style="width:450px;float:left;">
			                    <label class="radio-inline">
								  <input type="radio" name="lockType" value="option1" checked>单机普通锁
								</label>
								<label class="radio-inline">
								  <input type="radio" name="lockType" value="option2">单机可补锁
								</label>
								<label class="radio-inline">
								  <input type="radio" name="lockType" value="option3">网络普通锁
								</label>
								<label class="radio-inline">
								  <input type="radio" name="lockType" value="option4">网络可补锁
								</label>
			                </div>
		            	</div>
		            </form>
	            </div>
	            <div class="modal-footer">
	            	<button type="button" class="btn btn-primary btn-save">确定</button>
	                <button type="button" class="btn btn-default btn-close" data-dismiss="modal">取消</button>
	            </div>
	        </div>
	    </div>
	</div>
</div>

<div class="row">
	<div class="modal fade" id="editLock-modal" tabindex="-1" role="dialog" aria-labelledby="order-modalLabel" aria-hidden="true" data-backdrop="static">
	    <div class="modal-dialog" style="width: 1100px;">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close modal-close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <div class="" id="order-modalLabel" style="font-size: 16px;color:#428bca;">
	                    <strong><i class="fa fa-check"></i>原锁加购/续费</strong>
	                </div>
	            </div>
	            <div class="modal-body modal-detail">
		            <form class="form-horizontal form-edit-lock" id="" method="post">
					   	<div class="form-group">
					   		<input name="orderId" type="hidden" value="${order.id}"/>
					   		<input name="authContainerIdType" type="hidden"/>
					   		<input name="usbKeyType" type="hidden"/>
				            <input name="usbKeyMode" type="hidden"/>
				            <input name="customerId" type="hidden"/>
				            <input name="customerNum" type="hidden"/>
					   		<input style="display:none"/>
					   	</div>
					   	<!--  
					   	<div class="form-group input-wrapper">
				            <span><i class="fa fa-search fa-offset" style="color:#428bca;"></i>
				            <input name="editLockSearch" type="text" class="customizedInput" placeholder="请输入加密锁号、客户编号、客户名称进行搜索..."/></span>
		            	</div>-->
		            	<div class="form-group">
			            	<div class="input-group">
							  <input type="text" class="form-control" name="editLockSearch" placeholder="请输入加密锁号进行搜索..." style="font-size: 12px;">
							  <!--  
							  <span class="input-group-addon" style="background-color: #4285f4;">
							  	<a class="edit-lock-search" style="cursor:pointer">
							  	&nbsp;&nbsp;&nbsp;<i class="fa fa-search fa-offset" style="color:white;"></i>&nbsp;&nbsp;&nbsp;
							  	</a>
							  </span>
							  -->
							  <a class="edit-lock-search input-group-addon" style="cursor:pointer;background-color: #4285f4;">
							  	<i class="fa fa-search fa-offset" style="color:white;width: 37px;"></i>
							  </a>
							</div>
						</div>
		            	<div class="form-group">
			            	<div style="height:400px;overflow-y:auto;">
		            			<table class="table table-hover table-striped table-bordered">
						            <thead>
						                <tr style="background-color:#f3f3f3;">
						                    <th class="col-1" width="5%">勾选</th>
						                    <th class="col-2" width="8%">加密锁号</th>
						                    <th class="col-3" width="8%">产品类型</th>
						                    <th class="col-4" width="5%">锁模式</th>
						                    <th class="col-5" width="6%">客户编号</th>
						                    <th class="col-6" width="13%">客户名称</th>
						                    <th class="col-7" width="7%">业务员</th>
						                    <th class="col-8" width="7%">组织</th>
						                    <th class="col-9" width="9%">购买日期</th>
						                </tr>
						            </thead>
						            <tbody></tbody>
						        </table>
			            	</div>
			            	<span class="error-alert"><i class="fa fa-exclamation-triangle fa-offset"></i>选择锁号是必填字段，请检索并选择锁号</span>
			            </div>
		            </form>
	            </div>
	            <div class="modal-footer">
	            	<button type="button" class="btn btn-primary btn-save">确定</button>
	                <button type="button" class="btn btn-default btn-close" data-dismiss="modal">取消</button>
	            </div>
	        </div>
	    </div>
	</div>
</div>

<div class="row">
	<div class="modal fade" id="addProduct-modal" tabindex="-1" role="dialog" aria-labelledby="order-modalLabel" aria-hidden="true" data-backdrop="static">
	    <div class="modal-dialog" style="width: 1200px;">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close modal-close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <div class="" id="order-modalLabel" style="font-size: 16px;color:#428bca;">
	                    <strong><i class="fa fa-check"></i>添加产品</strong>
	                </div>
	            </div>
	            <div class="modal-body modal-detail">
		            <form class="form-horizontal form-add-product" id="" method="post" style="margin-top:-15px;">
		            	<div class="form-group">
				            <input name="orderId" type="hidden" value="${order.id}"/>
				            <input name="parentId" type="hidden"/>
				            <input name="level" type="hidden" value="1"/>
				            <input name="priceId" type="hidden"/>
				            <input style="display:none"/>
		            	</div>
		            	<!--
		            	<div class="form-group">
		            		<div class="col-sm-12">
		            			<div class="input-wrapper">
			            			<span class="addProductResult"></span>
			            			<span><a class="add-product-search" style="cursor:pointer"><i class="fa fa-search fa-offset" style="color:#428bca;"></a></i>
			            			<input class="customizedInput" name="addProductInput" type="text" placeholder="输入关键字,回车搜索应用..."></span>
		            			</div>
		            		</div>
		            	</div>-->
		            	<div class="form-group">
		            		<div class="col-sm-12">
		            			<span class="addProductResult"></span>
		            		</div>
		            	</div>
		            	<div class="form-group">
		            	    <div class="col-sm-12">
				            	<div class="input-group">
								  <input type="text" class="form-control" name="addProductInput" placeholder="输入关键字搜索应用..." style="font-size: 12px;">
								  <!--  
								  <span class="input-group-addon" style="background-color: #4285f4;">
								  	<a class="add-product-search" style="cursor:pointer">&nbsp;&nbsp;&nbsp;
								  		<i class="fa fa-search fa-offset" style="color:white;"></i>&nbsp;&nbsp;&nbsp;
								  	</a>
								  </span>
								  -->
								  <a class="add-product-search input-group-addon" style="cursor:pointer;background-color: #4285f4;">
								  	<i class="fa fa-search fa-offset" style="color:white;width: 37px;"></i>
								  </a>
								</div>
							</div>
						</div> 
		            	<div class="form-group">
		            		<div class="col-sm-12">
		            			<div style="height:355px;overflow-y:auto;">
			            			<table class="table table-hover table-striped table-bordered">
							            <thead>
							                <tr style="background-color:#f3f3f3;">
							                    <th class="col-1" width="2%">勾选</th>
							                    <th class="col-2" width="16%">产品名称</th>
							                    <th class="col-3" width="6%">产品助记符</th>
							                    <th class="col-4" width="6%">产品价格(元)</th>
							                    <th class="col-5" width="8%">产品分类</th>
							                    <th class="col-6" width="5%">产品类型</th>
							                    <th class="col-7" width="5%">组合类型</th>
							                    <th class="col-8" width="5%">版式</th>
							                    <th class="col-9" width="5%">时效性</th>
							                </tr>
							            </thead>
							            <tbody>
								            <c:forEach begin="1" end="8">
								                <tr><td>&nbsp;</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
							                </c:forEach>
							            </tbody>
							        </table>
		            			</div>
		            			<span class="error-alert"><i class="fa fa-exclamation-triangle fa-offset"></i>选择产品是必填字段，请检索并选择产品</span>
		            		</div>
		            	</div>
		            </form>
	            </div>
	            <div class="modal-footer">
	            	<button type="button" class="btn btn-primary btn-save">确定</button>
	                <button type="button" class="btn btn-default btn-close" data-dismiss="modal">取消</button>
	            </div>
	        </div>
	    </div>
	</div>
</div>

<div class="row">
	<div class="modal fade" id="detail-modal" tabindex="-1" role="dialog" aria-labelledby="order-modalLabel" aria-hidden="true" data-backdrop="static">
	    <div class="modal-dialog" style="width: 1200px;">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close modal-close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <div class="" id="order-modalLabel" style="font-size: 16px;color:#428bca;">
	                    <strong><i class="fa fa-check"></i>查看详情</strong>
	                </div>
	            </div>
	            <div class="modal-body modal-detail">
		            <form class="form-horizontal" id="" method="post">
		            	<div class="form-group">
		            		<div class="col-sm-12" style="height:355px;overflow-y:auto;">
		            			<table class="table table-hover table-striped table-bordered">
						            <thead>
						                <tr style="background-color:#f3f3f3;">
						                    <th class="col-1" width="4%">行号</th>
						                    <th class="col-2" width=10%>产品名称</th>
						                    <th class="col-3" width="5%">产品助记符</th>
						                    <th class="col-4" width="7%">加密锁/VIP账号</th>
						                    <th class="col-5" width="7%">购买日期</th>
						                    <th class="col-6" width="7%">密码开始时间</th>
						                    <th class="col-7" width="7%">密码截止时间</th>
						                    <th class="col-8" width="5%">时效性产品</th>
						                    <th class="col-10" width="4%">节点</th>
						                </tr>
						            </thead>
						            <tbody>
							            <c:forEach begin="1" end="3">
							                <tr><td>&nbsp;</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
						                </c:forEach>
							        </tbody>
						        </table>
		            		</div>
		            	</div>
		            </form>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-default btn-close" data-dismiss="modal">关闭</button>
	            </div>
	        </div>
	    </div>
	</div>
</div>
<div class="row">
	<div class="modal fade" id="delete-modal" tabindex="-1" role="dialog" aria-labelledby="order-modalLabel" aria-hidden="true" data-backdrop="static">
	    <div class="modal-dialog" style="width: 700px;">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close modal-close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <div class="" id="order-modalLabel" style="font-size: 16px;color:#428bca;">
	                    <strong><i class="fa fa-check fa-offset"></i>确认</strong>
	                </div>
	            </div>
	            <div class="modal-body modal-detail">
		            <form class="form-horizontal" id="deleteOrderItemForm">
		            	<div class="form-group">
		            		<input type="hidden" name="itemId">
		            		<span style="font-size: 17px;margin-left: 40px;">您确认要删除订单项?</span>
		            	</div>
		            </form>
	            </div>
	            <div class="modal-footer">
	            	<button type="button" class="btn btn-danger btn-width btn-delete" data-dismiss="modal">确认</button>
	                <button type="button" class="btn btn-default btn-width" data-dismiss="modal">关闭</button>
	            </div>
	        </div>
	    </div>
	</div>
</div>
</div>

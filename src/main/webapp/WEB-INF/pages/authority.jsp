<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="generateOrder-container" >
<div class="header-wrapper">
	<div class="f-l">
		<h4 class="header" style="border:0px;"><b>管理员权限</b></h4>
	</div>
	<div class="f-r">
		<button class="btn btn-success" data-target="#addManager-modal" data-toggle="modal"><i class="fa fa-plus-circle" style="margin-right: 5px;"></i>新建管理员</button>
	</div>
</div>
<div class="row">
 <form id="operatorForm" action="${path}/authority" method="post" >
  <div class="form-group" style="margin-left: 15px;float:left">
      <input type="hidden" name="page" value="${page.number}"/>
      <div class="form-content" style="padding-right:30px;width:200px;float:left">
        <input value="${id}"class="form-control" id="userInput" type="text" name="id" placeholder="用户名">
      </div>
      <div class="form-content" style="padding-right:30px;width:280px;float:left">
       <input value="${name}" class="form-control" id="nameInput" type="text" name="name" placeholder="姓名">
      </div>
      <c:if test="${isSysAdmin}">
      <div class="form-content" style="padding-right:30px;width:280px;float:left">
       <select id="selectBranchName" name="branchName" class="form-control">
		 <c:if test="${empty branchName}"><option value="${branchName}">请选择分支</option></c:if>
		 <c:if test="${!empty branchName}"><option selected="${branchName}">${branchName}</option></c:if>
		  <c:forEach items="${branchNames}" var="branchName">
		     <option value="${branchName.branchName}" >${branchName.branchName}</option>
		  </c:forEach>
	   </select>
       </div>
      </c:if>
      <c:if test="${!isSysAdmin}">
      <div class="form-content" style="padding-right:30px;width:280px;float:left">
       <select id="selectBranchName" name="branchName" class="form-control">
		  <c:forEach items="${branchNames}" var="branchName">
		     <option selected="${branchName.branchName}">${branchName.branchName}</option>
		  </c:forEach>
	   </select>
       </div>
      </c:if>
       <div class="form-content" style="padding-right:30px;width:120px;float:left">   
       <input type="submit" id="Search" class="form-control btn btn-sm btn-primary btn-query" value="查&nbsp&nbsp&nbsp询">
        </div>
  </div> 
 </form>
   <form id="lockForm">  
     <input type="hidden" name="operatorId"/>
     <input type="hidden" name="operatorStatus"/> 
   </form> 
    <div class="f-r" style="margin-bottom:10px;float:right;margin-right: 15px;">
      <button id="lock" class="btn btn-danger" style="width:80px;margin-right: 10px;">锁定</button>
	  <button id="UnLock" class="btn btn-success" style="width:80px;">解锁</button>
    </div> 
   
</div>        
<div class="row">
    <div class="col-xs-12">
	    <table class="table table-hover table-striped">
            <thead>
                <tr style="background-color:#5799da;color:white;">
                    <th class="col-1" width="8%">勾选</th>
                    <th class="col-2" width="8%">用户名</th>
                    <th class="col-3" width="8%">姓名</th>
                    <th class="col-4" width="5%">邮箱</th>
                    <th class="col-5" width="8%">角色</th>
                    <th class="col-6" width="12%">状态</th>
                    <th class="col-7" width="8%">分支</th>
                    <th class="col-8" width="8%">操作</th>
                </tr>
            </thead>
            <tbody>
            
            <c:forEach items="${page.content}" var="operator">
                        <tr><td>
                        <c:if test="${operator.roleId==null}">
                           <input type="checkbox" name="operator_checkout" value="${operator.id}"/>
                        </c:if>
                        <c:if test="${operator.roleId!=null}">
                        <c:choose>
                          <c:when test="${operator.roleId>currentRoleId}">
                            <input type="checkbox" name="operator_checkout" value="${operator.id} "/>
                          </c:when>
                          <c:otherwise>
                             <input type="checkbox" name="operator_checkout" value="${operator.id}" disabled/>
                          </c:otherwise>
                        </c:choose>
                        </c:if>
                        </td>
                        <td class="order-num" >${operator.id}</td>
                        <td class="order-num" >${operator.name}</td>
                        <td class="order-num" ></td>
                        <c:choose>
                         <c:when test="${operator.roleId==1}"><td id="${operator.id}" >超级管理员</td></c:when>
                         <c:when test="${operator.roleId==2}"><td id="${operator.id}" >分支管理员</td></c:when>
                         <c:when test="${operator.roleId==3}"><td id="${operator.id}" >普通业务员</td></c:when>
                         <c:otherwise><td id="${operator.id}" >未知身份</td></c:otherwise>
                        </c:choose>
                        <c:choose>
                          <c:when test="${operator.status==1}"><td class="${operator.id}" >正常</td></c:when>
                          <c:when test="${operator.status==9}"><td class="${operator.id}" ><b>禁用</b></td></c:when>
                          <c:otherwise><td class="${operator.id}" >未知</td></c:otherwise>
						</c:choose>
                        <td class="order-num">${operator.branchName}</td>
                        <td class="order-num">
                        <c:if test="${operator.roleId==null}">
                         <a href="javascript:void(0)" class="edit-operator" style="color:#428bca" data-id="${operator.id}" data-role="${operator.roleId}" data-target="#editOperator-modal" data-toggle="modal"><i class="fa fa-edit fa-offset"></i>编辑</a>
                        </c:if>
                        <c:if test="${operator.roleId!=null}">
                        <c:choose>
                          <c:when test="${operator.roleId>currentRoleId}">
                            <a href="javascript:void(0)" class="edit-operator" style="color:#428bca" data-id="${operator.id}" data-role="${operator.roleId}" data-target="#editOperator-modal" data-toggle="modal"><i class="fa fa-edit fa-offset"></i>编辑</a>
                          </c:when>
                          <c:otherwise>
                            <a  class="edit-operator" style="color:#cccccc;cursor:default;" data-id="${operator.id}" data-role="${operator.roleId}" data-toggle="modal"><i class="fa fa-edit fa-offset"></i>编辑</a>
                          </c:otherwise>
                        </c:choose>
                        </c:if>
                        </td></tr>
             </c:forEach>    
            </tbody>
        </table>
        <div style="float:right;">
         <c:if test="${not empty page.content}">
           		<div class="page-panel" id="page-panel" data-total-pages="${page.totalPages}" data-current-page="${page.number}"></div>
         </c:if>
         </div>  
    </div>
</div>
<!-- 编辑modal -->
<div class="row">
	<div class="modal fade" id="editOperator-modal" tabindex="-1" role="dialog" aria-labelledby="order-modalLabel" aria-hidden="true" data-backdrop="static">
	    <div class="modal-dialog" style="width: 700px;">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close modal-close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <div class="" id="order-modalLabel" style="font-size: 16px;color:#428bca;">
	                    <strong><i class="fa fa-check"></i>设置身份</strong>
	                </div>
	            </div>
	            <form class="form-horizontal operatorEditForm" id="authorityForm" method="post">
		            <div class="modal-body modal-detail">
		            <input type="hidden" name="operatorId">
						 <div class="form-group">
						    <label class="col-sm-2 col-sm-offset-1 control-label">角色：</label>
						    <div class="col-sm-7">
						    <shiro:hasRole name="sysAdmin">
						        <label class="radio-inline">
								  <input id="edit_sysAdmin" type="radio" name="role" value="1" >超级管理员
								</label>
							</shiro:hasRole>
							<shiro:hasRole name="branchAdmin">
								<label class="radio-inline">
								  <input id="edit_branchAdmin" type="radio" name="role" value="2">分支管理员
								</label>
							</shiro:hasRole>
							<shiro:hasRole name="operator">
								<label class="radio-inline">
								  <input id="edit_operator" type="radio" name="role" value="3">普通业务员
								</label>
						    </shiro:hasRole>
						    </div>
						 </div>
		            </div>
		            <div class="modal-footer">
		            	<button type="button" class="btn btn-primary btn-save btn-submit" data-dismiss="modal">保存</input>
		                <button type="button" class="btn btn-default btn-close" data-dismiss="modal">关闭</button>
		            </div>
	            </form>
	        </div>
	    </div>
	</div>
</div>
<!-- 新建管理员modal -->
<div class="row">
	<div class="modal fade" id="addManager-modal" tabindex="-1" role="dialog" aria-labelledby="order-modalLabel" aria-hidden="true" data-backdrop="static">
	    <div class="modal-dialog" style="width: 700px;">
	        <div id="createOperatorModal" class="modal-content">
	            <form class="form-horizontal authorityCreateForm">
		            <div class="modal-header">
		                <button type="button" class="close modal-close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                <div class="" id="operator-modalLabel" style="font-size: 16px;color:#428bca;">
		                    <strong><i class="fa fa-check"></i>新建管理员</strong>
		                </div>
		            </div>
		            <div class="modal-body modal-detail">
		            	<div class="form-group">
						    <label class="col-sm-2 col-sm-offset-1 control-label">账户域名：</label>
						    <div class="col-sm-7">
						      <input id="newOperatorId" type="text" name="id" class="form-control" placeholder="请输入用户名">
						    </div>
						 </div>
						 <div class="form-group">
						    <label class="col-sm-2 col-sm-offset-1 control-label">真实姓名：</label>
						    <div class="col-sm-7">
						      <input id="newOperatorName" type="text" name="name" class="form-control" placeholder="请输入真实姓名">
						    </div>
						 </div>
						 <div class="form-group">
						    <label class="col-sm-2 col-sm-offset-1 control-label">分支：</label>
						    <c:if test="${isSysAdmin}">
						    <div class="col-sm-7">
						      <select id="selectBranchName" name="branchName" class="form-control">
						         <option value="-1">请选择分支</option>
						             <c:forEach items="${branchNames}" var="branchName">
							            <option value="${branchName.branchName}">${branchName.branchName}</option>
						            </c:forEach>
					          </select>
						    </div>
						    </c:if>
						    <c:if test="${!isSysAdmin}">
						     <div class="col-sm-7">
						      <select id="selectBranchName" name="branchName" class="form-control">
						             <c:forEach items="${branchNames}" var="branchName">
							            <option selected="${branchName.branchName}">${branchName.branchName}</option>
						            </c:forEach>
					          </select>
						      <!--  <input id="newOperatorBranchName"type="text" name="branchName" class="form-control" placeholder="请输入分支">  -->
						    </div>
						    </c:if>
						 </div>
						 <div class="form-group">
						    <label class="col-sm-2 col-sm-offset-1 control-label">角色：</label>
						    <div class="col-sm-7">
						    <shiro:hasRole name="sysAdmin">
						        <label class="radio-inline">
								  <input type="radio" name="roleId" value="1" >超级管理员
								</label>
							</shiro:hasRole>
							<shiro:hasRole name="branchAdmin">
								<label class="radio-inline">
								  <input type="radio" name="roleId" value="2">分支管理员
								</label>
							</shiro:hasRole>
							<shiro:hasRole name="operator">
								<label class="radio-inline">
								  <input type="radio" name="roleId" value="3">普通业务员
								</label>
							</shiro:hasRole>
						    </div>
						 </div>
		            </div>
		            <div class="modal-footer">
		            	<button  type="submit" class="btn btn-primary btn-save btn-submit"data-dismiss="modal">保存</button>
		                <button type="button" class="btn btn-default btn-close" data-dismiss="modal">关闭</button>
		            </div>
	            </form>
	        </div>
	    </div>
	</div>
</div>
</div>
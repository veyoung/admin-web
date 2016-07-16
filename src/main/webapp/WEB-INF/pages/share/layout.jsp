<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="zh">
<head>
    <title><t:getAsString name="title" defaultValue="广联达-招财猫"/></title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="keywords" content="广联达，招财猫">
    <meta name="description" content="广联达，招财猫">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="bookmark" href="http://yun.glodon.com/isv">
    <link rel="shortcut icon" type="image/x-icon" href="//static.glodon.com/open/resources/images/favicon.ico"/>
    <link rel="stylesheet" type="text/css" href="//static.glodon.com/open/admin/pages/css/merge/common.merge.css">
    <t:importAttribute name="cssPath"/>
    <c:if test='${not empty cssPath}'>
  	<link rel="stylesheet" type="text/css" href="//static.glodon.com/open/admin/pages/css/merge/${cssPath}.merge.css">
	</c:if>
    <script>
        window.visitor = {
            path: "",
            marketURL: "${marketURL}"
        };
    </script>
</head>
<body class="no-skin">
<div id="layout" class="layout">
    <img id="loading-img"/><span>&nbsp;&nbsp;玩命加载中...</span>
</div>
<div class="container-wrap">
		<div class="mod-menu"  id="page-menu">
            <t:insertAttribute name="menu" />
        </div>
        <div class="display-content mod-menu-hide">
		</div>
        <div class="mod-content">
            <t:insertAttribute name="content" />
        </div>
    </div>
    <div class="mod-nav">
			<div class="nav-wrap">	
				<ol class="nav-user">
					<li class="user-logo"><a class="logo" href="${path}"></a></li>
					<li class="user-name">							
							<span>&nbsp;&nbsp;</span> 
							<a class="logout" href="${path}/logout">退出</a>
					</li>
				</ol>
			</div>
	</div>
    <script src="//static.glodon.com/open/admin/pages/js/merge/common.merge.js"></script>
    <t:importAttribute name="jsPath" />
	<c:if test='${not empty jsPath}'>
		<script src="//static.glodon.com/open/admin/pages/js/merge/${jsPath}.merge.js"></script>
	</c:if>
</body>
</html>

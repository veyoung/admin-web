<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

 <h3 class="message"  ondblclick ="$('.messageDetail').toggle(800);">哎呦喂，出错了！${exception.screenMessage}</h3>
<div class="messageDetail" style="display: none;background-color: #CCCCCC">
	<div >错误代码：${exception.code}</div>
	<div >错误原因：${exception.errorCause}</div>
	<div >错误详情：${exception.message}</div>
</div>
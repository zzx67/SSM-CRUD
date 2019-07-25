<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Employee List</title>
<%
	pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<!-- import jquery -->
<script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.4.min.js">
</script>
<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
	<!-- 搭建显示页面 -->
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		
		<!-- 按钮 -->
		<div class="row">
			 <div class="col-md-4 col-md-offset-8">
			 	<button class="btn btn-primary">Add</button>
			 	<button class="btn btn-danger">Delete</button>
			 </div>
		</div>
		
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					
					
					
				</table>
			</div>
		</div>
		
		<!-- 显示分页信息 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6">
				${pageInfo.pageNum} page, Total ${pageInfo.pages} pages, Total ${pageInfo.total} records
			</div>
			<!-- 分页条信息 -->
			<div class="col-md-6">
				
			</div>
		</div>
	</div>
	<script type="text/javascript">
		//1。页面加载完成后直接发送ajax请求，要到分页数据
		$(function(){
			$.ajax({
				url:"${APP_PATH/emps}",
				data:"pn=1",
				type:"GET",
				success:function(result){
					console.log(result);
				}
			});
			
		});
	
	</script>
</body>
</html>
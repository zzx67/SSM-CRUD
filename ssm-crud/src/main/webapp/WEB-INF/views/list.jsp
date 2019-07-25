<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
					<tr>
						<th>#</th>
						<th>EmpName</th>
						<th>Gender</th>
						<th>Email</th>
						<th>Deptname</th>
						<th>Operation</th>
					</tr>
					<tr>
						<th>1</th>
						<th>q</th>
						<th>M</th>
						<th>aaa@zzx.com</th>
						<th>deptname</th>
						<th>
							<button class="btn btn-primary btn-sm">
							<span class="glyphicon glyphicon-pencil" aria-hidden="true">
								Edit
							</button>
							<button class="btn btn-danger btn-sm">
							<span class="glyphicon glyphicon-trash" aria-hidden="true">
								Delete
							</button>
						</th>
					</tr>
				</table>
			</div>
		</div>
		
		
		<!-- 显示分页信息 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6">
				record: xxxx
			</div>
			<!-- 分页条信息 -->
			<div class="col-md-6">
				<nav aria-label="Page navigation">
					  <ul class="pagination">
					  	<li><a href="#">First page</a></li>
					    <li>
					      <a href="#" aria-label="Previous">
					        <span aria-hidden="true">&laquo;</span>
					      </a>
					    </li>
					    <li><a href="#">1</a></li>
					    <li><a href="#">2</a></li>
					    <li><a href="#">3</a></li>
					    <li><a href="#">4</a></li>
					    <li><a href="#">5</a></li>
					    <li>
					      <a href="#" aria-label="Next">
					        <span aria-hidden="true">&raquo;</span>
					      </a>
					    </li>
					    <li><a href="#">Last page</a></li>
					  </ul>
					</nav>
			</div>
		</div>
	</div>
</body>
</html>
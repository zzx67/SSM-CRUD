<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
					<c:forEach items="${pageInfo.list }" var="emp">
						<tr>
							<th>${emp.empId}</th>
							<th>${emp.empName}</th>
							<th>${emp.gender=="M"?"Male":"Female"}</th>
							<th>${emp.email}</th>
							<th>${emp.department.deptName}</th>
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
					
					</c:forEach>
					
				</table>
			</div>
		</div>
		
		
		<!-- 显示分页信息 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6">
				${pageInfo.pageNum} page, total ${pageInfo.pages} pages, total ${pageInfo.total} records
			</div>
			<!-- 分页条信息 -->
			<div class="col-md-6">
				<nav aria-label="Page navigation">
					  <ul class="pagination">
					  	<li><a href="${APP_PATH }/emps?pn=1">First page</a></li>
					    <li>
						    <c:if test="${pageInfo.hasPreviousPage}">
						    	<a href="${APP_PATH }/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
						        	<span aria-hidden="true">&laquo;</span>
						      	</a>
						    </c:if>
					
					    </li>
					    <c:forEach items="${pageInfo.navigatepageNums }" var="page_Num">
					    	<c:if test="${page_Num == pageInfo.pageNum}">
					    		<li class="active"><a href="#">${page_Num}</a></li>
					    	</c:if>
					    	
					    	<c:if test="${pageInfo.pageNum!=page_Num}">
					    		<li><a href="${APP_PATH }/emps?pn=${page_Num}">${page_Num}</a></li>
					    	</c:if>
					    </c:forEach>
					    <li>
					    	<c:if test="${pageInfo.hasNextPage}">
						      <a href="#" aria-label="Next">
						        <span aria-hidden="true">&raquo;</span>
						      </a>
						    </c:if>
					    </li>
					    <li><a href="${APP_PATH }/emps?pn=${pageInfo.pages}">Last page</a></li>
					  </ul>
					</nav>
			</div>
		</div>
	</div>
</body>
</html>
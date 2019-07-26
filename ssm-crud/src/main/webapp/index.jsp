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
	
	<!-- add emp modal -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">Add employee</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal">
	        
				  <div class="form-group">
				    <label class="col-sm-2 control-label">empName</label>
				    <div class="col-sm-10">
				      <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">email</label>
				    <div class="col-sm-10">
				      <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@zzx.com">
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">gender</label>
				    <div class="col-sm-10">
				      <label class="radio-inline">
						  <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> Male
					  </label>
					  <label class="radio-inline">
						  <input type="radio" name="gender" id="gender2_add_input" value="F"> Female
					  </label>
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">deptName</label>
				    <div class="col-sm-4">
				      	<select class="form-control">
						  	
						</select>
				    </div>
				  </div>
				  
				  
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary">Save changes</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<div class="container">
		
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		
		
		<div class="row">
			 <div class="col-md-4 col-md-offset-8">
			 	<button class="btn btn-primary" id="emp_add_modal_btn">Add</button>
			 	<button class="btn btn-danger">Delete</button>
			 </div>
		</div>
		
	
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_tables">
					<thead>
						<tr>
							<th>#</th>
							<th>EmpName</th>
							<th>Gender</th>
							<th>Email</th>
							<th>Deptname</th>
							<th>Operation</th>
						</tr>
					</thead>
					<tbody>
						
					</tbody>
				</table>
			</div>
		</div>
		
		
	
		<div class="row">
		
			<div class="col-md-6" id="page_info_area">
				
			</div>
			
			<div class="col-md-6" id="page_nav_area">
				
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(function(){
			toPage(1);
		});
		
		function toPage(pn){
			$.ajax({
				url:"http://localhost:8080/${APP_PATH}/emps",
				data:"pn="+pn,
				type:"GET",
				success:function(result){
					build_emps_table(result);
					build_page_info(result);
					build_page_nav(result);
				}
			});
		}
		
		function build_emps_table(result){
			$("#emps_tables tbody").empty();
			
			var emps = result.extend.pageInfo.list;
			$.each(emps,function(index,item){
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(item.gender=='M'?"Male":"Female");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>").append(item.department.deptName);
				var editBnt = $("<button></button>").addClass("btn btn-primary btn-sm")
					.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("Eidt");
				
				var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm")
				.append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("Delete");
				
				var BtnTd = $("<td></td>").append(editBnt).append(" ").append(delBtn);
				
				$("<tr></tr>").append(empIdTd)
					.append(empNameTd)
					.append(genderTd)
					.append(emailTd)
					.append(deptNameTd)
					.append(BtnTd)
					.appendTo("#emps_tables tbody");
			});
		}
		
		function build_page_info(result){
			$("#page_info_area").empty();
			$("#page_info_area").append(result.extend.pageInfo.pageNum +" page, total "
					+ result.extend.pageInfo.pages+" pages, total "
					+result.extend.pageInfo.total+" records");
		}
		
		function build_page_nav(result){
			$("#page_nav_area").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			
			var firstPageLi = $("<li></li>").append($("<a></a>").append("First page").attr("href","#"));
			var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
			if(result.extend.pageInfo.hasPreviousPage == false){
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}
			firstPageLi.click(function(){
				toPage(1);
			});
			
			prePageLi.click(function(){
				toPage(result.extend.pageInfo.pageNum-1);
			});
			
			var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
			var lastPageLi = $("<li></li>").append($("<a></a>").append("Last page").attr("href","#"));
			if(result.extend.pageInfo.hasNextPage == false){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}
			
			lastPageLi.click(function(){
				toPage(result.extend.pageInfo.pages);
			});
			
			nextPageLi.click(function(){
				toPage(result.extend.pageInfo.pageNum+1);
			});
			
			
			ul.append(firstPageLi).append(prePageLi);
			
			$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
				
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if(result.extend.pageInfo.pageNum == item){
					numLi.addClass("active")
				}
				numLi.click(function(){
					toPage(item);
				});
				ul.append(numLi);
			});
			
			ul.append(nextPageLi).append(lastPageLi);
			
			var navEle =  $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area")
		}
		$("#emp_add_modal_btn").click(function(){
			$("#empAddModal").modal({
				backdrop: "static"
			})
			
		});
		
	</script>
</body>
</html>
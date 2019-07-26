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
				      <span class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">email</label>
				    <div class="col-sm-10">
				      <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@zzx.com">
				      <span class="help-block"></span>
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
				      	<select class="form-control" name="dId" id="dept_add_select">
						  	
						</select>
				    </div>
				  </div>
				  
				  
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary" id="emp_save_btn">Save changes</button>
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
	
		var totalRecord;
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
			totalRecord = result.extend.pageInfo.total;
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
		
		function reset_form(ele){
			//remove form info(reset form)
			$(ele)[0].reset();
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}
		
		//click add btn
		$("#emp_add_modal_btn").click(function(){
			//remove form info(reset form)
			reset_form("#empAddModal form");
			
			//send ajax request, get dept info
			getDepts();
			
			//show modal
			$("#empAddModal").modal({
				backdrop: "static"
			})
			
		});
		
		//get dept info
		function getDepts(){
			$.ajax({
				url:"http://localhost:8080/${APP_PATH}/depts",
				type:"GET",
				success:function(result){
				
					
					$.each(result.extend.depts,function(){
						var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
						optionEle.appendTo("#dept_add_select");
					});
				}
			});
		}
		
		
		//verify the input data
		function validata_add_form(){
			//get the data
			var empName = $("#empName_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
			if(!regName.test(empName)){
				show_validate_msg("#empName_add_input","error","Username should be 6-16 letters or numbers");
				return false;
			}else{
				show_validate_msg("#empName_add_input","success","");
			};
			var email = $("#email_add_input").val();
			var regEmail = /^([A-Za-z0-9_\-\.]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				show_validate_msg("#email_add_input","error","Email address is invalid");
				return false;
			}else{
				show_validate_msg("#email_add_input","success","");
			};
			return true;
		}
		
		function show_validate_msg(ele,status,msg){
			//remove current status
			$(ele).parent().removeClass("has-success has-error")
			$(ele).next("span").text("");
			
			if("success"==status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}else if("error"==status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			};
		}
		
		$("#empName_add_input").change(function(){
			//send ajax request to verify the emp name
			var empName = this.value;
			$.ajax({
				url:"http://localhost:8080/${APP_PATH}/checkuser",
				data:"empName="+empName,
				type:"POST",
				success:function(result){
					if(result.code==100){
						show_validate_msg("#empName_add_input","success",result.extend.va_msg);
						$("#emp_save_btn").attr("ajax-va","success");
					}else{
						show_validate_msg("#empName_add_input","error",result.extend.va_msg);
						$("#emp_save_btn").attr("ajax-va","error");
					}
				}
			});
			
		});
		
		//click but and save emp into database
		$("#emp_save_btn").click(function(){
			//first need to verify the input data
			if(!validata_add_form()){
				return false
			}
			//decide if the verification of name success(if can submit or not)
			if($(this).attr("ajax-va")=="error"){
				return false;
			}
			
			$.ajax({
				url:"http://localhost:8080/${APP_PATH}/emp",
				type:"POST",
				data:$("#empAddModal form").serialize(),
				success:function(result){
					if(result.code==100){
						$('#empAddModal').modal('hide')
						//show the last page info
						toPage(totalRecord);
					}else{
						if(undefined!=result.extend.errorFields.email){
							show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
						}
						if(undefined!=result.extend.errorFields.empName){
							show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName)
						}
					}
				}
			});
		});
		
		
		
		
	</script>
</body>
</html>
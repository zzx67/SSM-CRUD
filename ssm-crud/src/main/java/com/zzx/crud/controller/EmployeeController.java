package com.zzx.crud.controller;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zzx.crud.bean.Employee;
import com.zzx.crud.bean.Msg;
import com.zzx.crud.service.EmployeeService;

/**
 * 处理员工CRUD请求
 * @author User
 *
 */
@Controller
public class EmployeeController {
	
	@Autowired
	EmployeeService employeeService;
	
	
	@ResponseBody
	@RequestMapping(value="/emp/{empId}",method = RequestMethod.DELETE)
	public Msg deleteEmp(@PathVariable("empId")String empIds) {
		if(empIds.contains("-")) {
			List<Integer> delIds = new ArrayList<Integer>(); 
			String[] ids = empIds.split("-");
			for(String string:ids) {
				delIds.add(Integer.parseInt(string));
			}
			employeeService.deleteBatch(delIds);
			return Msg.success();
			
		}else {
			Integer empId = Integer.parseInt(empIds);
			employeeService.deleteEmp(empId);
			return Msg.success();
		}
		
	}
	
	//update emp
	@RequestMapping(value="/emp/{empId}",method = RequestMethod.PUT)
	@ResponseBody
	public Msg updateEmp(Employee employee) {
		System.out.println("employee: "+employee);
		employeeService.updateEmp(employee);
		
		return Msg.success();
	}
	
	//get emp by id
	@RequestMapping(value="/emp/{id}",method = RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id")Integer id) {
		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}
	
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue = "1")Integer pn) {
		PageHelper.startPage(pn, 5);
		PageHelper.orderBy("emp_id asc");
		List<Employee> emps = employeeService.getAll();
		//使用pageinfo包装查询后的结果
		//封装了详细的分页信息，包括有查询出来的数据,传入连续显示的页数
		PageInfo page = new PageInfo(emps,5);
		return Msg.success().add("pageInfo", page);
	}
	
	@ResponseBody
	@RequestMapping("/checkuser")
	public Msg checkuser(@RequestParam("empName")String empName) {
		//first check if name valid
		String regex = "(^[a-zA-Z0-9_-]{3,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)";
		if(!empName.matches(regex)){
			return Msg.fail().add("va_msg", "Username should be 6-16 letters or numbers");
		}
		
		boolean canUse = employeeService.checkUser(empName);
		if(canUse) {
			return Msg.success().add("va_msg", "Name is available");
		}else {
			return Msg.fail().add("va_msg", "Name is not available. Duplicated name.");
		}
		
	}
	
	@RequestMapping(value="/emp",method = RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result) {
		if(result.hasErrors()) {
			Map<String,Object> map = new HashMap<String, Object>();
			List<FieldError> errors = result.getFieldErrors();
			for(FieldError fieldError:errors) {
				System.out.println("错误字段名 "+fieldError.getField());
				System.out.println("错误信息 "+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else {
			employeeService.saveEmp(employee);
			return Msg.success();
		}
	}
	
	
	//查询之前只需调用，穿入页码以及每页大小。
	//@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue = "1")Integer pn,Model model) {
		PageHelper.startPage(pn, 5);
		List<Employee> emps = employeeService.getAll();
		//使用pageinfo包装查询后的结果
		//封装了详细的分页信息，包括有查询出来的数据,传入连续显示的页数
		PageInfo page = new PageInfo(emps,5);
		model.addAttribute("pageInfo",page);
		
		return "list";
	}
}

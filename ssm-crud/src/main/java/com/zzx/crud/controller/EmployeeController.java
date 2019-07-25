package com.zzx.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
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
	
//	@RequestMapping("/emps")
//	@ResponseBody
//	public Msg getEmpsWithJson(
//			@RequestParam(value="pn",defaultValue = "1")Integer pn) {
//		PageHelper.startPage(pn, 5);
//		List<Employee> emps = employeeService.getAll();
//		//使用pageinfo包装查询后的结果
//		//封装了详细的分页信息，包括有查询出来的数据,传入连续显示的页数
//		PageInfo page = new PageInfo(emps,5);
//		return Msg.success().add("pageInfo",page);
//	}
	
	
	//查询之前只需调用，传入页码以及每页大小。
	@RequestMapping("/emps")
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

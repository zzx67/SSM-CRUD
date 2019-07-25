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
 * ����Ա��CRUD����
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
//		//ʹ��pageinfo��װ��ѯ��Ľ��
//		//��װ����ϸ�ķ�ҳ��Ϣ�������в�ѯ����������,����������ʾ��ҳ��
//		PageInfo page = new PageInfo(emps,5);
//		return Msg.success().add("pageInfo",page);
//	}
	
	
	//��ѯ֮ǰֻ����ã�����ҳ���Լ�ÿҳ��С��
	@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue = "1")Integer pn,Model model) {
		PageHelper.startPage(pn, 5);
		List<Employee> emps = employeeService.getAll();
		//ʹ��pageinfo��װ��ѯ��Ľ��
		//��װ����ϸ�ķ�ҳ��Ϣ�������в�ѯ����������,����������ʾ��ҳ��
		PageInfo page = new PageInfo(emps,5);
		model.addAttribute("pageInfo",page);
		
		return "list";
	}
}

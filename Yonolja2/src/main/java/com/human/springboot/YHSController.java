package com.human.springboot;

import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class YHSController {
	@Autowired
	private DAO dao;
	
	@GetMapping("/")
	public String test() {
		return "test";
	}
	
	@PostMapping("/test")
	@ResponseBody
	public String tt() {
		ArrayList<DTO> dto = dao.test();

		System.out.println("size=" + dto.size());

		JSONArray ja = new JSONArray();

		for (int i = 0; i < dto.size(); i++) {
			JSONObject jo = new JSONObject();

			DTO mo = new DTO();
			mo = dto.get(i);
			jo.put("name", mo.getName());
			jo.put("data", mo.getData());

			ja.put(jo);

		}
		return ja.toString();
	}
	
	@PostMapping("/insert")
	@ResponseBody
	public String insert(HttpServletRequest req) {
		
		String retval = "ok";
		
		try {
			String name = req.getParameter("name");
			String data = req.getParameter("data");
			
			dao.insert(name, data);
		} catch (Exception e) {
			retval = "fail";
		}
		return retval;
		
	}
	
}

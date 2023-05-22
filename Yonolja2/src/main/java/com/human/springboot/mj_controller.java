package com.human.springboot;

import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class mj_controller {
	
	@Autowired
	private mj_DAO mjdao;
	
	@GetMapping("/home")
	public String showHome() {	
		return "home";
	}
	
	

	@PostMapping("/showCalendar")
	public String showCalendar(HttpServletRequest req) {
		String data = req.getParameter("data");
		System.out.println(data);
		return "calendar";
	}
	
	@GetMapping("/showCalendar2")
	public String showCalendar2() {
		return "calendar";
	}
	
	
	@GetMapping("book/{room_seq}")
	public String doBook(@PathVariable("room_seq") int room_seq, Model model) {
		System.out.println(room_seq);
		model.addAttribute("room_seq",room_seq);
		return "book3";
	}
	
	
	
	// 여기부터 달력 sorting 작업
	
	@PostMapping("/get_room_books")	// 이거 나중에 roomz table 말고 다른곳에서 가져오게 xml 코드 바꿔야함.
	@ResponseBody
	public String checkin_sort(HttpServletRequest req) {
		int room_seq = Integer.parseInt( req.getParameter("room_seq") );
		
		// 그 room 에 대한 모든 예약에 대한 체크인과 체크아웃을 가져옴. 
		// 그걸 어째 저째 계산 해가지고 달력에서 예약못하는 날짜에 x표시 하면 되는것임. 
		ArrayList<mj_bookDTO> books = mjdao.getBooks(room_seq);
		
		JSONArray ja = new JSONArray();
		for(int i=0;i<books.size();i++) {
			
			JSONObject jo = new JSONObject();
			jo.put("checkin", books.get(i).getCheckin());
			jo.put("checkout", books.get(i).getCheckout());
			
			ja.put(jo);
		}

		return ja.toString();
	}
	
	
	@GetMapping("/marker")
	public String makeMarker() {
		return "markerMaking";
	}
	
	
	
	
	
//	@PostMapping("/putData")
//	@ResponseBody
//	public void getData(HttpServletRequest req) {
//		String name = req.getParameter("name");
//		String data = req.getParameter("data");
//		System.out.println(name + ":" + data);
//		
//		mjdao.addData(name, data);
//		
//	}
//	
//	@PostMapping("/deleteData")
//	@ResponseBody
//	public void deleteData(HttpServletRequest req) {
//		String name = req.getParameter("name");
//		String data = req.getParameter("data");
//		System.out.println(name + ":" + data);
//		
//		mjdao.deleteData(name, data);
//		
//	}
//	
//	
//	@PostMapping("/updateData")
//	@ResponseBody
//	public void updateData(HttpServletRequest req) {
//		String name = req.getParameter("name");
//		String data = req.getParameter("data");
//		System.out.println(name + ":" + data);
//		
//		mjdao.updateData(name, data);
//		
//	}
//	
//	
//	@PostMapping("/getData")
//	@ResponseBody
//	public String getData() {
//		
//		
//		ArrayList<mj_DTO> data = mjdao.getData();
//		
//		JSONArray ja = new JSONArray();
//		for(int i=0;i<data.size();i++) {
//			JSONObject jo = new JSONObject();
//			jo.put("name", data.get(i).getName());
//			jo.put("data", data.get(i).getData());
//			
//			ja.put(jo);
//		}
//		
//		return ja.toString();
//	}
	
	

	
	
	
	
	
	
	
}




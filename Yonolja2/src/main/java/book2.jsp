<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Calendar</title>
</head>
<style>

#room_seq{display:none;}
#calendar{border:1px solid rgb(226, 209, 209); font-weight:bold}
#calendar tr td{text-align:center}
#checkin_tb{border:1px solid black;border-collapse:collapse;}
#checkout_tb{border:1px solid black;border-collapse:collapse;}
thead tr th input{width:70px;height:40px;text-align:right;font-size:25px; border:0px solid rgb(226, 209, 209);}
#checkin_month{width:30px;}
#checkout_month{width:30px;}
thead tr th{text-align:center;font-weight:bold;}
thead tr{border-bottom:1px solid rgb(226, 209, 209)}
#checkin_tb tr td{width:40px; height:40px; text-align:center;}
#checkout_tb tr td{width:40px; height:40px; text-align:center;}

#checkin{width:120px; border:1px solid rgb(200, 209, 209); text-align:center; font-weight:bold; font-size:20px}
#checkout{width:120px; border:1px solid rgb(200, 209, 209); text-align:center; font-weight:bold; font-size:20px}
#staying{width:50px;height:50px;border:1px solid rgb(200, 209, 209);text-align:right;font-size:30px}
#calendar_reset{font-weight:bold}
#confirm{width:100px;height:50px;font-weight:bold; font-size:20px}
#cancel{width:100px;height:50px;font-weight:bold; font-size:20px}


.unava_old{color:rgb(200, 209, 209);cursor:pointer}
.unava_old:hover{background-color:rgb(225, 225, 225)}
.unava_booked{text-decoration:line-through;color:rgb(150, 150, 150);cursor:pointer}
.unava_booked:hover{background-color:rgb(225, 225, 225)}
.ava_checkin{cursor:pointer}
.ava_checkin:hover{background-color:rgb(225, 225, 225)}
.ava_checkout{cursor:pointer}
.ava_checkout:hover{background-color:rgb(225, 225, 225)}

[name=checkin_selected]{border-radius:30px 30px 30px 30px;background-color:aqua}

#guide{color:red}

</style>
<body>

<table id=calendar>
<tr><td colspan=2><input id=room_seq type=text value="${room_seq}" readonly></td></tr>
<tr> 
	<td>checkin - checkout</td> <td></td>
</tr>
<tr> 
	<td><input id=checkin type=text readonly> - <input id=checkout type=text readonly></td> 
	<td> <label id=guide></label> </td>
</tr>
<tr>
<td>
	<table id=checkin_tb>
		<thead>
			<tr> <th colspan=7>checkin</th> </tr>
			<tr> 
				<th><button id=checkin_left> < </button></th>
				<th colspan=5>
					<input id=checkin_year type=text readonly>년 <input id=checkin_month type=text readonly>월
				</th> 
				<th><button id=checkin_right> > </button></th>
			</tr>
			<tr> <th>일</th> <th>월</th> <th>화</th> <th>수</th> <th>목</th> <th>금</th> <th>토</th> </tr>
		</thead>
		<tbody>
			<tr> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> </tr>
			<tr> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> </tr>
			<tr> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> </tr>
			<tr> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> </tr>
			<tr> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> </tr>
			<tr> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> </tr>
		</tbody>
	</table>
</td>

<td>
	<table id=checkout_tb>
		<thead>
			<tr> <th colspan=7>checkout</th> </tr>
			<tr> 
				<th><button id=checkout_left> < </button></th>
				<th colspan=5>
					<input id=checkout_year type=text readonly>년 <input id=checkout_month type=text readonly>월
				</th>
				<th><button id=checkout_right> > </button></th> 
			</tr>
			<tr> <th>일</th> <th>월</th> <th>화</th> <th>수</th> <th>목</th> <th>금</th> <th>토</th> </tr>
		</thead>
		<tbody>
			<tr> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> </tr>
			<tr> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> </tr>
			<tr> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> </tr>
			<tr> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> </tr>
			<tr> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> </tr>
			<tr> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> </tr>
		</tbody>
	</table>
</td>
</tr>
<tr> 
	<td></td> 
	<td style="text-align:right">
		<button id=calendar_reset>달력 초기화</button> &nbsp; 
	</td> 
</tr>
<tr>
	<td colspan=2>
		<button id=confirm>결정하기</button>
		<button id=cancel>취소</button> &nbsp; 
	</td> 
</tr>
</table>

</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>

function InitializeCalendar(){
//	오늘날짜를 기준으로 맨처음에 checkin calendar 와 checkout calendar 를 initialize 하는 function
//  그냥 input 에 숫자 넣어주는 function임 
	var today = new Date();
	today_year = today.getFullYear();
	today_month = today.getMonth()+1;
	$('#checkin_year').val(today_year);
	$('#checkin_month').val(today_month);
	
	var tomorrow = today.setDate(today.getDate()+1);
	tomorrow = new Date(tomorrow);
	tomorrow_year = tomorrow.getFullYear();
	tomorrow_month = tomorrow.getMonth()+1;
	$('#checkout_year').val(tomorrow_year);
	$('#checkout_month').val(tomorrow_month);
}

function FillCheckin(){
// 	refresh 도 해주어야함. .removeClass() 하면 그 tag 가 가진 모든 class 를 삭제할 수 있음.
	$('#checkin_tb tr td').empty();
	$('#checkin_tb tr td').removeClass();
	$('#checkin_tb tr td').attr('name',''); 
//	checkin 에 적힌 year / month 를 기준으로 날짜들을 생성해주는 function
//	이번달을 기준으로 만들경우, 오늘이상의 날짜들을 생성해야함.
// 	이번달이 아닌 다음달부터일경우, 걍 다만들어두됨.


	var today = new Date();
	today_year = today.getFullYear();
	today_month = today.getMonth()+1;
	
	calendar_year = $('#checkin_year').val()
	calendar_month = $('#checkin_month').val()
	
	// 그냥 생성. 클래스 부여는 다른함수가 알아서 할거임 
	time = new Date(calendar_year, calendar_month-1, 1)
	td_start_index = time.getDay()
	
	for(i=td_start_index;i<$('#checkin_tb tbody tr td').length;i++){
		date = time.getDate()
		$('#checkin_tb tbody tr td:eq('+i+')').text(date)
		time.setDate(time.getDate()+1)
		if(time.getMonth()+1 != calendar_month){break;}
	}
	
	
//  까먹은건데, 그리고 checkin 을 이미 정해놓았을경우, 그 checkin_date 을 유지해야함. 
	if($('#checkin').val()!=''){
		for(i=0;i<$('#checkin_tb tbody tr td').length;i++){
			calendar_date = $('#checkin_tb tbody tr td:eq('+i+')').text();
			calendar_str = calendar_year + "-" + calendar_month + "-" + calendar_date;
	
			if(calendar_str == $('#checkin').val() ){
				$('#checkin_tb tbody tr td:eq('+i+')').attr('name','checkin_selected');
			}
		}
	}	
	
}

function CheckinClassSort(){
//	그 room을 기준으로 그 날짜들중에서 이미 예약이 된 날짜, 즉 체크인으로 고르는것이 불가능한 날짜들을 sort(제거) 해주는 function
//	calendar 의 year과 month가 이번달일경우, 오늘 이전의 날짜들에 unava_old class 를 부여. 날짜를 하얀색?회색으로 표시
//	database 에서 가져와서 체크인설정이 불가능한 날짜들은 unava_checkin_booked class를 부여. 글자에 line-through 적용
	
	var today = new Date();
	today_year = today.getFullYear();
	today_month = today.getMonth()+1;
	today_date = today.getDate();
	
	calendar_year = $('#checkin_year').val();
	calendar_month = $('#checkin_month').val();
	
	if(calendar_year==today_year && calendar_month==today_month ){
		// 오늘날짜의 달력을 표시할경우 : 오늘이전날짜 회색처리, db에서 예약불가능한 날짜들 줄긋기 처리 
		
		// 1. 오늘이전날짜에 unava_old class 부여해서 회색처리 
		today_flag = 0;
		today_str = today_year + "-" + today_month + "-" + today_date
		for(i=0;i<$('#checkin_tb tbody tr td').length;i++){
			calendar_date = $('#checkin_tb tbody tr td:eq('+i+')').text();
			calendar_str = calendar_year + "-" + calendar_month + "-" + calendar_date;
			if(calendar_str==today_str){today_flag=1;}
			if(today_flag==0 && calendar_date!=''){
				$('#checkin_tb tbody tr td:eq('+i+')').attr('class','unava_old');
			}
		}
		
		// 2. db에서 예약불가능한 날짜들 줄긋기 처리. 
		//    ajax 로 db에서 그 room 의 예약내역에서 모든checkin, checkout을 가져옴
		
		$.ajax({url:'/get_room_books', type:'post', dataType:'json', 
			
			data:{room_seq:$('#room_seq').val()},
			success:function(data){
				
				booked_dates = []
				for(i=0;i<data.length;i++){
					checkin = data[i].checkin;
					checkout = data[i].checkout;
					time = new Date(checkin)
					time_str = ''
					while(time_str!=checkout){
						time_year = time.getFullYear();
						time_month = time.getMonth()+1;
						time_date = time.getDate();
						
						time_str = time_year + "-" + time_month + "-" + time_date
						if(time_str==checkout){break;}
						else{
							if(!booked_dates.includes(time_str)){ booked_dates.push(time_str); }
							time.setDate(time.getDate()+1);
						}
					}
				}
				
				
				
				// booked_dates 와 일치하는 날짜들에 unava_booked class 를 부여.
				for(i=0;i<$('#checkin_tb tbody tr td').length;i++){
					
					calendar_year = $('#checkin_year').val();
					calendar_month = $('#checkin_month').val();
					calendar_date = $('#checkin_tb tbody tr td:eq('+i+')').text();
					calendar_str = calendar_year + "-" + calendar_month + "-" + calendar_date;
					for(j=0;j<booked_dates.length;j++){
						if(calendar_str==booked_dates[j]){
							$('#checkin_tb tbody tr td:eq('+i+')').attr('class','unava_booked')
							break;
						}
					}
				}
				
				
			},
			complete:function(){
				// 성공시, calendar 에서 class 를 부여받지 않은 td(그중에서도 글자가 있는애들만)를 선택가능한 class인
				// ava_checkin 로 등록.
				for(i=0;i<$('#checkin_tb tbody tr td').length;i++){
					cls = $('#checkin_tb tbody tr td:eq('+i+')').attr('class')
					txt = $('#checkin_tb tbody tr td:eq('+i+')').text()
					if(cls!='unava_old' && cls!='unava_booked' && txt!='' ){
						$('#checkin_tb tbody tr td:eq('+i+')').attr('class','ava_checkin');
					}
				}
				
			}
		
		})
		
		
	} else {
		
		// 2. db에서 예약불가능한 날짜들 줄긋기 처리. 
		//    ajax 로 db에서 그 room 의 예약내역에서 모든checkin, checkout을 가져옴
		
		$.ajax({url:'/get_room_books', type:'post', dataType:'json', 
			
			data:{room_seq:$('#room_seq').val()},
			success:function(data){
				
				booked_dates = []
				for(i=0;i<data.length;i++){
					checkin = data[i].checkin;
					checkout = data[i].checkout;
					time = new Date(checkin)
					time_str = ''
					while(time_str!=checkout){
						time_year = time.getFullYear();
						time_month = time.getMonth()+1;
						time_date = time.getDate();
						
						time_str = time_year + "-" + time_month + "-" + time_date
						if(time_str==checkout){break;}
						else{
							if(!booked_dates.includes(time_str)){ booked_dates.push(time_str); }
							time.setDate(time.getDate()+1);
						}
					}
				}
				
				
				
				// booked_dates 와 일치하는 날짜들에 unava_booked class 를 부여.
				for(i=0;i<$('#checkin_tb tbody tr td').length;i++){
					
					calendar_year = $('#checkin_year').val();
					calendar_month = $('#checkin_month').val();
					calendar_date = $('#checkin_tb tbody tr td:eq('+i+')').text();
					calendar_str = calendar_year + "-" + calendar_month + "-" + calendar_date;
					for(j=0;j<booked_dates.length;j++){
						if(calendar_str==booked_dates[j]){
							$('#checkin_tb tbody tr td:eq('+i+')').attr('class','unava_booked')
							break;
						}
					}
				}
				
				
			},
			complete:function(){
				// 성공시, calendar 에서 class 를 부여받지 않은 td(그중에서도 글자가 있는애들만)를 선택가능한 class인
				// ava_checkin 로 등록.
				for(i=0;i<$('#checkin_tb tbody tr td').length;i++){
					cls = $('#checkin_tb tbody tr td:eq('+i+')').attr('class')
					txt = $('#checkin_tb tbody tr td:eq('+i+')').text()
					if(cls!='unava_old' && cls!='unava_booked' && txt!='' ){
						$('#checkin_tb tbody tr td:eq('+i+')').attr('class','ava_checkin');
					}
				}
				
			}
		
		})
	}
}
// 여기부터는 checkout calendar 에 대한 작업.

function FillCheckOut(){
	
//	그냥 다른거 신경안쓰고 철저하게 checkout_year, checkout_month 를 기준으로 그 달 달력 날짜만 채우면 됨. 자기할일만.

	$('#checkout_tb tbody tr td').empty();
	$('#checkout_tb tbody tr td').removeClass();
	$('#checkout_tb tbody tr td').attr('name','');
	
	calendar_year = $('#checkout_year').val();
	calendar_month = $('#checkout_month').val();
	calendar_str = calendar_year + "-" + calendar_month + "-" + 1;
	
	time = new Date(calendar_str);
	td_start_index = time.getDay();
	
	for(i=td_start_index;i<$('#checkout_tb tr td').length;i++){
		
		date = time.getDate();
		$('#checkout_tb tr td:eq('+i+')').text(date);
		time.setDate(time.getDate()+1);
		if(time.getMonth()+1 != calendar_month){break;}
		
	}

}

function CheckoutClassSort(){
	
/*
	일단 생각좀해보자.	
	
	1. 체크인이 없을때, 내일 이전날짜들 다 unava_old 처리해야함.
	   그리고 db 에서 예약된날짜들(예약날짜+체크아웃날짜들) 전부 unava_booked 처리해야함
	
	2. 체크인이 있을때, 위의 조건    체크인결정날짜 + 가장 가까운 예약불가능한날짜 범위내에만 표시하고, 그 뒤부터는
	   전부 unava_after 로 처리해서 예약불가능하게 해야함.
*/	
	
	if($('#checkin').val()==''){ 
		
		// 체크인을 아직 고르지 않았을경우. - 내일달력일경우 / 내일달력이 아닐경우로 나뉨.
		tomorrow = new Date();
		tomorrow.setDate(tomorrow.getDate()+1);
		
		tomorrow_year = tomorrow.getFullYear();
		tomorrow_month = tomorrow.getMonth()+1;
		tomorrow_date = tomorrow.getDate();
		
		tomorrow_str = tomorrow_year + "-" + tomorrow_month + "-" + tomorrow_date;
		
		calendar_year = $('#checkout_year').val();
		calendar_month = $('#checkout_month').val();
		
		if( calendar_year==tomorrow_year && calendar_month==tomorrow_month ){	// 내일달력일경우

			// 근데 문득 드는 생각인데 이거 코드 줄일수있을듯. 그냥 if문 그대로두고 else 는 따로안하고 알아서
			// db에서 그 방에 대한 예약내역들 불러와서 제거하게 하면될듯? 모르겠고 일단 계획대로 해보고 줄이는건 나중에 실험 ㄱ
			
			// 1. 내일 이전의 날짜들은 모두 unava_old class 부여.
			tomorrow_flag = 0;
			for(i=0;i<$('#checkout_tb tbody tr td').length;i++){
				calendar_date = $('#checkout_tb tbody tr td:eq('+i+')').text();
				calendar_str = calendar_year + "-" + calendar_month + "-" + calendar_date;
				if(calendar_str==tomorrow_str){tomorrow_flag=1;}
				if(tomorrow_flag==0 && calendar_date!=''){
					$('#checkout_tb tbody tr td:eq('+i+')').attr('class','unava_old');
				}
			}
			
			// 2. DB 에서 그 방에대한 checkin, checkout 내역을 불러와서, 체크아웃 예약 불가능한 날짜들에 unava_booked class 부여
			
			$.ajax({url:'/get_room_books', type:'post', dataType:'json', 
				
				data:{room_seq:$('#room_seq').val()},
				
				success:function(data){
				
					booked_dates = [];
					
					for(i=0;i<data.length;i++){
						
						checkin = data[i].checkin;
						checkout = data[i].checkout;
						
						time = new Date(checkin);
						time_str = '';
						while(time_str != checkout){
			
							// 체크인날짜 제외, 그 다음날~체크아웃까지 포함시켜야함.
							time.setDate(time.getDate()+1);
							
							time_year = time.getFullYear();
							time_month = time.getMonth()+1;
							time_date = time.getDate();
							
							time_str = time_year + "-" + time_month + "-" + time_date;
							if(!booked_dates.includes(time_str)){
								booked_dates.push(time_str);
							}
						}
					}
					
					console.log(booked_dates);
					// 이렇게하면 그 room 에 대해서 체크아웃 불가능한 날짜들이 array 에 모여짐. 얘네들 기준으로
					// calendar 에서 checkout 불가능한 날짜 고르면 됨.
					// 아직 checkin 은 없는상태니깐 가까운날짜 골라서 없애는게 아니라 그냥 체크아웃불가능한날짜만
					// unava_booked class 부여하면 됨.
					for(i=0; i<$('#checkout_tb tbody tr td').length ;i++){
						calendar_date = $('#checkout_tb tbody tr td:eq('+i+')').text();
						calendar_str = calendar_year + "-" + calendar_month + "-" + calendar_date;
						for(j=0; j<booked_dates.length; j++){
							if(calendar_str==booked_dates[j]){
								$('#checkout_tb tbody tr td:eq('+i+')').attr('class','unava_booked'); break;
							}
						}
					}
					
				},
				complete:function(){
					// class 속성이 부여되지 않은 날짜들만 ava_checkout class 부여하기 
					
					for(i=0;i<$('#checkout_tb tbody tr td').length;i++){
						cls = $('#checkout_tb tbody tr td:eq('+i+')').attr('class');
						txt = $('#checkout_tb tbody tr td:eq('+i+')').text();
						if(cls!='unava_old' && cls!='unava_booked' && cls!='unava_after' && txt!='' ){
							$('#checkout_tb tbody tr td:eq('+i+')').attr('class','ava_checkout');
						}
					}
				}
				
				
				
			})
			
			
		} else { // 내일달력이 아닌경우(내일달력이 아닐 수 있음. 넘기기해서 사용자가 아니게 만들 수 있으니깐)
			
			// 일단 체크인 안고른상태니깐 그냥 다 표시하고, 그중에서 db에 담긴 예약불가능한 날짜들만 삭제하면됨.
				$.ajax({url:'/get_room_books', type:'post', dataType:'json', 
				
				data:{room_seq:$('#room_seq').val()},
				
				success:function(data){
				
					booked_dates = [];
					
					for(i=0;i<data.length;i++){
						
						checkin = data[i].checkin;
						checkout = data[i].checkout;
						
						time = new Date(checkin);
						time_str = '';
						while(time_str != checkout){
			
							// 체크인날짜 제외, 그 다음날~체크아웃까지 포함시켜야함.
							time.setDate(time.getDate()+1);
							
							time_year = time.getFullYear();
							time_month = time.getMonth()+1;
							time_date = time.getDate();
							
							time_str = time_year + "-" + time_month + "-" + time_date;
							if(!booked_dates.includes(time_str)){
								booked_dates.push(time_str);
							}
						}
					}
					
					console.log(booked_dates);
					// 이렇게하면 그 room 에 대해서 체크아웃 불가능한 날짜들이 array 에 모여짐. 얘네들 기준으로
					// calendar 에서 checkout 불가능한 날짜 고르면 됨.
					// 아직 checkin 은 없는상태니깐 가까운날짜 골라서 없애는게 아니라 그냥 체크아웃불가능한날짜만
					// unava_booked class 부여하면 됨.
					for(i=0; i<$('#checkout_tb tbody tr td').length ;i++){
						calendar_date = $('#checkout_tb tbody tr td:eq('+i+')').text();
						calendar_str = calendar_year + "-" + calendar_month + "-" + calendar_date;
						for(j=0; j<booked_dates.length; j++){
							if(calendar_str==booked_dates[j]){
								$('#checkout_tb tbody tr td:eq('+i+')').attr('class','unava_booked'); break;
							}
						}
					}
					
				},
				complete:function(){
					// class 속성이 부여되지 않은 날짜들만 ava_checkout class 부여하기 
					
					for(i=0;i<$('#checkout_tb tbody tr td').length;i++){
						cls = $('#checkout_tb tbody tr td:eq('+i+')').attr('class');
						txt = $('#checkout_tb tbody tr td:eq('+i+')').text();
						if(cls!='unava_old' && cls!='unava_booked' && cls!='unava_after' && txt!='' ){
							$('#checkout_tb tbody tr td:eq('+i+')').attr('class','ava_checkout');
						}
					}
				}
			})
			
		}
		
		
	} else { // 체크인을 고른상태 
		
		
		// 체크인다음날 달력이라면, 
		// 1. 체크인다음날 이전날들은 모두 unava_old class 부여해야함.
		// 2. 그리고나서 db 에서 예약날짜들을 가져와서 체크인다음날 이후의 가장가까운 예약불가능한 날짜를 구해서, 
		//    그 날짜 이후로 나오는 모든날들은 unava_after class 를 부여해서 체크아웃 예약불가능하게 해야함.
		
		// 체크인다음날이 나타나지 않은 달력일경우, 
		// 1. 만약에 체크인과 가장 가까운 예약불가능한날짜가 체크인다음날이 나타난 달력에 존재한다면, 전부 unava_after 처리
		// 2. 만약에 체크인과 가장 가까운 예약불가능한날짜가 현재 달력에 존재한다면, 
		//	  그 예약불가능한 날짜 이전날들은 ava_checkout 처리하고, 예약불가능한 날짜 이상의 날들은 unava_after 처리
		// 3. 만약에 체크인과 가장 가까운 예약불가능한 날짜가 현재 달력에 없고 더 뒤에있거나 영원히 존재하지 않는다면, 
		// 	  모든 달력의 날들은 ava_checkout 처리.
		
		
		// 흠.. 일단 체크인다음날 이전날들을 모두 unava_old class 부여하는건 할 수 있을거같음
		
		// 그리고 가장 가까운 예약불가능한 날짜 구하는건...
		
		// 조금 더 생각해봐야할듯 
		
		
		
	}
	
	
	
	
}


InitializeCalendar()
FillCheckin()
CheckinClassSort()
FillCheckOut()
CheckoutClassSort()
/*

	설계 :
	
	방 예약(체크인,체크아웃버튼) 클릭시 달력페이지로 들어옴
	
	<체크인>
		1. ready(function(){}) 으로 오늘, 이번달에대한 달력을 형성. 일단 모양만 잡기
		2. 달력을 형성하고나서 그 room 에 대한 불가능한 날짜들 제거처리
		
		1. 달력을 넘길 때, 넘긴 달에 대한 달력을 형성. 일단 모양만 잡기
		2. 달력을 형성하고 나서 그 room 에 대한 불가능한 날짜들 제거처리
		
	
	<체크아웃>
		1. 체크인 날짜 고름.
		
		2. 체크인날짜 이후를 기준으로 달력 형성. 일단 모양만 잡기
		3. 체크인날 바로 다음날 - 불가능한 날짜  범위에서만 체크아웃 범위 설정 가능.
		
		2. 달력을 넘길 때, 넘긴 달에 대한 달력을 형성. 일단 모양만 잡기
		3. 체크인 바로 다음날 - 불가능한날짜 범위에서만 체크아웃 범위 설정가능. 만약 불가능한 날짜가 없다면 그 이후에는 다 설정가능.
		 - 아니면 불가능한 날짜 이후에도 클릭은 가능하지만 실제 예약은 안되는걸로. 	
	
		4. 불가능한 날짜가 달력에 없는 날일 수 있음.
			0. 5월25일부터 5월31일까지 예약하려고하는데, 불가능한 날짜가 5월29일임 --> 5월29일 이후로 다 막아놓아야함.
			1. 5월29일부터 예약하려고하는데, 불가능한 날짜가 6월3일임.   ---> 6월3일 이후로 다 막아놓아야함.
			>> 불가능한 날짜가 나온 달 다음달들은 모두 막아놓아야함.
			
			** 가장 가까이 존재하는 불가능한 날짜를 구해놓고 fix하는게 중요할듯. fix는 필수는 아님.
			
(체크아웃시 불가능한 날짜 이후라서 예약 불가능한날짜들) > unava_after
(오늘 이전날짜라서/체크인 이전날짜라서 예약불가능날짜들) > unava_old
		    이미예약이 잡혀서 불가능한 방 class > unava_booked
			      	   예약가능한 방 class > checkin_ava
      	   
	
	필요한 function 들 
	
	1. 오늘날짜를 기준으로 맨처음에 checkin calendar 와 checkout calendar 를 initialize 하는 function
	2. checkin 에 적힌 year / month 를 기준으로 날짜들을 생성해주는 function
	3. 그 room을 기준으로 그 날짜들중에서 이미 예약이 된 날짜, 즉 체크인으로 고르는것이 불가능한 날짜들을 sort(제거) 해주는 function 

	4. checkin 날짜를 결정시 checkout calendar 를 풀어주는 function
	5. 결정된 checkin 날짜/checkout year,month 에 적힌 년,월 을 기준으로 그 다음날부터 checkout 날짜들을(달력을) 생성해주는 function
	6. 그 room을 기준으로 생성된 날짜들중에 가장 근처에 존재하는 체크아웃 불가능한 날짜를 골라 그 전까지만 체크아웃설정 가능하도록
	   표시해주는 function 
			      	   
*/		

$(document)
.on('click','#checkin_right',function(){
	
	calendar_year = $('#checkin_year').val();
	calendar_month = $('#checkin_month').val();
	calendar_date = 1;
	calendar_str = calendar_year + "-" + calendar_month + "-" + calendar_date;
	calendar_time = new Date(calendar_str);
	
	calendar_time.setMonth( calendar_time.getMonth()+1 );
	
	$('#checkin_year').val(calendar_time.getFullYear());
	$('#checkin_month').val(calendar_time.getMonth()+1);
	
	FillCheckin();
	CheckinClassSort();
})
.on('click','#checkin_left',function(){
	
	// 왼쪽으로 가는건 이번달보다 왼쪽으로 못가게해야함.
	today = new Date();
	today_year = today.getFullYear();
	today_month = today.getMonth()+1;
	today_date = today.getDate();
	
	calendar_year = $('#checkin_year').val();
	calendar_month = $('#checkin_month').val();
	calendar_date = 1;
	calendar_str = calendar_year + "-" + calendar_month + "-" + calendar_date;
	calendar_time = new Date(calendar_str);
	
	if(today_year==calendar_year && today_month==calendar_month){ return false; }
	
	calendar_time.setMonth( calendar_time.getMonth()-1 );
	
	$('#checkin_year').val(calendar_time.getFullYear());
	$('#checkin_month').val(calendar_time.getMonth()+1);
	
	FillCheckin();
	CheckinClassSort();
})

.on('click','.ava_checkin',function(){
	// 방금 난 생각인데, 찍어서 동그라미표시하는거 일단 td에 테두리표시하게하고, border-radius 로 하면 될듯?
			
	// 일단 checkin_selected 가 있으면 제거
	$('#checkin_tb tbody tr td').attr('name','');
	$(this).attr('name','checkin_selected');
	
	year = $('#checkin_year').val();
	month = $('#checkin_month').val();
	date = $(this).text();
	
	selected_date = year + "-" + month + "-" + date;
	$('#checkin').val(selected_date);
	
	// 그리고나서 checkout 을 checkin날짜 기준으로 initialize 하는 function 을 실행시켜야함. !!!!!!
	theNextDay = new Date(selected_date);
	theNextDay.setDate(theNextDay.getDate()+1);
	
	theNextDay_year = theNextDay.getFullYear();
	theNextDay_month = theNextDay.getMonth()+1;
	
	$('#checkout_year').val(theNextDay_year);
	$('#checkout_month').val(theNextDay_month);
	
	FillCheckOut();
	CheckoutClassSort();
})		
	
// 여기부터는 checkout calendar control 	
.on('click','#checkout_left',function(){
	
	// 내일이 최솟값이니깐, 현재 checkout_year, checkout_month 가 내일이면 더 왼쪽으로 가지못함.
	// 하지만 그게 아니라면 checkout_year, checkout_month 에 새 값을 부여하고 다시 FillCheckOut(); 하고 CheckoutClassSort(); 하면됨
	
	// 그리고 checkin 이 있으면, 그때는 최솟값이 또 checkin의 다음날 기준으로 최솟값을 잡아야 함.
	if($('#checkin').val()==''){
		tomorrow = new Date();
		tomorrow.setDate(tomorrow.getDate()+1);
		
		tomorrow_year = tomorrow.getFullYear();
		tomorrow_month = tomorrow.getMonth()+1;
		tomorrow_date = tomorrow.getDate();
		
		calendar_year = $('#checkout_year').val();
		calendar_month = $('#checkout_month').val();
		calendar_date = 1;
		calendar_str = calendar_year + "-" + calendar_month + "-" + calendar_date;
		
		if(calendar_year==tomorrow_year && calendar_month==tomorrow_month){return false;}
		
		calendar_time = new Date(calendar_str);
		calendar_time.setMonth(calendar_time.getMonth()-1);
		
		$('#checkout_year').val( calendar_time.getFullYear() );
		$('#checkout_month').val( calendar_time.getMonth()+1 );
		
	} else {
		
		checkin_nextDay = new Date( $('#checkin').val() );
		checkin_nextDay.setDate(checkin_nextDay.getDate()+1);
		
		checkin_nextDay_year = checkin_nextDay.getFullYear();
		checkin_nextDay_month = checkin_nextDay.getMonth()+1;
		checkin_nextDay_date = checkin_nextDay.getDate();
		
		calendar_year = $('#checkout_year').val();
		calendar_month = $('#checkout_month').val();
		calendar_date = 1;
		calendar_str = calendar_year + "-" + calendar_month + "-" + calendar_date;
		
		if(calendar_year==checkin_nextDay_year && calendar_month==checkin_nextDay_month){return false;}
		
		calendar_time = new Date(calendar_str);
		calendar_time.setMonth(calendar_time.getMonth()-1);
		
		$('#checkout_year').val( calendar_time.getFullYear() );
		$('#checkout_month').val( calendar_time.getMonth()+1 );
	}
	
	FillCheckOut();
	CheckoutClassSort();
	
})
.on('click','#checkout_right',function(){
	
	// 내일이 최솟값이니깐, 현재 checkout_year, checkout_month 가 내일이면 더 왼쪽으로 가지못함.
	// 하지만 그게 아니라면 checkout_year, checkout_month 에 새 값을 부여하고 다시 FillCheckOut(); 하고 CheckoutClassSort(); 하면됨
	
	calendar_year = $('#checkout_year').val();
	calendar_month = $('#checkout_month').val();
	calendar_date = 1;
	calendar_str = calendar_year + "-" + calendar_month + "-" + calendar_date;
	
	calendar_time = new Date(calendar_str);
	calendar_time.setMonth(calendar_time.getMonth()+1);
	
	$('#checkout_year').val( calendar_time.getFullYear() );
	$('#checkout_month').val( calendar_time.getMonth()+1 );
	
	FillCheckOut();
	CheckoutClassSort();
})

.on('click','.ava_checkout',function(){
	
	if($('#checkin').val()==''){
		$('#guide').text('체크인날짜를 먼저 정해주세요.')
		setTimeout(function(){$('#guide').text('');},1000)
		return false;
	} else {
		
		
		
		
		
	}
	
})
</script>
</html>



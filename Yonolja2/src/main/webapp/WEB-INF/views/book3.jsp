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
#checkin_checkout{border:1px solid grey}
#calendar{border:1px solid black;border-collapse:collapse;text-align:center;font-weight:bold;}
#calendar td{height:40px;width:40px}
#calendar_year{height:30px;width:60px;border:0px;text-align:right;font-size:25px;}
#calendar_month{height:30px;width:30px;border:0px;text-align:right;font-size:25px;}
#status{border-bottom:1px solid black;font-size:20px;height:40px}
#time{font-size:20px;height:60px;text-align:center}
#calendar tfoot{border-top:1px solid black;}
#inputs{font-weight:bold;}
#inputs input{width:80px;}
#inputs td{height:30px;}

.unava_old{color:rgb(200, 209, 209);cursor:pointer}
.unava_old:hover{background-color:rgb(225, 225, 225)}
.unava_booked{text-decoration:line-through;text-decoration-thickness:2px;cursor:pointer;color:rgb(200, 209, 209);}
.unava_booked:hover{background-color:rgb(225, 225, 225)}
.unava_after{color:rgb(200, 209, 209);cursor:pointer}
.unava_after:hover{background-color:rgb(225, 225, 225)}
.ava{cursor:pointer; color:black;}
.ava:hover{background-color:rgb(225, 225, 225)}

[name=checkin_selected]{border:0.5px solid black;text-decoration:none;color:black;}
[name=checkout_selected]{border:0.5px solid black;text-decoration:none;color:black;}
.selected_dates{background-color:rgb(225, 225, 225)}


</style>
<body>

<table id=checkin_checkout>
<tr>
	<td>
		<table id=calendar>
				<thead>
					<tr id=status> <th colspan=7>체크인 날짜 선택</th> </tr>
					<tr id=time> 
						<th><button id=calendar_left> < </button></th>
						<th colspan=5>
							<input id=calendar_year type=text readonly>년 <input id=calendar_month type=text readonly>월
						</th> 
						<th><button id=calendar_right> > </button></th>
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
		<table id=inputs>
			<tr> <td colspan=2 style="border-bottom:1px solid black"> 예약정보 </td> </tr>
			<tr> <td>room</td> <td><input id=room_seq type=text value="${room_seq}" readonly></td> </tr>
			<tr> <td>체크인</td> <td><input id=checkin type=text readonly> 부터</td> </tr>
			<tr> <td>체크아웃</td> <td><input id=checkout type=text readonly> 까지</td> </tr>
			<tr> <td>기간</td> <td><input id=stay type=text readonly> 박</td> </tr>
			<tr> <td>가격</td> <td><input id=price type=number readonly> 원</td> </tr>
			<tr> <td></td> <td></td> </tr>
			<tr> <td colspan=2> <button id=calendar_reset>다시 고르기</button> </td> </tr>
			<tr> <td><button id=decide>결정하기</button></td> <td><button id=cancel>나가기</button></td> </tr>
		</table>
	</td>
	
	
</tr>
</table>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
// 이번엔 진짜 깔끔하게 airbnb 처럼 만들어보기.
// 오늘날짜를 기준으로 2개월짜리 달력만들기. 아니면 한개짜리도 상관없음. 일단 한개만 해보자.
// 체크인 없을때 / 체크인만있을때 이렇게 나누어서 하면 됨.
// 달력 오늘기준으로 만들고, 이번엔 날짜비교를 위주로 해서 해보기 
function InitializeCalendar(){
	today = new Date();
	
	today_year = today.getFullYear();
	today_month = today.getMonth()+1;
	
	$('#calendar_year').val(today_year);
	$('#calendar_month').val(today_month);

}
function FillCalendar(){
	
	$('#calendar tbody tr td').empty();
	
	calendar_time_str = $('#calendar_year').val() + "-" + $('#calendar_month').val() + "-" + 1;
	calendar_time = new Date(calendar_time_str);
	
	calendar_start_index = calendar_time.getDay();
	
	
	
	for(i=calendar_start_index ; i<$('#calendar tbody tr td').length;i++){
		
		date = calendar_time.getDate();
		$('#calendar tbody tr td:eq('+i+')').text(date);
		calendar_time.setDate(date+1);
		if(calendar_time.getMonth()+1 != $('#calendar_month').val()){break;}
	}
}

function SortCalendar(){
	
	$('#calendar tbody tr td').removeClass(); // 클래스 부여 초기화
	$('#calendar tbody tr td').attr('name',null);
	
	
	// 달력넘어갔을때 checkin / checkout 유지 
	if( $('#checkin').val()!=''){
		for(i=0;i<$('#calendar tbody tr td').length;i++){
			calendar_year = $('#calendar_year').val();
			calendar_month = $('#calendar_month').val();
			calendar_date = $('#calendar tbody tr td:eq('+i+')').text();
			calendar_str = calendar_year + "-" + calendar_month + "-" + calendar_date;
			
			if(calendar_str == $('#checkin').val() ){
				$('#calendar tbody tr td:eq('+i+')').attr('name','checkin_selected');
			}
		}
	}
	if( $('#checkout').val()!=''){
		for(i=0;i<$('#calendar tbody tr td').length;i++){
			calendar_year = $('#calendar_year').val();
			calendar_month = $('#calendar_month').val();
			calendar_date = $('#calendar tbody tr td:eq('+i+')').text();
			calendar_str = calendar_year + "-" + calendar_month + "-" + calendar_date;
			
			if(calendar_str == $('#checkout').val() ){
				$('#calendar tbody tr td:eq('+i+')').attr('name','checkout_selected');
			}
		}	
	}
	
	
	
	// 일단 체크인이 있건 없건, 오늘날짜의 이전날들은 모두 unava_old class 처리해야함.
	today = new Date();
	today_year = today.getFullYear();
	today_month = today.getMonth()+1;
	today_date = today.getDate();
	today_str = today_year + "-" + today_month + "-" + today_date;
	today = new Date(today_str);
	
	calendar_year = $('#calendar_year').val();
	calendar_month = $('#calendar_month').val();
	
	for(i=0; i<$('#calendar tbody tr td').length; i++){
		calendar_date = $('#calendar tbody tr td:eq('+i+')').text();
		if(calendar_date!=''){
			calendar_time = new Date(calendar_year + "-" + calendar_month + "-" + calendar_date);
			if(calendar_time<today){
				$('#calendar tbody tr td:eq('+i+')').attr('class','unava_old');
			}
		}
	}
	
	// 체크인이 있건, 없건, 체크인, 체크아웃 사이의 풀로 예약된 날짜들은 unava_booked class 처리해야함.
	//   - 그중 체크인이 없으면, 체크인 날짜들을 unava_booked class 처리해야하고,
	//   - 그 중 체크인이 있으면, 체크아웃 날짜들을 unava_booked class 처리해야함.
	booked_checkins = []
	booked_dates = []
	booked_checkouts = []
	
	$.ajax({url:'/get_room_books', type:'post', dataType:'json', 
		
		data:{room_seq:$('#room_seq').val()},
		success:function(data){
			for(i=0;i<data.length;i++){
				booked_checkins.push( data[i].checkin );
				booked_checkouts.push( data[i].checkout );
				checkin_time = new Date(data[i].checkin);
				checkout_time = new Date(data[i].checkout);
				booked_str = ''
				while(booked_str != data[i].checkout ){
					checkin_time.setDate(checkin_time.getDate()+1);
//					if(checkin_time==checkout_time){break;}
					booked_year = checkin_time.getFullYear();
					booked_month = checkin_time.getMonth()+1;
					booked_date = checkin_time.getDate();
					booked_str = booked_year + "-" + booked_month + "-" + booked_date;
					if(booked_str == data[i].checkout){break;}
					booked_dates.push(booked_str);
				}
			}
		}, 
		complete:function(){
			
			for(i=0;i<$('#calendar tbody tr td').length;i++){
				
				calendar_year = $('#calendar_year').val();
				calendar_month = $('#calendar_month').val();
				calendar_date = $('#calendar tbody tr td:eq('+i+')').text();
				calendar_str = calendar_year + "-" + calendar_month + "-" + calendar_date;
				
				if(booked_dates.includes(calendar_str)){
					$('#calendar tbody tr td:eq('+i+')').attr('class','unava_booked');
				}
			}
			
			console.log(booked_checkins)
			console.log(booked_checkouts)
			console.log(booked_dates)
			
			// 체크인이 설정되어있지 않을 때 
			if( $('#checkin').val()=='' ){

				for(i=0;i<$('#calendar tbody tr td').length;i++){
					calendar_year = $('#calendar_year').val();
					calendar_month = $('#calendar_month').val();
					calendar_date = $('#calendar tbody tr td:eq('+i+')').text();
					calendar_str = calendar_year + "-" + calendar_month + "-" + calendar_date;
					
					if(booked_checkins.includes(calendar_str)){
						$('#calendar tbody tr td:eq('+i+')').attr('class','unava_booked');
					}
				}
				
				
				
			}
			
			// 체크인이 설정되어있을 때
			else {
				
				
				// 체크아웃불가능 날짜들 들고와서 막아놓음
				for(i=0;i<$('#calendar tbody tr td').length;i++){
					calendar_year = $('#calendar_year').val();
					calendar_month = $('#calendar_month').val();
					calendar_date = $('#calendar tbody tr td:eq('+i+')').text();
					calendar_str = calendar_year + "-" + calendar_month + "-" + calendar_date;
					
					if(booked_checkouts.includes(calendar_str)){
						$('#calendar tbody tr td:eq('+i+')').attr('class','unava_booked');
					}
				}

				// 체크인포함 이전날짜들 모두 unava_old 처리해야함.
				checkin_time = new Date( $('#checkin').val() );
				for(i=0;i<$('#calendar tbody tr td').length;i++){
					calendar_year = $('#calendar_year').val();
					calendar_month = $('#calendar_month').val();
					calendar_date = $('#calendar tbody tr td:eq('+i+')').text();
					calendar_str = calendar_year + "-" + calendar_month + "-" + calendar_date;
					
					calendar_time = new Date( calendar_str );
					
					if(calendar_time < checkin_time && 
						$('#calendar tbody tr td:eq('+i+')').attr('class')!='unava_booked') 
					{
						$('#calendar tbody tr td:eq('+i+')').attr('class','unava_old');
					}
				}	
			
				// 그리고 선택된 체크인날짜와 가장 가까운 체크아웃 불가능한 날짜(예약일)--> booked dates에서 찾아야할듯
				// 를 찾아서, 만약 booked_dates 에 체크인날짜보다 큰 날짜가 존재하지 않으면, 그냥 내버려두고,
				// 존재하면, 그 전까지만 예약 가능하도록 막아버림. 가장 가까운날짜를 찾으면, 그보다 큰 날짜들은 모두
				// unava_after 처리해버림.
				checkin_time = new Date( $('#checkin').val() );
				the_closest = null;
				for(i=0;i<booked_dates.length;i++){
					booked_dates_time = new Date( booked_dates[i] );
					if(booked_dates_time>checkin_time){
						the_closest = booked_dates_time;
						break;
					}
				}
				
				
				if(the_closest!=null){
					
					for(i=0;i<$('#calendar tbody tr td').length;i++){
						calendar_year = $('#calendar_year').val();
						calendar_month = $('#calendar_month').val();
						calendar_date = $('#calendar tbody tr td:eq('+i+')').text();
						calendar_str = calendar_year + "-" + calendar_month + "-" + calendar_date;
						
						calendar_time = new Date( calendar_str );
						
						if(the_closest <= calendar_time &&
								$('#calendar tbody tr td:eq('+i+')').attr('class')!='unava_booked' ) 
						{
							$('#calendar tbody tr td:eq('+i+')').attr('class','unava_after');
						}
					}
					
				}
					
				
			
			}
			
			
			
			for(i=0;i<$('#calendar tbody tr td').length;i++){
				txt = $('#calendar tbody tr td:eq('+i+')').text();
				cls = $('#calendar tbody tr td:eq('+i+')').attr('class');
				if(cls!='unava_booked' && cls!='unava_old' && cls!='unava_after' && txt!=''){
					$('#calendar tbody tr td:eq('+i+')').attr('class','ava');
				}
				
			}
			
			
			if($('#checkin').val()!='' && $('#checkout').val()!=''){
				
				selected = [];
				
				selected_date = new Date( $('#checkin').val() );
				checkout_date = new Date( $('#checkout').val() );
				
				while(selected_date < checkout_date ){
					year = selected_date.getFullYear();
					month = selected_date.getMonth()+1;
					date = selected_date.getDate();
					
					selected.push( year + "-" + month + "-" + date );
					selected_date.setDate(selected_date.getDate()+1);
				}
				selected.push( $('#checkout').val() );
				
				
				for(i=0;i<$('#calendar tbody tr td').length;i++){
					
					calendar_year = $('#calendar_year').val();
					calendar_month = $('#calendar_month').val();
					calendar_date = $('#calendar tbody tr td:eq('+i+')').text();
					calendar_str = calendar_year + "-" + calendar_month + "-" + calendar_date;
					
					for(j=0;j<selected.length;j++){
						if(selected[j]==calendar_str){
							$('#calendar tbody tr td:eq('+i+')').addClass('selected_dates');
							break;
						}
					}
					
				}
			}	
		}
	})
	
	
	
}




$(document)
.ready(function(){
	$('#calendar_reset').trigger('click');
})
.on('click','#calendar_right',function(){
	
	calendar_time = new Date( $('#calendar_year').val() + "-" 
							+ $('#calendar_month').val() + "-" 
							+ 1 );
	calendar_time.setMonth(calendar_time.getMonth()+1);
	
	$('#calendar_year').val( calendar_time.getFullYear() );
	$('#calendar_month').val( calendar_time.getMonth()+1 );
	FillCalendar();
	SortCalendar();
})
.on('click','#calendar_left',function(){
	
	today = new Date();
	if( today.getFullYear() == $('#calendar_year').val() && 
		today.getMonth()+1 == $('#calendar_month').val()		
	){return false;}
	
	calendar_time = new Date( $('#calendar_year').val() + "-" 
							+ $('#calendar_month').val() + "-" 
							+ 1 );
	calendar_time.setMonth(calendar_time.getMonth()-1);
	
	$('#calendar_year').val( calendar_time.getFullYear() );
	$('#calendar_month').val( calendar_time.getMonth()+1 );
	FillCalendar();
	SortCalendar();
})
.on('click','.ava',function(){
	
	year = $('#calendar_year').val();
	month = $('#calendar_month').val();
	date = $(this).text();
	
	str = year + "-" + month + "-" + date;
	
	if($('#checkin').val()==''){
		$('td[name=checkin_selected]').attr('name',null);
		$(this).attr('name','checkin_selected');
		$('#checkin').val(str)

		$('#status th').text('체크아웃 날짜 선택')
		
	} else {
		
		if ( $(this).attr('name')=='checkin_selected' ){
			$('#checkin').val('');
			$(this).attr('name',null);
			$('#checkout').val('');
			$('td[name=checkout_selected]').attr('name',null);
			SortCalendar();

			$('#status th').text('체크인 날짜 선택')
			return false;
		}
		
		$('td[name=checkout_selected]').attr('name',null);
		$(this).attr('name','checkout_selected');
		$('#checkout').val(str)
	
		// 둘 다 완벽하게 설정됐으면, calendar 에 나타난 그 사이의 달들 모두 
		// 뭐 어떻게 하면좋을텐데. sort 에서 해야할듯.
		
	}
	
	// checkout 고를때, checkin, checkout 사이에 .ava 아닌게 하나라도 중간에 끼워져있으면, 
	// 원래있던 checkin 을 없애버림. checkin_selected 도 없애버리고. 
	
	// 위 조건을 통해서 false 가 나오면 checkin 이 골라지기, true 가 나오면 정상 개본동작
	
	SortCalendar();
})
.on('click','#calendar_reset',function(){
	$('#checkin').val('');
	$('#checkout').val('');
	$('#status th').text('체크인 날짜 선택');
	InitializeCalendar();
	FillCalendar();
	SortCalendar();
})

</script>
</html>


















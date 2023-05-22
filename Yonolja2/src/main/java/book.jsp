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
table{border-collapse:collapse;border:1px solid black}
th{border:1px solid grey}
td{border:1px solid black;width:80px;height:40px;}
tbody td{cursor:pointer}
tbody td:hover{background-color:grey}
tbody td[name=checkin_selected]{background-color:aqua}
tbody td[name=checkout_selected]{background-color:orange}
</style>

<body>
<input type=text id=room_seq value="${room_seq}" readonly>
<hr>
<table id=checkin_tb>
	<thead>
		<tr> <th colspan=7><input id=year type=text>년 <input id=month type=text>월 </th>	</tr>
		<tr> <th>일</th> <th>월</th> <th>화</th> <th>수</th> <th>목</th> <th>금</th> <th>토</th> </tr>
	</thead>
	<tbody>
		<tr> 
			<td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> 
		</tr>
		<tr> 
			<td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> 
		</tr>
		<tr> 
			<td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> 
		</tr>
		<tr> 
			<td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> 
		</tr>
		<tr> 
			<td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> 
		</tr>
		<tr> 
			<td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> 
		</tr>
	</tbody>
</table>

<button id=create>create</button> <button id=checkin_sort>sort</button> <br>
<button id=left><</button> <button id=right>></button>
<br>
체크인 : <input type=text id=checkin>

<br>
<hr>	<!--		 경계선 			-->
<br>


<table id=checkout_tb>
	<thead>
		<tr> <th colspan=7><input id=checkout_year type=text>년 <input id=checkout_month type=text>월 </th>	</tr>
		<tr> <th>일</th> <th>월</th> <th>화</th> <th>수</th> <th>목</th> <th>금</th> <th>토</th> </tr>
	</thead>
	<tbody>
		<tr> 
			<td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> 
		</tr>
		<tr> 
			<td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> 
		</tr>
		<tr> 
			<td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> 
		</tr>
		<tr> 
			<td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> 
		</tr>
		<tr> 
			<td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> 
		</tr>
		<tr> 
			<td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> 
		</tr>
	</tbody>
</table>

<button id=checkout_create>create</button> <button id=checkout_sort>sort</button> <br>
<button id=checkout_left><</button> <button id=checkout_right>></button>
<br>
체크아웃 : <input type=text id=checkout>

</body>

<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
$(document)
.ready(function(){
	var today = new Date()
	$('#year').val(today.getFullYear());
	$('#month').val(today.getMonth()+1);
	
	FillCalendar();
})
.on('click','#create',function(){
	
	FillCalendar()

})
.on('click','#right',function(){
	
		formatTime = ''
		year = $('#year').val()
		month = $('#month').val()
		formatTime = year + "-" + month + "-" + 1; console.log(formatTime);
		time = new Date( formatTime/* 안에 해당 년도, 달 */);  console.log(time);
		time.setMonth( time.getMonth()+1 )
			
		$('#year').val(time.getFullYear())
		$('#month').val(time.getMonth()+1)
		
		FillCalendar()
		CheckinMark()
})

.on('click','#left',function(){
		
		// 반대로 줄이되, 만약에 이번달보다 작으면 안되는걸로. 오늘이전은 안됨.
		
		today = new Date()
		
		
		formatTime = ''
		year = $('#year').val()
		month = $('#month').val()
		
		if(year==today.getFullYear() && month==today.getMonth()+1 ){return false;}
		
		formatTime = year + "-" + month + "-" + 1; console.log(formatTime);
		time = new Date( formatTime/* 안에 해당 년도, 달 */);  console.log(time);
		time.setMonth( time.getMonth()-1 )
			
		$('#year').val(time.getFullYear())
		$('#month').val(time.getMonth()+1)
		
		FillCalendar()
		CheckinMark()
})
.on('click','#checkin_tb tr td', function(){	// 지금은 그냥 다 클릭되는데, 나중에는 선택가능한 날짜만 하는것도 있어야할듯

	selectedDate = $(this).text()
	if(selectedDate==''){return false}
	else{
		str = $('#year').val() + "-" + $('#month').val() + "-" + selectedDate
		$('#checkin').val(str)
	}
	CheckinMark()
	
	startCheckoutCallendar();
	// 갑자기 든 생각인데, td 하나하나를 radio 처럼 해두 될듯?
})



function changeDateForm(date){
	// 여기서 date 를 변환하는 작업 후 return 
	var changedForm = ''
	return changedForm
}

function FillCalendar(){
	// 일단 기본적인 calendar 구성은 했는데, 이번달일경우 1월부터 표시가 아닌 오늘날짜 이후로부터 끝날까지 표시해야함.
	console.log($('#year').val(), $('#month').val())
	$('#checkin_tb tr td').empty();
	
	var today = new Date()
	t_year = today.getFullYear();
	t_month = today.getMonth()+1;
	
	formatTime = ''
	year = $('#year').val()
	month = $('#month').val()
	
	if(t_year==year && t_month==month){
		
		formatTime = year + "-" + month + "-" + 1; console.log(formatTime)
		time = new Date( formatTime/* 안에 해당 년도, 달 */);  console.log(time)
		
		start_td_index = time.getDay();
		for(i=start_td_index;i<=$('#checkin_tb tr td').length;i++){
			if(month!=time.getMonth()+1){break;}
			date = time.getDate();
			if(time.getDate()>=today.getDate()){
				$('#checkin_tb tr td:eq('+i+')').text(date);
			}
			time.setHours(time.getHours()+24);
		}

	} else {
		
		
		formatTime = year + "-" + month + "-" + 1; console.log(formatTime)
		time = new Date( formatTime/* 안에 해당 년도, 달 */);  console.log(time)
		
		start_td_index = time.getDay();
		for(i=start_td_index;i<=$('#checkin_tb tr td').length;i++){
			if(month!=time.getMonth()+1){break;}
			date = time.getDate();
			$('#checkin_tb tr td:eq('+i+')').text(date);
			time.setHours(time.getHours()+24);
		}
		
	}
}
function CheckinMark(){
	for(i=0;i<$('#checkin_tb tr td').length;i++){
		str = $('#year').val() + "-" + $('#month').val() + "-" + $('#checkin_tb tr td:eq('+i+')').text()
		if(str==$('#checkin').val()){
			$('#checkin_tb tr td:eq('+i+')').attr('name','checkin_selected')
		} else {
			$('#checkin_tb tr td:eq('+i+')').attr('name',null)
		}
	}
}



function startCheckoutCallendar(){
	str = get_checkout_since()
	year = str.split("-")[0]
	month = str.split("-")[1]
	
	$('#checkout_year').val(year)
	$('#checkout_month').val(month)
	
	$('#checkout').val(null)
	FillCheckOutCallendar();
}


function FillCheckOutCallendar(){
	
	$('#checkout_tb tr td').empty()

	str = get_checkout_since()
	
	checkout_since_year = str.split("-")[0]
	checkout_since_month = str.split("-")[1]
	checkout_since_date = str.split("-")[2]
	
	year = $('#checkout_year').val()
	month = $('#checkout_month').val()
	
	
	if(year==checkout_since_year && month==checkout_since_month){
		
		time = new Date(str)
		start_td_index = time.getDay()
		
		str = $('#checkout_year').val() + "-" + $('#checkout_month').val() + "-" + 1
		time = new Date(str)
		start_td_index = time.getDay()
		
		for(i=start_td_index;i<=$('#checkout_tb tr td').length;i++){
			
			if(time.getMonth()+1 != $('#checkout_month').val()){break;}
			date = time.getDate();
			
			if(date>=checkout_since_date){
				$('#checkout_tb tr td:eq('+i+')').text(date)
			}
			time.setHours(time.getHours()+24);
			
		}

	} else {
		
		str = $('#checkout_year').val() + "-" + $('#checkout_month').val() + "-" + 1
		time = new Date(str)
		start_td_index = time.getDay()
		
		for(i=start_td_index;i<=$('#checkout_tb tr td').length;i++){
			
			if(time.getMonth()+1 != $('#checkout_month').val()){break;}
			date = time.getDate();
			$('#checkout_tb tr td:eq('+i+')').text(date)
			time.setHours(time.getHours()+24);
			
		}
		
		
	}
	
	CheckoutMark()
	
	
	
}


function get_checkout_since(){
	
	console.log('체크아웃 달력 생성')
	checkin_date = $('#checkin').val()
	checkout_since = new Date( checkin_date )
	nextday = checkout_since.setHours(checkout_since.getHours()+24)
	checkout_since = new Date(nextday)
		
	year = checkout_since.getFullYear()
	month = checkout_since.getMonth()+1
	date = checkout_since.getDate()
	
	str = year + "-" + month + "-" + date
	
	return str
}

function CheckoutMark(){
	
	for(i=0;i<$('#checkout_tb tr td').length;i++){
		str = $('#checkout_year').val() + "-" + $('#checkout_month').val() + "-" + $('#checkout_tb tr td:eq('+i+')').text()
		if(str==$('#checkout').val()){
			$('#checkout_tb tr td:eq('+i+')').attr('name','checkout_selected')
		} else {
			$('#checkout_tb tr td:eq('+i+')').attr('name',null)
		}
	}
	
}

$(document)
.on('click','#checkout_create',function(){
	 FillCheckOutCallendar()
})
.on('click','#checkout_right',function(){
	str = $('#checkout_year').val() + "-" + $('#checkout_month').val() + "-" + 1 
	time = new Date(str)
	time.setMonth( time.getMonth()+1 )
	
	year = time.getFullYear()
	month = time.getMonth()+1
	
	$('#checkout_year').val(year)
	$('#checkout_month').val(month)
	FillCheckOutCallendar()
	CheckoutMark()
})
.on('click','#checkout_left',function(){
	
	str = get_checkout_since();
	
	checkout_since_year = str.split("-")[0]
	checkout_since_month = str.split("-")[1]
	
	year = $('#checkout_year').val()
	month = $('#checkout_month').val()
	
	if(year==checkout_since_year && month==checkout_since_month){return false;}
	
	str = $('#checkout_year').val() + "-" + $('#checkout_month').val() + "-" + 1 
	time = new Date(str)
	time.setMonth( time.getMonth()-1 )
	
	year = time.getFullYear()
	month = time.getMonth()+1
	
	$('#checkout_year').val(year)
	$('#checkout_month').val(month)
	FillCheckOutCallendar()
	CheckoutMark()
})

.on('click','#checkout_tb tr td',function(){
	selectedDate = $(this).text()
	
	if(selectedDate==''){return false}
	else {
		
		year = $('#checkout_year').val()
		month = $('#checkout_month').val()
		str = year + "-" + month + "-" + selectedDate
		$('#checkout').val(str)
		
	}
	CheckoutMark()
})
.on('click','#checkin_sort',function(){
	console.log('날짜정리시작')
	
	$.ajax({url:'/checkin_sort', type:'post', dataType:'json', 
		
		data:{room_seq:$('#room_seq').val()},
		success:function(data){
			console.log(data)
			console.log('시작')
			
			arr=[]
			for(i=0;i<data.length;i++){
				
				console.log('round' + i)	
				console.log(data.length)
				checkin = data[i].checkin
				checkout = data[i].checkout
				
				console.log(checkin + ":" + checkout)
				
				var unavailable = new Date(checkin)
				
				
				
				while(true){
					year = unavailable.getFullYear()	
					month = unavailable.getMonth()+1
					date = unavailable.getDate()
					
					str = year+"-"+month+"-"+date
					if(str==checkout){break;}
					arr.push(str)
					
					unavailable.setHours(unavailable.getHours()+24)
				}
				
				
			}
			
			console.log(arr)
			// 그리고 이 arr 을 가지고 다시 달력에서 제거작업을 시작함. arr은 안되는날짜를 모아놓은거임
			
			year = $('#year').val()
			month = $('#month').val()
			for(i=0;i<$('#checkin_tb tr td').length;i++){
				date = $('#checkin_tb tr td:eq('+i+')').text()
				str = year + "-" + month + "-" + date
				for(j=0;j<arr.length;j++){
					if(str==arr[j]){
						$('#checkin_tb tr td:eq('+i+')').css('text-decoration','line-through')
					} 
				}
			}
			
			
		}
		
	})
	
	
})


/*

	설계 :
	
	방 예약(체크인,체크아웃버튼) 클릭시 달력페이지로 들어옴
	
	ready(function(){}) 으로 오늘, 이번달에대한 달력을 형성 refresh 
		


*/
</script>
</html>



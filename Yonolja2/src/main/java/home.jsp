<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
</head>
<style>
.header div{float:left;}
.header_child {width:20%;}
.header_child div{float:right;}


</style>
<body>
<div class=header>
	<div class=header_child>LET'S HANG OUT</div>
	<div class=header_child>
		<div><form action='/showCalendar' method="post"><input type=text name=data><input type=submit id=book></form></div>
	</div>
	<div class=header_child>
		<div><button>내정보</button></div>
	</div>
</div>

<div class=nav></div>
<div class=section></div>
<div class=footer></div>

<br>
<hr>
<button name=room>방1 <input type=text value=1 hidden></button>
<button name=room>방2 <input type=text value=2 hidden></button>
<button name=room>방3 <input type=text value=3 hidden></button>

</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
$(document)
.on('click','#book',function(){
	
})
.on('click','button[name=room]',function(){
	console.log($(this).text())
	
	room_seq = $(this).find('input').val()
	document.location = "/book/" + room_seq;
})
</script>
</html>






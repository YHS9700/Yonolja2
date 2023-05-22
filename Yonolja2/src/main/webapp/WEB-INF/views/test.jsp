<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Test2</title>
<style>
header {
  height: 75px;
  padding: 1rem;
  color: white;
  background: teal;
  font-weight: bold;
  display: flex;
  justify-content: space-between;
  align-items: center;
  
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
}

body {
	padding-top: 150px;
}

</style>

</head>
<body>

<header>
  <h1>Test</h1>
<!--   <nav>
    <span>1</span>
    <span>2</span>
    <span>3</span>
  </nav> -->
</header>

<table id=test>
</table>

<table id=test2>
NAME: <input type=text id=name><br>
DATA: <input type=text id=data>
<button id="add">추가</button>
</table>

</body>

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
$(document)

.ready(function() {
	loadData();
})

.on('click', '#add', function() {
	$.ajax({
		url:'/insert',
		type:'post',
		data:{
			name:$('#name').val(),
			data:$('#data').val()
		},
		dataType:'text',
		
		beforeSend:function() {
			if($('#name').val()==''||$('#data').val()=='') {
				alert('name 또는 data 값이 비었습니다.');
				return false;
			}
		},
		
		success:function(data) {
			if(data=='ok') {
				console.log('insert 성공');
				alert('insert 성공')
			} else {
				console.log('insert 실패');
				alert('insert 실패')
			}
		}
	})
})

function loadData() {
	$.ajax(
		{
		url:'/test', 
		type:'post', 
		dataType:'json', 
		data:{},
		
		success:function(data) {
		console.log(data);		
			
			for(let i=0; i<data.length; i++) {
				let name = data[i];
				
				let str='<tr>';
				str+='<td>'+name['name']+'</td>';
				str+='<td>'+name['data']+'</td></tr>';
				
				$('#test').append(str);
				}
		}})
}

</script>
</html>
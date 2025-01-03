<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.FileReader"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    											pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<% 
//  < key, value >
Map<String,String> map = new HashMap<String,String>();

String filePath = "c:/temp2/redday.txt";
FileReader fr = new FileReader(filePath);
BufferedReader br = new BufferedReader(fr);
String text = "";
while(true) {
	String data = br.readLine();  // 2024-01-01:신정
	if( data == null ) {
		break;
	} else {
		String[] array = data.split(":");    // 날짜와 데이터값을 분리
		String[] days = array[0].split("-"); // 날짜만 다시 분리
		
		String col = days[0]+"-"
					+(Integer.parseInt(days[1]))+"-"
					+(Integer.parseInt(days[2]));  
		// 예) String col="2024-1-1";
		map.put(col,array[1]); 
		// 세팅 : map.put("2024-1-1","신정");
		// 호출 : map.get("2024-1-1");  --> 신정이라는 값을 얻어내게 됨
		// 예)	map.put("eng","100");
		//	   	map.get("eng") --> "100" 출력
	}
}

//out.print(text);
%>


<% 
// 출력 달(년월)을 받음
String vdate = request.getParameter("vdate");

// 인스턴스(객체)처리
Calendar cal = Calendar.getInstance();

int yy = cal.get(Calendar.YEAR); // 현 시점의 년도
int mm = cal.get(Calendar.MONTH);// 현 시점의 월 (0월 ~ 11월)
int dd = cal.get(Calendar.DATE); // 현 시점의 날 (즉 오늘 날짜)

// ex) 2024-9-1  :: 2024-12-10
String today = yy +"-"+(mm+1)+"-"+ dd;

// 예) vdate = "2024-12";
if( vdate == null || vdate.equals("") ) {
	vdate = yy + "-" + (mm+1);
}

// vdate는 무조건 존재
String[] str = vdate.split("-");
int v_yy = Integer.parseInt(str[0]);  // 2024
int v_mm = Integer.parseInt(str[1]);  // 12월(12) ,, 9월(9) 
String v_date = v_yy+"-"+v_mm;

// 출력하려는 달력의 시점을 세팅한다.
// 시점의 날짜는 1일날이 default임
// 예1) 2025년  1월달 달력 :: cal.set(2025,0,1)
// 예2) 2025년 12월달 달력 :: cal.set(2025,11,1)
cal.set(v_yy,(v_mm-1),1);

// 출력 달의 첫날(1일)에 해당하는 요일 :: 일(1),월(2) ~~ 토(7)
int wk = cal.get(Calendar.DAY_OF_WEEK);

// 출력 달의 마지막 날짜
int lastday = cal.getActualMaximum(Calendar.DATE);

// 이전달 S
int b_yy = v_yy; 
int b_mm = v_mm-1;  // 이전달 = 출력달 - 1;
if( b_mm == 0 ) {   // 이전달의 결과가 0과 같은 경우는 해가 바뀐거임
	b_yy = b_yy-1;
	b_mm = 12;
}

// 다음달 S
int n_yy = v_yy;	// 다음달 년도 = 출력년도
int n_mm = v_mm+1;  // 다음달의 월 = 출력달의 월 + 1; 
if( n_mm == 13 ) {  // 다음달의 계산이 13인 경우는 해가 바뀐거임
	n_yy = n_yy+1;
	n_mm = 1;
}

String bef = b_yy+"-"+b_mm;
String nex = n_yy+"-"+n_mm;

%>

<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>동화제약 관리모드</title>
  
  <link rel="stylesheet" href="/css/admStyle.css">
  <link rel="stylesheet" href="/css/jquery-ui.css">
  <link rel="stylesheet" href="/css/style.css">
  <script src="/js/jquery-3.7.1.js"></script>
  <script src="/js/jquery-ui.js"></script>
  
</head>

<style>
.locTd {
	font-size:15px;
	height:25px;
}
input,textarea,select {
	width:90%;
	font-size:15px;
	font-family:맑은 고딕;
}
textarea {
	height:100px;
}
.td {
	width: 98%;
	height:25px;
}
.button1 {
	padding:5px;
	font-size:12px;
	width:70px;
}
</style>


<style>
  .overflow {
      height: 300px;
  }
</style>


<body>

<div class="adminTop">
	<%@ include file="../include/admMenu.jsp" %>
</div>

<div class="adminMain">
	<div>
		<table class="type08" align="center">
			<tr>
				<th style="font-size:20px;">
					일정목록(달력)
				</th>
			</tr>
		</table>
		<br>
		<table class="type08" align="center">
			<caption style="text-align:left;">
				<% // 삼항연산 :: (비교연산식)?true:false %>
				<%=v_yy %>년 <%=(v_mm<10)?("0"+v_mm):(""+v_mm) %>월
				&nbsp;&nbsp;
				<a href="/schList.do?vdate=<%=bef %>">(이전)</a>
				<a href="/schList.do?vdate=<%=nex %>">(다음)</a>
				<a href="/schList.do">(오늘)</a>
			</caption>
			<tr>
				<th>일</th>
				<th>월</th>
				<th>화</th>
				<th>수</th>
				<th>목</th>
				<th>금</th>
				<th>토</th>
			</tr>
			
			<tr>
			<%
			// 네모칸 개수를 세는 변수
			int tdCnt = 0;
			for(int i=1; i<wk; i++) {
				tdCnt++;
			%>
				<td height="80"></td>
			<%
			}
			// 날짜를 출력하는 반복문
			for(int d=1; d<=lastday; d++) {
				// 네모칸 개수를 세는 변수도 같이 증가
				tdCnt++;
				
				// 오늘날짜에 색상을 주기위한 세팅
				// 다음 형식이 된다. -> 2024-12-10 또는 2024-9-7
				String v_today = v_date +"-"+ d;
				String tdColor = "#ffffff";
				// 오늘날짜와 출력날짜가 같으면 색상을 푸른색으로 한다.
				if( today.equals(v_today) ) tdColor = "skyblue";
			%>
				<td width="100" height="80" bgcolor="<%=tdColor %>">
				<%=d %> 
				
				<%
				// 공휴일 출력을 위한 세팅
				// map변수의 키값으로 공휴일 날짜를 세팅했으므로
				// 출력날짜를 키값으로 세팅하여 결과값이 있는지 확인하여 출력한다.
				// v_today = 2024-12-1
				if( map.get(v_today) != null ) {
					out.print( map.get(v_today) );
				}
				
				// 날짜를 jstl 변수로 변환 (아래 jstl에서 사용함)
				pageContext.setAttribute("schday", d) ;
				%>
				<br> 
				<!-- 
				myMap = {20=1,09=1,03=1,12=1,11=2}와 같은 형식으로 넘어 왔음
				map형식으로 Controller에서 전달된 데이터는 아래와 같이
				map.key로 key값을 얻어낼 수 있음:: 위 데이터 기준으로 20,09,03,12,11
				map.value로 value값을 얻어낼 수 있다.
				--> 
				
				<% // vdate(2024-12)의 값에서 출력날짜를 연결함 
				
				%>
				
				<c:forEach var="map" items="${myMap }">
					<!-- 출력날짜(schday)와 key값을 비교하여 
					     같은 내용이 있으면 value값을 출력한다. -->
					<c:if test="${map.key==schday }">
						<a href="/schList.do?vdate=<%=v_today %>">일정(${map.value })</a>
					</c:if>
				</c:forEach>

				</td>
			<%
				if(tdCnt%7 == 0) {
					out.print("</tr><tr>");
				}
			}
			%>	
			</tr>
		</table>     
                              
		<div style="margin-left:140px;
					margin-top:10px; 
					width:930px; 
					text-align:right;">
			<button type="button" onclick="location='/schWrite.do'">일정등록</button>
		</div>

		<br>

		<div>
		<table class="type08" align="center">
			<tr>
				<th width="10%">순번</th>
				<th width="20%">시간</th>
				<th>제목</th>
				<th width="16%">비고</th>
			</tr>
	        
		<c:forEach var="result" items="${list2 }" varStatus="status"> <% //${} 주석 %>
			<tr align="center">
				<td>${status.count }</td>
				<td>
					${fn:substring(result.SCHDT,0,16) }
				</td>
				<td align="left">
					<span id="title_txt${status.count }">${result.TITLE }</span>
					<input type="text" name="title" id="title${status.count }" value="${result.TITLE }">
				</td>
				<td>    
					<button type="button" onclick="fn_view('${status.count }')">+</button>
					<button type="button" onclick="fn_hide('${status.count }')">-</button>
					<button type="button" onclick="fn_modify('${result.UNQ }','${status.count }')">M</button>
					<button type="button" onclick="fn_delete('${result.UNQ }')">D</button>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<div id="divCont${status.count }" style="width:98%;height:50px;">
						${result.CONT }
					</div>
					
					<div id="divTextarea${status.count }" style="width:98%;">
						<textarea name="cont${status.count }" id="cont${status.count }">${result.CONT }</textarea>
						<button type="button" id="btn_modify${status.count }" 
						        onclick="fn_update('${result.UNQ}','${status.count }')">수정</button>
					</div>
				</td>
			</tr>
		</c:forEach>
			
		</table>
		</div>
		<p style="height:200px;">&nbsp;</p>

<script>
$(function(){	
	for(var i=1; i<=48; i++) {
		// 내용_텍스트
		$("#divCont"+i).hide();
		// 내용_입력상자
		$("#divTextarea"+i).hide();
		// 제목_입력상자
		$("#title"+i).hide();
	}
});

function fn_modify(unq,cnt) {
	$("#title_txt"+cnt).hide();
	$("#divCont"+cnt).hide();
	$("#title"+cnt).show();
	$("#divTextarea"+cnt).show();
}

function fn_update(unq,cnt) {
	
	let title = $.trim($("#title"+cnt).val());
	let cont = $.trim($("#cont"+cnt).val());
	if( title == "" ) {
		alert("제목을 입력해주세요.");
		$("#title"+cnt).focus();
		return false;
	}
	// json 형식
	let datas = { 'title':title,'cont':cont,'unq':unq };
	
	//let datas = "title="+title+"&cont="+cont+"&unq="+unq;
	
	$.ajax({
		type : "post",
		url : "/schUpdate.do",
		data : datas,
		success : function(data) {
			if(data == "ok") {
				alert("수정 처리 완료");
				location="/schList.do?vdate=<%=vdate %>";
			} else {
				alert("수정 처리 실패");
			}
		},
		error : function() {
			alert("오류발생!!");
		}
	});
}

function fn_view(nn) {
	$("#divCont"+nn).show();
	$("#title"+nn).hide();
	$("#divTextarea"+nn).hide();
	$("#title_txt"+nn).show();
}
function fn_hide(nn) { 
	$("#divCont"+nn).hide();
	$("#divTextarea"+nn).hide();
	$("#title_txt"+nn).show();
	$("#title"+nn).hide();
}

function fn_delete(unq) {

	if( confirm("해당 일정을 삭제하시겠습니까?") ) {
		//location = "/schDelete.do?unq="+unq; // old
		$.ajax({
			type : "post",
			url : "/schDelete.do",
			data : "unq="+unq,
			datatype : "text",
			success : function(data) { // ok , fail
				if( data == "ok" ) {
					alert("해당 일정을 삭제했습니다.");
					location = "/schList.do?vdate=<%=vdate %>";
				} else {
					alert("다시 시도해주세요.");
				}
			},
			error : function() {
				alert("오류발생!");
			}
		});
	}
}

  /*
  document.getElementById("divCont1").style.display = "none";
  document.getElementById("divCont2").style.display = "none";
  
  function fn_view(nn) {  // nn="1";  nn="2";
	  // 보이게
	  document.getElementById("divCont"+nn).style.display = "block";
  }
  function fn_hide(nn) {  // nn="1";  nn="2";
	  // 안보이게
	  document.getElementById("divCont"+nn).style.display = "none";
  } */
  
</script>	
		

	</div>
</div>
</body>
</html>
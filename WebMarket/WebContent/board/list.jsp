<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="mvc.model.BoardDTO" %>
<%
	String sessionId = (String) session.getAttribute("sessionId");
	ArrayList<BoardDTO> boardlist = new ArrayList<>();
	boardlist = (ArrayList<BoardDTO>)request.getAttribute("boardlist");
	int total_record = (Integer) request.getAttribute("total_record");
	int pageNum = (Integer) request.getAttribute("pageNum");
	int total_page = (Integer) request.getAttribute("total_page");
%>
<html>
<head>
<link rel ="stylesheet" href = "./resources/css/bootstrap.min.css">
<title>Board</title>
<script type="text/javascript">
	function checkForm() {
		if (${sessionId == null} ){
			alert("로그인 하세요.");
			return false;
		}
		location.href = "./BWriteForm.do?id=<%= sessionId %>"
	}
</script>
</head>
<body>
	<jsp:include page="../menu.jsp" />
	<div class = "jumbotron" >
		<div class = "container">
		<h1 class = "display-3">게시판</h1>
		</div>
	</div>	
	<div class="container">
		<form action="<c:url value="./BoardListAction.do" />" method="post">
			<div>
				<div class="text-right">
					<span class="badge badge-success">전체 <%=total_record %>건</span>
				</div>
			</div>
		<div style="padding-top: 50px"> 
			<table class="table table-hover">
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성일</th>
					<th>조회</th>
					<th>글쓴이</th>
				</tr>
				<%
					for(int j=0; j<boardlist.size(); j++) {
						BoardDTO notice = (BoardDTO) boardlist.get(j); 
				%>
				<tr>
					<td><%=notice.getNum()%></td>
					<td><a href="./BViewAction.do?num=<%=notice.getNum() %>
								&pageNum=<%=pageNum %>"><%=notice.getSubject() %></a></td>
					<td><%=notice.getRegist_day() %></td>
					<td><%=notice.getHit() %></td>
					<td><%=notice.getName() %></td>
				</tr>	
				<%
					}
				%>
			</table>
			</div>
			<div align="center">
				<c:set var="pageNum" value="<%=pageNum %>" />
				<c:forEach var="i" begin="1" end="<%=total_page %>">
					<a href="<c:url value="./BoardListAction.do?pageNum=${i}"/> ">
						<c:choose>
							<c:when test="${pageNum==i }">
								<font color='4C5317'><b>[${i}]</b></font>
							</c:when>
							<c:otherwise>
								<font color='4C5317'>[${i}]</font>
							</c:otherwise>
						</c:choose>
					</a>
				</c:forEach>
			</div>
			<div align="left">
				<table>
					<tr>
						<td width="100%" align="left">&nbsp;&nbsp;
						<select name="items" class="txt">
							<option value="subject">제목검색</option>
							<option value="content">본문검색</option>
							<option value="name">글쓴이검색</option>
						</select>
						<input type="text" name="text" />
						<input type="submit" id="btnAdd" class="btn btn-primary" value="검색"/>
						</td>
						<td width="100%" align="right">
							<a href="#" onclick="checkForm(); return false;" class="btn btn-primary">&laquo;글쓰기</a>
						</td>
					</tr>
				</table>
			</div>
		</form>
		<hr>
	</div>
	<jsp:include page="../footer.jsp" />
</body>
</html>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page errorPage="exceptionNoProductId.jsp" %>
<html>
<link rel = "stylesheet" href = "./resources/css/bootstrap.min.css">
<head>	
<title>상품 상세 정보</title>
<script type="text/javascript">
	function addToCart() {
		if (confirm("상품을 장바구니에 추가하시겠습니까?")) {
			document.addForm.submit();
		} else {
			document.addForm.reset();
		}
	}
</script>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<div class = "jumbotron" >
		<div class = "container">
			<h1 class = "display-3">상품 상세 정보</h1>
		</div>
	</div>	
	<div class="container">
		<%@ include file="dbconn.jsp" %>
		<%
			String productId = request.getParameter("id");
		
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			String sql = "select * from product where p_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, productId);
			rs = pstmt.executeQuery();
			while(rs.next()) {
		%>
		<div class="row">
			<div class="col-md-5">
				<img alt="" src="${pageContext.servletContext.contextPath}/resources/images/<%=rs.getString("p_fileName") %>" style="width: 100%" >
			</div>
			<div class="col-md-6">	
				<h3><%=rs.getString("p_name") %></h3>
				<p><%=rs.getString("p_description") %>
				<p> <b>상품코드</b> : <span class="badge badge-danger">
					<%=rs.getString("p_id") %></span>
				<p> <b>제조사</b> : <%=rs.getString("p_manufacturer") %>
				<p> <b>분  류</b> : <%=rs.getString("p_category") %>
				<p> <b>재고수</b> : <%=rs.getLong("p_unitsInStock") %>
				<h4><%=rs.getInt("p_unitPrice") %>원</h4>
				<p> <form name="addForm" action="./addCart.jsp?id=<%=rs.getString("p_id") %>" 
				method="post">
				 	<a href="#" class="btn btn-info" onclick="addToCart()"> 상품 주문 &raquo;</a>
				 	<a href="./cart.jsp" class="btn btn-warning">장바구니 &raquo;</a>
					<a href="./products.jsp" class="btn btn-secondary"> 상품 목록 &raquo;</a>
					</form> 
			<%
				}
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			%>
			</div>
		</div>
		<hr>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>
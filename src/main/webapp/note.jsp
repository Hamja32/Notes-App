<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.backend.FactoryProvider"%>
<%@page import="org.hibernate.Session"%>
<%@page import="com.backend.model.Note"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Note details</title>
<%@include file="all_css.jsp"%>
</head>
<body>
	<%@include file="navbar.jsp"%>

	<div class="container mt-5">

		<%
		// 1. URL se ID nikalna (jo index.jsp se aayi hai)
		int noteId = Integer.parseInt(request.getParameter("note_id"));

		// 2. Database se us ID ka Note object nikalna
		Session s = FactoryProvider.getFactory().openSession();
		Note note = s.find(Note.class, noteId);
		%>

		<div class="row">
			<div class="col-md-8 offset-md-2">
				<div class="card shadow">
					<div class="card-header text-center purple-bg">
						<h3>Note Inforamtion</h3>
					</div>
					<div class="card-body">
						<h1>
							Title :
							<%=note.getTitle()%></h1>
						<p>
							Description :
							<%=note.getDescription()%></p>
							
						<%
						
						SimpleDateFormat formatter = new SimpleDateFormat("dd-mm-yyyy");
						String  curr_date = null;
						if(note.getCreated_at() != null){
							curr_date = formatter.format(note.getCreated_at());
						}
						%>	
							
							
						<b>Created At : <%= curr_date %></b> <br>
						<%
						if (note.getUpdated_at() != null) {
						%>

						<b><i class="fa-regular fa-alarm-clock"></i>Updated At : <%=note.getUpdated_at()%></b>
						<%
						}
						%>
					</div>
				</div>
			</div>
		</div>

		<%
		s.close(); // Session close karna na bhulein
		%>
	</div>
</body>
</html>
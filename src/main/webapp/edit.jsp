<%@page import="com.backend.FactoryProvider"%>
<%@page import="org.hibernate.Session"%>
<%@page import="com.backend.model.Note"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Note Page</title>
    <%@include file="all_css.jsp" %>
</head>
<body>
    <%@include file="navbar.jsp" %>

    <div class="container mt-5">
        
        <%
            // 1. URL se ID nikalna (jo index.jsp se aayi hai)
            int noteId = Integer.parseInt(request.getParameter("note_id"));
        
            // 2. Database se us ID ka Note object nikalna
            Session s = FactoryProvider.getFactory().openSession();
            Note note = s.find(Note.class, noteId);
        %>

        <div class="row">
            <div class="col-md-6 offset-md-3">
                <div class="card shadow">
                    <div class="card-header text-center purple-bg">
                        <h3>Edit Your Note</h3>
                    </div>
                    <div class="card-body">
                        
                        <form action="UpdateServlet" method="post">
                            
                            <input value="<%= note.getId() %>" name="note_id" type="hidden" />

                            <div class="mb-3">
                                <label for="title" class="form-label">Note Title</label>
                                <input type="text" 
                                       name="title" 
                                       class="form-control" 
                                       id="title" 
                                       placeholder="Enter title here" 
                                       value="<%= note.getTitle() %>" 
                                       required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="content" class="form-label">Note Content</label>
                                <textarea name="description" 
                                          class="form-control" 
                                          id="description" 
                                          rows="5" 
                                          required><%= note.getDescription() %></textarea>
                            </div>
                            
                            <div class="container text-center">
                                <button type="submit" class="btn btn-success">Save Changes</button>
                                <a href="index.jsp" class="btn btn-outline-danger">Cancel</a>
                            </div>
                            
                        </form>
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

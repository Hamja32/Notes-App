
<%@page import="com.backend.FactoryProvider"%>
<%@page import="com.backend.model.Note"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.query.Query"%>
<%@page import="org.hibernate.Session"%>
<%@page import="java.text.SimpleDateFormat"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Notes</title>
    <%@include file="all_css.jsp" %>
    
    <style>
        /* Professional Background */
        body {
            background-color: #0c2c55;
        }

        /* Card Styling */
        .note-card {
            border: none;
            border-radius: 15px;
            background: #ffffff;
            transition: all 0.3s ease-in-out;
            border-left: 5px solid #fe7f2d; /* Purple strip on left */
            overflow: hidden;
        }

        .note-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1) !important;
        }

        .note-title {
            font-weight: 700;
            color: #333;
            font-size: 1.2rem;
        }

        .note-content {
            color: #555;
            font-size: 0.95rem;
            min-height: 80px;
        }

        .note-date {
            font-size: 0.8rem;
            color: #888;
            font-style: italic;
        }
        
        .action-btn {
        	border-radius: 50px;
        	padding: 5px 15px;
        	font-size: 0.85rem;
        }
    </style>
</head>
<body>
    <%@include file="navbar.jsp" %>

    <div class="container mt-4">
        
        <div class="row">
            <div class="col-md-12">
                <h3 class="text-center mb-5 text-uppercase" style="letter-spacing: 2px; color: #ffffff;">
                    <i class="fa-solid fa-notebook"></i> Your Notes
                </h3>
                
                <div class="row">
                
                    <% 
                        Session s = FactoryProvider.getFactory().openSession();
                        Query q = s.createQuery("from Note order by id desc"); // Newest first
                        List<Note> list = q.list();
                        
                        // Date Formatting ke liye setup
                        SimpleDateFormat formatter = new SimpleDateFormat("dd MMM, yyyy");

                        // Check agar list empty hai
                        if(list.isEmpty()){
                    %>
                    	<div class="col-md-12 text-center mt-5">
                    		<h4 class="text-success text-white">No notes available right now.</h4>
                    		<a href="add_note.jsp" class="btn btn-outline-primary mt-3">Add your first note</a>
                    	</div>
                    <% 
                        }

                        for(Note note : list) {
                        	// Content Truncation Logic (Agar text 100 words se jyada hai to ...)
                        	String content = note.getDescription();
                        	if (content != null && content.length() > 100) { 
                        	    content = content.substring(0, 100) + "...";
                        	}
                        	
                        	// Date formatting handle null safety
                        	String formattedDate = "Unknown Date";
                        	if(note.getCreated_at() != null){
                        		formattedDate = formatter.format(note.getCreated_at());
                        	}
                    %>

                    <div class="col-md-4 mb-4">
                        <div class="card shadow-sm note-card h-100"> 
                            <div class="card-body d-flex flex-column">
                            	
                            	<div class="d-flex justify-content-between align-items-center mb-2">
                            		<h5 class="note-title mb-0"><%= note.getTitle() %></h5>
                            	</div>
                            	<span class="note-date mb-3"><i class="fa-regular fa-calendar"></i> <%= formattedDate %></span>
                                
                                <p class="card-text note-content">
                                	<%= content %> 
                                </p>
                                
                                <div class="mt-auto d-flex justify-content-end gap-2">
                                    <a href="DeleteServlet?note_id=<%= note.getId() %>" class="btn btn-outline-danger action-btn">
                                    	<i class="fa-solid fa-trash"></i> Delete
                                    </a>
                                    <a href="edit.jsp?note_id=<%= note.getId() %>" class="btn btn-outline-primary action-btn">
                                    	<i class="fa-solid fa-pen"></i> Edit
                                    </a>
                                </div>
                                
                            </div>
                        </div>
                    </div>
                    <% 
                        } 
                        s.close(); 
                    %>
                    
                </div>
            </div>
        </div>
    </div>
</body>
</html>s
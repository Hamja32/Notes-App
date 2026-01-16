
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Note</title>
    <%@include file="all_css.jsp" %>
</head>
<body>
    <%@include file="navbar.jsp" %>
    
    <div class="container mt-5">
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <div class="card shadow">
                    <div class="card-header text-center purple-bg">
                        <h3>Add Your Note</h3>
                    </div>
                    <div class="card-body">
                        <form action="SaveNoteServlet" method="post">
                            
                            <div class="mb-3">
                                <label for="title" class="form-label">Note Title</label>
                                <input type="text" name="title" class="form-control" id="title" placeholder="Enter title here" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="content" class="form-label">Note Content</label>
                                <textarea name="content" class="form-control" id="content" rows="5" placeholder="Enter your note content" required></textarea>
                            </div>
                             <div class="mb-3">
                                <label for="date" class="form-label">Date</label>
                              <input type="date" name="date" class="form-control">
                            </div>
                            
                            <div class="text-center">
                                <button type="submit" class="btn btn-outline-primary">Save Note</button>
                            </div>
                            
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
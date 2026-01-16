package com.servlets;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import com.backend.FactoryProvider;
import com.backend.model.Note;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SaveNoteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public SaveNoteServlet() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("title");
		String description = request.getParameter("content");
		
		String dateStr = request.getParameter("created_at");
		 Date date = new Date();
		try {
            if(dateStr != null && !dateStr.isEmpty()){
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                date = sdf.parse(dateStr);
            }
        } catch (Exception e) {
            e.printStackTrace(); 
            // Agar date parsing me error aaya to system ki current date rahegi
        }
	 

		
		Note note = new Note();
		note.setTitle(title);
		note.setDescription(description);
		note.setCreated_at(date);
		
		
		Session session = FactoryProvider.getFactory().openSession();
        Transaction tx = session.beginTransaction();
		
		session.persist(note);
		tx.commit();
		System.out.print("Your data is inserted sucessfully");
		
		// 5. Response
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        //out.println("<h1 style='text-align:center;'>Note added successfully</h1>");
		response.sendRedirect(request.getContextPath() + "/index.jsp");
	}

}

package com.servlets;

import java.io.IOException;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.backend.FactoryProvider;
import com.backend.model.Note;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DeleteServlet
 */
public class DeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public DeleteServlet() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 1. URL se note_id fetch karna (jo string format me aati hai)
			int noteId = Integer.parseInt(request.getParameter("note_id").trim());

			// 2. Hibernate Session open karna
			Session s = FactoryProvider.getFactory().openSession();
			Transaction tx = s.beginTransaction();

			// 3. Note ko load karna aur delete karna
			Note note = (Note) s.find(Note.class, noteId);
			s.remove(note); // Ye line database se row delete karegi

			// 4. Commit aur Close
			tx.commit();
			s.close();
			
			// 5. Wapas Home page ya Show Notes page par bhejna
			response.sendRedirect("index.jsp");

		} catch (Exception e) {
			e.printStackTrace();
		}
	}


}

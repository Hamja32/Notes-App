package com.servlets;

import java.io.IOException;
import java.util.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.backend.FactoryProvider;
import com.backend.model.Note;

public class UpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UpdateServlet() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			// 1. Form se data fetch karna
			String title = request.getParameter("title");
			String content = request.getParameter("description");
			
			// Hidden input field se ID aayi hai string format me, int me convert kiya
			int noteId = Integer.parseInt(request.getParameter("note_id").trim());

			// 2. Hibernate Session shuru karna
			Session s = FactoryProvider.getFactory().openSession();
			Transaction tx = s.beginTransaction();

			// 3. Purana object database se nikalna (Isse object Persistent state me aa jata hai)
			Note note = s.find(Note.class, noteId);

			// 4. Values update karna
			note.setTitle(title);
			note.setDescription(content);
			
			// Optional: Date ko bhi update kar dete hain taki pata chale abhi change hua hai
			note.setCreated_at(new Date());

			// 5. Save changes (Commit karte hi Hibernate detect karega ki changes huye hain aur update query chalayega)
			tx.commit();
			s.close();

			// 6. Wapas home page par bhejna
			response.sendRedirect("index.jsp");

		} catch (Exception e) {
			e.printStackTrace();
			// Error aane par wapas edit page par bhej sakte hain msg ke sath
			response.getWriter().println("<h1>Error Updating Notes: " + e.getMessage() + "</h1>");
		}
	}
}
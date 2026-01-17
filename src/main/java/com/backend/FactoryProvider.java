package com.backend;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import com.backend.model.Note; // Import your Entity

public class FactoryProvider {
	public static SessionFactory factory;


	public static SessionFactory getFactory() {

		if (factory == null) {
			  // Configuration sirf tab load hogi jab factory null hogi
			factory = new Configuration()
					.configure("hibernate.cfg.xml")
					.addAnnotatedClass(Note.class)
					.buildSessionFactory();
		}

		return factory;
	}

//
	public void closeFactory() {
		if (factory.isOpen()) {
			factory.close();
		}
	}
}

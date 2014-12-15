package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.lucene.queryparser.classic.ParseException;

import clean.WikiPage;
import query.WikiQuery;

/**
 * Servlet implementation class Index
 */
@WebServlet("/Index")
public class Index extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final int RESULTS_PER_PAGE = 10;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Index() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (request.getParameterMap().containsKey("q")) {
			String queryString = request.getParameter("q");
			int firstResult = 0;
			if (request.getParameterMap().containsKey("page")) {
				firstResult = (Integer.parseInt(request.getParameter("page")) - 1) * RESULTS_PER_PAGE;
			}
			
			int page = 1;
			if (request.getParameterMap().containsKey("page")) {
				page = Integer.parseInt(request.getParameter("page"));
			}
			
			WikiQuery query = new WikiQuery("/Users/SpYd3r/Documents/Cours/M2/Search Engine/index", RESULTS_PER_PAGE);
			try {
				ArrayList<WikiPage> results = query.search(new String[]{"title", "entites"}, queryString, firstResult);
				
				request.setAttribute("res", results);
				request.setAttribute("pages", (int) Math.floor(query.getNumTotalDoc() / RESULTS_PER_PAGE));
				request.setAttribute("currentPage", page);
			} catch (ParseException e) {
				request.setAttribute("error", e.getMessage());
			}
			request.setAttribute("q", queryString);
			
			this.getServletContext().getRequestDispatcher("/WEB-INF/results.jsp").forward(request, response);
		} else {
			this.getServletContext().getRequestDispatcher("/WEB-INF/index.jsp").forward(request, response);
		}
	}
}

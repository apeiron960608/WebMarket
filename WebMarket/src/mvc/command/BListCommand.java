package mvc.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.model.BoardDAO;
import mvc.model.BoardDTO;

public class BListCommand implements BCommand {
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// 게시판 리스트를 직접적으로 가져오는 커맨드 객체
		
		BoardDAO dao = BoardDAO.getInstance();
		ArrayList<BoardDTO> boardlist = new ArrayList<BoardDTO>();
		
		int pageNum = 1;
		int limit = 5; // 한페이지에 나타낼 게시글 수
		
		// 페이지 값이 NULL이 아니면 해당 페이지 숫자로 변환해서 저장
		if(request.getParameter("pageNum") != null) 
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		
		String items = request.getParameter("items"); // 제목, 본문, 글쓴이
		String text = request.getParameter("text");   // 검색어
		
		int total_record = dao.getListCount(items, text); // db에 저장된 게시글 총 수
		boardlist = dao.getBoardList(pageNum, limit, items, text); // db에 저장된 게시글 가져옴
		
		int total_page; // 페이지 수 구하기
		
		if (total_record % limit == 0) {
			total_page = total_record / limit;
			Math.floor(total_page);
		} else {
			total_page = total_record / limit;
			Math.floor(total_page);
			total_page = total_page + 1;
		}
		
		// request 객체에 각각 해당하는 값을 저장한다
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("total_page", total_page);
		request.setAttribute("total_record", total_record);
		request.setAttribute("boardlist", boardlist);
	}
}

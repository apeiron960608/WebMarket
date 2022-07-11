package mvc.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.command.BCommand;
import mvc.command.BDeleteCommand;
import mvc.command.BListCommand;
import mvc.command.BUpdateCommand;
import mvc.command.BViewCommand;
import mvc.command.BWriteCommand;
import mvc.command.BWriteFormCommand;

public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public BoardController() { // 추가
		super();
	}
	
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		System.out.println("doGet"); // 추가
		actionDo(request, response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		
		System.out.println("doPost"); // 추가
		actionDo(request, response);
		
	}
	
	private void actionDo(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		
		System.out.println("actionDo"); // 추가
		
		String uri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = uri.substring(contextPath.length());
		
		response.setContentType("text/html; charset=utf-8");
		request.setCharacterEncoding("utf-8");
		
		String viewPage = null;
		BCommand com = null;
		
		// command 패턴에 따라 나눔
		if (command.equals("/BoardListAction.do")) { // 글 목록 페이지 출력
			System.out.println("/BoardListAction.do 페이지 호출");
			
			com = new BListCommand();
			com.execute(request, response);
			viewPage = "./board/list.jsp";
		} else if (command.equals("/BWriteForm.do")) { //새글 등록전 회원 로긴여부확인
			System.out.println("/BWriteForm.do 페이지 호출");
			
			com = new BWriteFormCommand();
			com.execute(request, response);
			viewPage = "./board/writeForm.jsp";
		} else if (command.equals("/BWriteAction.do")) { // 새글등록 db 저장
			System.out.println("/BWriteAction.do 페이지 호출");
			
			com = new BWriteCommand();
			com.execute(request, response);
			viewPage = "/BoardListAction.do";
		} else if (command.equals("/BViewAction.do")) { // 게시글 상세보기
			System.out.println("/BViewAction.do 페이지 호출");
			
			com = new BViewCommand();
			com.execute(request, response);
			viewPage = "./board/view.jsp";
		} else if (command.equals("/BUpdateAction.do")) { // 게시글 수정
			System.out.println("/BUpdateAction.do 페이지 호출");
			
			com = new BUpdateCommand();
			com.execute(request, response);
			viewPage = "/BoardListAction.do";
		} else if (command.equals("/BDeleteAction.do")) { // 게시글 삭제
			System.out.println("/BDeleteAction.do 페이지 호출");
			
			com = new BDeleteCommand();
			com.execute(request, response);
			viewPage = "/BoardListAction.do";
		}
		
		// 위에서 나눠 설정된 view(jsp)파일로 페이지 이동
		RequestDispatcher rd = request.getRequestDispatcher(viewPage);
		rd.forward(request, response);
	}
}

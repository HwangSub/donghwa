package donghwa.service;

import java.util.List;

public interface BoardService {
	List<?> selectBoardList(DefaultVO vo) throws Exception;
	int selectBoardTotal(DefaultVO vo) throws Exception;
	BoardVO selectBoardDetail(BoardVO vo) throws Exception;

	int insertBoard(BoardVO vo) throws Exception;
	int updateBoard(BoardVO vo) throws Exception;
	int deleteBoard(BoardVO vo) throws Exception;
}

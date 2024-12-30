package donghwa.service;

import java.util.List;

public interface ResearchService {

	// 저장처리
	public int insertResearch(ResearchVO vo) throws Exception;

	// 목록출력
	public List<?> selectResearchList(DefaultVO vo) throws Exception;

	// 총개수
	public int selectResearchTotal(DefaultVO vo) throws Exception;
	
	// 상세보기
	ResearchVO selectResearchDetail(ResearchVO vo) throws Exception;

	// 수정처리
	public int updateResearch(ResearchVO vo) throws Exception;
	
	
}





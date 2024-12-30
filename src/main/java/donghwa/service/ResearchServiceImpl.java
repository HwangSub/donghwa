package donghwa.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import donghwa.mapper.ResearchMapper;

@Service("researchService")
public class ResearchServiceImpl implements ResearchService {

	// 다른 파일 사용
	@Resource(name="researchMapper")
	ResearchMapper researchMapper;
	
	@Override
	public int insertResearch(ResearchVO vo) throws Exception {
		return researchMapper.insertResearch(vo);
	}

	@Override
	public List<?> selectResearchList(DefaultVO vo) throws Exception {
		return researchMapper.selectResearchList(vo);
	}

	@Override
	public int selectResearchTotal(DefaultVO vo) throws Exception {
		return researchMapper.selectResearchTotal(vo);
	}

	@Override
	public ResearchVO selectResearchDetail(ResearchVO vo) throws Exception {
		return researchMapper.selectResearchDetail(vo);
	}

	@Override
	public int updateResearch(ResearchVO vo) throws Exception {
		return researchMapper.updateResearch(vo);
	}

}

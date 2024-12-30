package donghwa.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import donghwa.service.DefaultVO;
import donghwa.service.ResearchService;
import donghwa.service.ResearchVO;

/*컨트롤러 어노테이션*/
@Controller
public class ResearchController {

	@Resource(name="researchService")
	ResearchService researchService;
	
	@RequestMapping("/researchList.do")
	public String selectResearchList(DefaultVO vo,ModelMap model) throws Exception {
		
		// 현재 출력 페이지 번호
		int pageIndex = vo.getPageIndex(); // default: 1
		int pageUnit = vo.getPageUnit();   // default: 10
		
		int total = researchService.selectResearchTotal(vo);
		
		// 총 페이지 수
		int totalpage = (int) Math.ceil((double)total/pageUnit);
		
		// 출력 페이지의 시작번호  ex) 3page -> 100 - (3-1)x10
		int recordCountPerPage = total - (pageIndex-1)*pageUnit;

		// 1:1 , 2:11, 3:21 ~~
		// (3-1)*10 + 1 :: (현재페이지번호-1)*출력개수 + 1
		int firstIndex = (pageIndex-1)*pageUnit + 1;
		int lastIndex  = firstIndex + (pageUnit-1);
		
		vo.setFirstIndex(firstIndex);
		vo.setLastIndex(lastIndex);
		
		// 검색, 페이징
		List<?> list = researchService.selectResearchList(vo);
		
		model.addAttribute("list", list);
		model.addAttribute("total", total);
		model.addAttribute("totalpage", totalpage);
		model.addAttribute("recordCount", recordCountPerPage);

		return "admin/researchList";
	}
	
	@RequestMapping("/researchWrite.do")
	public String researchWrite() throws Exception {
		
		return "admin/researchWrite";
	}
	
	@RequestMapping("/researchModify.do")
	public String selectResearchModify(  ResearchVO vo
										,ModelMap model) throws Exception {
		
		vo = researchService.selectResearchDetail(vo);
		model.addAttribute("vo",vo);
		
		return "admin/researchModify";
	}
	
	@RequestMapping("/researchInsert.do")
	@ResponseBody
	public String insertResearch(ResearchVO vo) throws Exception {

		String msg = "ok";
		int result = researchService.insertResearch(vo);
		if(result == 0) {
			msg = "fail";
		}
		return msg;
	}

	@RequestMapping("/researchUpdate.do")
	@ResponseBody
	public String updateResearch(ResearchVO vo) throws Exception {
	
		String msg = "ok";
		int result = researchService.updateResearch(vo);
		if(result == 0) {
			msg = "fail";
		}
		return msg;
	}
}







package donghwa.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/*컨트롤러 어노테이션*/
@Controller
public class ResearchController {

	@RequestMapping("/researchList.do")
	public String selectResearchList() throws Exception {
		
		return "admin/researchList";
	}
	
	@RequestMapping("/researchWrite.do")
	public String researchWrite() throws Exception {
		
		return "admin/researchWrite";
	}
	
}

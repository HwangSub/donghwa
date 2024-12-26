package donghwa.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Test1 {

	public static void main(String[] args) {

		Map<String,String> map = new HashMap<String,String>();
		map.put("2024-12-25", "성탄절");
		map.put("2024-12-7", "대설");
		
		String tt1 = "2024-12";
		for(int d=1; d<=31; d++) {
			String tt2 = tt1+"-"+d;
			if(map.get(tt2) != null) {
				System.out.println( tt2 + " :: " + map.get(tt2) );
			}
		}
		System.out.println("----------------------");
		
		List<String> list = new ArrayList<String>();
		list.add("성탄절");   // 0
		list.add("대설");    // 1
		for( int i=0; i<10; i++ ) {
			System.out.println(list.get(i));
		}
	}

}

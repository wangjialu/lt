package servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import dao.CommonDao;

/**
 * Servlet implementation class LMqServlet
 */
@WebServlet("/LMqServlet")
public class LMqServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private static CommonDao cd = new CommonDao();
   /**
    * 李明强
    * 
    */
    public LMqServlet() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setHeader("Content-type", "text/javascript;charset=UTF-8");
		response.setHeader("Access-Control-Allow-Origin", "*");
		
		
		//获取产品表
		String getProduct = request.getParameter("getProduct");
		if(getProduct != null){
			System.out.println("进来了");
			getProduct(request,response,JSONObject.parseObject(getProduct));
		}
		//获取厂家表
		String getmanufacturer = request.getParameter("getmanufacturer");
		if(getmanufacturer != null){
			getmanufacturer(request,response,JSONObject.parseObject(getmanufacturer));
		}
		//插入产品信息
		String insertProduct = request.getParameter("insertProduct");
		if(insertProduct != null){
			insertProduct(request,response,JSONObject.parseObject(insertProduct));
		}
		//更新产品信息
		String updateProduct = request.getParameter("updateProduct");
		if(updateProduct != null){
			updateProduct(request,response,JSONObject.parseObject(updateProduct));
		}
		
		//删除产品信息
		String deleteProduct = request.getParameter("deleteProduct");
		if(deleteProduct != null){
			deleteProduct(request,response,JSONObject.parseObject(deleteProduct));
		}
		
		//插入厂家信息
		String insertManufacturer = request.getParameter("insertManufacturer");
		if(insertManufacturer != null){
			insertManufacturer(request,response,JSONObject.parseObject(insertManufacturer));
		}
		//更新厂家信息
		String updataManufacturer = request.getParameter("updataManufacturer");
		if(updataManufacturer != null){
			updataManufacturer(request,response,JSONObject.parseObject(updataManufacturer));
		}
		//删除厂家信息
		String deleteManufacturer = request.getParameter("deleteManufacturer");
		if(deleteManufacturer != null ){
			deleteManufacturer(request,response,JSONObject.parseObject(deleteManufacturer));
		}
		
	}
	
	
	public static void insertProduct(HttpServletRequest request,HttpServletResponse response,JSONObject params) throws IOException{
		String product_name = params.getString("product_name");
		String product_standard = params.getString("product_standard");
		String product_unit = params.getString("product_unit");
		String sql1 = "select * from tb_liantong_product where product_name = ? and product_standard = ?";
		String sql2 = "insert INTO tb_liantong_product(product_name,product_standard,product_unit) value(?,?,?);";
		try {
			List<Map<String,Object>> list = cd.executeQuery(sql1, product_name,product_standard);
			if(list != null && list.size() == 1){
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("flag", "repeat");
				String repeat = "["+JSONObject.toJSONString(jsonObject) + "]";
				response.getWriter().print(repeat);
				return;
			}
			int n = cd.executeUpdate(sql2, product_name, product_standard, product_unit);
			if(n == 1){
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("flag", "success");
				String success = "["+JSONObject.toJSONString(jsonObject) + "]";
				//对传至前端的数据如果没有中括号包裹，不会成功传至前端
				response.getWriter().print(success);
			}
		} catch (Exception e) {
			
		}
	}
	public static void getProduct(HttpServletRequest request,HttpServletResponse response,JSONObject params) throws IOException{
		int pageNumber = Integer.parseInt(params.getString("pageNumber"));
		int pageSize =Integer.parseInt(params.getString("pageSize"));
		//查询记录总条数
		String sql = "select count(*) as count from tb_liantong_product";
		String sql1 = "select * from tb_liantong_product LIMIT ?,?";
		try {
			List<Map<String,Object>> list = cd.executeQuery(sql);
			List<Map<String,Object>> list1 = cd.executeQuery(sql1,(pageNumber-1)*pageSize,pageSize);
			
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("total", list.get(0).get("count"));
			jsonObject.put("data",list1);
			
			String json = "[" +JSONObject.toJSONString(jsonObject) + "]";//map转json，必须前后加入中括号，才可在前端显示
			response.getWriter().print(json);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	public static void getmanufacturer(HttpServletRequest request,HttpServletResponse response,JSONObject params) throws IOException{
		int product_id = Integer.parseInt(params.getString("product_id"));
		int pageNumber = Integer.parseInt(params.getString("pageNumber"));
		int pageSize =Integer.parseInt(params.getString("pageSize"));
		String sql = "select count(*) as count from tb_liantong_manufacturer where product_id = ?";
		String sql1 = "select * from tb_liantong_manufacturer where product_id = ? LIMIT ?,?";
		try {
			List<Map<String,Object>> list = cd.executeQuery(sql, product_id);
			List<Map<String,Object>> list1 = cd.executeQuery(sql1, product_id, (pageNumber-1)*pageSize, pageSize);
			JSONObject object = new JSONObject();
			object.put("total", list.get(0).get("count"));
			object.put("data", list1);
			String json = "[" +JSONObject.toJSONString(object) + "]";
			response.getWriter().print(JSONObject.toJSONString(json));
		} catch (Exception e) {
			
		}
	}
	public static void deleteProduct(HttpServletRequest request,HttpServletResponse response,JSONObject params) throws IOException{
		int product_id = params.getIntValue("product_id");
		//String sql = "delete p,m from tb_liantong_product as p JOIN tb_liantong_manufacturer "
			//		+ "as m on (m.product_id = p.product_id) where p.product_id = ?";
		String sql = "delete  from tb_liantong_manufacturer where product_id = ?";
		String sql1 = "delete  from tb_liantong_product where product_id = ?";
		try {
			cd.executeUpdate(sql, product_id);
			int n = cd.executeUpdate(sql1, product_id);
			System.out.println(n);
			if(n == 1){
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("flag", "success");
				String success = "["+JSONObject.toJSONString(jsonObject) + "]";
				//对传至前端的数据如果没有中括号包裹，不会成功传至前端
				response.getWriter().print(success);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	public static void insertManufacturer(HttpServletRequest request,HttpServletResponse response,JSONObject params) throws IOException{
		int product_id = params.getIntValue("product_id");
		String manufacturer_name = params.getString("manufacturer_name");
		float manufacturer_price = params.getFloatValue("manufacturer_price");
		String sql = "insert into tb_liantong_manufacturer(manufacturer_name,manufacturer_price,product_id) value(?,?,?)";
		try {
			int n = cd.executeUpdate(sql, manufacturer_name, manufacturer_price, product_id);
			if(n == 1){
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("flag", "success");
				String success = "["+JSONObject.toJSONString(jsonObject) + "]";
				//对传至前端的数据如果没有中括号包裹，不会成功传至前端
				response.getWriter().print(success);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	public static void deleteManufacturer(HttpServletRequest request,HttpServletResponse response,JSONObject params) throws IOException{
		int manufacturer_id = params.getIntValue("manufacturer_id");
		String sql = "delete from tb_liantong_manufacturer where manufacturer_id = ?";
		try {
			int n = cd.executeUpdate(sql, manufacturer_id);
			if(n == 1){
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("flag", "success");
				String success = "["+JSONObject.toJSONString(jsonObject) + "]";
				//对传至前端的数据如果没有中括号包裹，不会成功传至前端
				response.getWriter().print(success);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	public static void updataManufacturer(HttpServletRequest request,HttpServletResponse response,JSONObject params) throws IOException{
		String manufacturer_name = params.getString("manufacturer_name");
		float manufacturer_price = params.getFloatValue("manufacturer_price");
		int manufacturer_id = params.getIntValue("manufacturer_id");
		int product_id = params.getIntValue("product_id");
		String sql = "update tb_liantong_manufacturer as m set m.manufacturer_name = ?, "
					+ "m.manufacturer_price = ? where m.manufacturer_id = ? and m.product_id = ?";
		try {
			int n = cd.executeUpdate(sql, manufacturer_name,manufacturer_price,manufacturer_id,product_id);
			if(n == 1){
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("flag", "success");
				String success = "["+JSONObject.toJSONString(jsonObject) + "]";
				//对传至前端的数据如果没有中括号包裹，不会成功传至前端
				response.getWriter().print(success);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	public static void updateProduct(HttpServletRequest request,HttpServletResponse response,JSONObject params) throws IOException{
		int product_id = params.getIntValue("product_id");
		String product_name = params.getString("product_name");
		String product_standard = params.getString("product_standard");
		String product_unit = params.getString("product_unit");
		String sql = "select * from tb_liantong_product as p where "
				+ "p.product_name = ? and p.product_standard = ?";
		String sql1 = "update tb_liantong_product as p set p.product_name = ?, "
				+ "p.product_standard = ?, p.product_unit = ? where p.product_id = ?";
		JSONObject jsonObject = new JSONObject();
		try {
			List<Map<String,Object>> list = cd.executeQuery(sql, product_name, product_standard);
			if(list != null && list.size() == 1){
				jsonObject.put("flag", "repeat");
				String flag = "["+JSONObject.toJSONString(jsonObject) + "]";
				response.getWriter().print(flag);
				return;
			}
			int n = cd.executeUpdate(sql1, product_name, product_standard, product_unit, product_id);
			if(n == 1){
				jsonObject.put("flag", "success");
				String success = "["+JSONObject.toJSONString(jsonObject) + "]";
				//对传至前端的数据如果没有中括号包裹，不会成功传至前端
				response.getWriter().print(success);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}
}

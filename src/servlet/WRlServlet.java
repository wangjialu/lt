package servlet;

import java.io.IOException;
import java.net.Inet4Address;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
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
import util.GetIp;

/**
 * Servlet implementation class LMqServlet
 */
@WebServlet("/WRlServlet")
public class WRlServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private static CommonDao cd = new CommonDao();
   /**
    * 鏉庢槑寮�
    * 
    */
    
    public WRlServlet() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setHeader("Content-type", "text/javascript;charset=UTF-8");
		response.setHeader("Access-Control-Allow-Origin", "*");
		String getUser = request.getParameter("getUser");
		if(getUser != null){
			String userName = request.getParameter("name");
			String userPass = request.getParameter("pass");
			UserLogin(request,response,userName,userPass);
		}
		String setUser=request.getParameter("setUser");
		if(setUser!=null){
			AddUser(request,response);
		}
		String getUserShow= request.getParameter("getUserShow");
		if(getUserShow!=null){
			UserShow(request,response,getUserShow);
		}
		String getlogShow= request.getParameter("getlogShow");
		if(getlogShow!=null){
			LogShow(request,response,getlogShow);
		}
		String userUpdate= request.getParameter("userUpdate");
		if(userUpdate!=null){
			myUserUpdate(request,response,userUpdate);
		}
		String deleteUser= request.getParameter("deleteUser");
		if(deleteUser!=null){
			mydeleteUser(request,response,deleteUser);
		}
		String getTimeShow= request.getParameter("getTimeShow");
		if(getTimeShow!=null){
			mySelectTime(request,response,getTimeShow);
		}
		String getIPshow= request.getParameter("getIPshow");
		if(getIPshow!=null){
			
			mySelectIP(request,response,getIPshow);
		}
		
		String getIDshow= request.getParameter("getIDshow");
		if(getIDshow!=null){
			mySelectID(request,response,getIDshow);
		}
	   }
	public static void mySelectID(HttpServletRequest request,HttpServletResponse response,String id) throws IOException{
		
		JSONObject page = JSONObject.parseObject(id);
		String myIP=page.getString("myIP");
		int pageNumber = Integer.parseInt(page.get("pageNumber").toString());
		int pageSize = Integer.parseInt(page.get("pageSize").toString());
		String sql1 = "SELECT * FROM tb_liantong_log WHERE log_user_id=? LIMIT ?,?";
		String sql = "select count(*) as count from tb_liantong_log";
		List<Map<String,Object>> list = cd.executeQuery(sql);
		List<Map<String,Object>> list1 = cd.executeQuery(sql1,myIP,(pageNumber-1) * pageSize, pageSize);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("total", list.get(0).get("count"));
		jsonObject.put("data",list1);
		String json = "[" +JSONObject.toJSONString(jsonObject) + "]";
		response.getWriter().print(json);
	}
	public static void mySelectTime(HttpServletRequest request,HttpServletResponse response,String getTimeShow) throws IOException{
		JSONObject page = JSONObject.parseObject(getTimeShow);
		String sTime=page.getString("sTime");
		String eTime=page.getString("eTime");
		int pageNumber = Integer.parseInt(page.get("pageNumber").toString());
		int pageSize = Integer.parseInt(page.get("pageSize").toString());
		String sql1 = "SELECT * FROM tb_liantong_log WHERE log_user_time>=? AND log_user_time<=? LIMIT ?,?";
		String sql = "select count(*) as count from tb_liantong_log";
		List<Map<String,Object>> list = cd.executeQuery(sql);
		List<Map<String,Object>> list1 = cd.executeQuery(sql1,sTime,eTime,(pageNumber-1) * pageSize, pageSize);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("total", list.get(0).get("count"));
		jsonObject.put("data",list1);
		String json = "[" +JSONObject.toJSONString(jsonObject) + "]";
		response.getWriter().print(json);
	}
	public static void mySelectIP(HttpServletRequest request,HttpServletResponse response,String ip) throws IOException{
		JSONObject page = JSONObject.parseObject(ip);
		String myIP=page.getString("myIP");
		System.out.println(myIP);
		int pageNumber = Integer.parseInt(page.get("pageNumber").toString());
		int pageSize = Integer.parseInt(page.get("pageSize").toString());
		String sql1 = "SELECT * FROM tb_liantong_log WHERE log_user_ip=? LIMIT ?,?";
		String sql = "select count(*) as count from tb_liantong_log";
		List<Map<String,Object>> list = cd.executeQuery(sql);
		List<Map<String,Object>> list1 = cd.executeQuery(sql1,myIP,(pageNumber-1) * pageSize, pageSize);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("total", list.get(0).get("count"));
		jsonObject.put("data",list1);
		String json = "[" +JSONObject.toJSONString(jsonObject) + "]";
		response.getWriter().print(json);
	}
	public static void mydeleteUser(HttpServletRequest request,HttpServletResponse response,String userUpdate) throws IOException{
		  JSONObject mydeleteUser = JSONObject.parseObject(userUpdate);
		  String user_id=mydeleteUser.get("user_id").toString();
		  try {
			  String sql="delete  from tb_liantong_user where user_id =?";
			  int a=  cd.executeUpdate(sql, user_id);
			  if(a==1){
				  JSONObject jsonObject=new JSONObject();
				  jsonObject.put("msg", 1);
				  
			  }else {
				  JSONObject jsonObject=new JSONObject();
				  jsonObject.put("msg", 2);
			}
		} catch (Exception e) {
			
		}
		
		  
	}
	   public static void myUserUpdate(HttpServletRequest request,HttpServletResponse response,String userUpdate) throws IOException{
		   JSONObject userUpdate1 = JSONObject.parseObject(userUpdate);
		   String user_id=userUpdate1.get("user_id").toString();
		   String user_name=userUpdate1.get("user_name").toString();
		   String user_password=userUpdate1.get("user_password").toString();
		   String user_realname=userUpdate1.get("user_realname").toString();
		   String user_department=userUpdate1.get("user_department").toString();
		   String sql = "UPDATE tb_liantong_user SET user_name=?,user_password=?,user_realname=?,user_department=? WHERE user_id=?";
		   String option="修改了ID为"+user_id+"的："+user_name+"-"+user_password+"-"+user_realname+"-"+user_department;
		 //  SetUserLog(request,response,option);
		  int a= cd.executeUpdate(sql, user_name,user_password,user_realname,user_department,user_id);
		  if(a==1){
			  JSONObject jsonObject=new JSONObject();
			  jsonObject.put("msg", 1);
		  }else{
			  JSONObject jsonObject=new JSONObject();
			  jsonObject.put("msg", 2);
		  }
		   
	   }
        public static void LogShow(HttpServletRequest request,HttpServletResponse response,String getlogShow) throws IOException{
		JSONObject page = JSONObject.parseObject(getlogShow);
		int pageNumber = Integer.parseInt(page.get("pageNum").toString());
		int pageSize = Integer.parseInt(page.get("pageSize").toString());
		//查询记录总条数
		String sql = "select count(*) as count from tb_liantong_log";
		List<Map<String,Object>> list = cd.executeQuery(sql);
		//获取数据
		String sql1 = "select * from tb_liantong_log LIMIT ?,?";
		List<Map<String,Object>> list1 = cd.executeQuery(sql1,(pageNumber-1) * pageSize, pageSize);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("total", list.get(0).get("count"));
		jsonObject.put("data",list1);
		String json = "[" +JSONObject.toJSONString(jsonObject) + "]";
		response.getWriter().print(json);
	}
	public static void AddUser(HttpServletRequest request,HttpServletResponse response){
		String  SetName = request.getParameter("SetName");
		String  SetPass = request.getParameter("SetPass");
		String  SetR_name = request.getParameter("SetR_name");
		String  dep = request.getParameter("dep");
		String sql2 = "SELECT user_id from tb_liantong_user where user_name=?";
		List<Map<String,Object>> list1 = cd.executeQuery(sql2,SetName);
		if(list1!=null&&list1.size()==1){
			request.setAttribute("registered_error", "账号已被使用");
			try {
				request.getRequestDispatcher("/registered.jsp").forward(request, response);
			} catch (ServletException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}else{
			try {
				registered(request,response,SetName,SetPass,SetR_name,dep);
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			try {
				request.getRequestDispatcher("/success_registered.jsp").forward(request, response);
			} catch (ServletException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	public static void UserLog(HttpServletRequest request,HttpServletResponse response,String ip,String NewDate,String log,int userID) throws IOException{
		String sql="INSERT INTO tb_liantong_log(log_user_ip,log_user_time,log_user_option,log_user_id) VALUES(?,?,?,?)";
		int a=cd.executeUpdate(sql, ip,NewDate,log,userID);
		if(a==1){
	
		}else{
			
		}
	}
	public static void SetUserLog(HttpServletRequest request,HttpServletResponse response,String log) throws IOException{
		GetIp a=new GetIp();
		String ip=a.getInternetIp();
		Date date = new Date();
		SimpleDateFormat dateFormat= new SimpleDateFormat("yyyy-MM-dd");
		String NewDate=dateFormat.format(date);
		int userID=(int) request.getAttribute("logid");
		WRlServlet.UserLog(request, response, ip, NewDate, log, userID); 
	}
	public static void registered(HttpServletRequest request,HttpServletResponse response,String name,String pass,String realName,String userDepartment) throws IOException{
		String sql="INSERT INTO tb_liantong_user(user_name,user_password,user_realname,user_department) VALUES(?,?,?,?)";
		int a=cd.executeUpdate(sql,name,pass,realName,userDepartment);
	}
	
	public static void UserLogin(HttpServletRequest request,HttpServletResponse response,String name,String pass) throws IOException{
		String sql2 = "SELECT user_id from tb_liantong_user where user_name=? and user_password=? ";
		
		String log="登陆";
		List<Map<String,Object>> list1 = cd.executeQuery(sql2,name,pass);
		if(list1!=null&&list1.size()==1){
			try {
				   int userId= (int) list1.get(0).get("user_id");
				   request.setAttribute("logid", userId);
				   WRlServlet.SetUserLog(request, response,log); 
				   request.getRequestDispatcher("/ltindex.jsp").forward(request, response);
			} catch (ServletException e) {
				e.printStackTrace();
			}
		}else{
			try {
				request.setAttribute("error", "登陆失败，账号错误");
				request.getRequestDispatcher("/login.jsp").forward(request, response);
			} catch (ServletException e) {
				e.printStackTrace();
			}
		}
	}
	public static void UserShow(HttpServletRequest request,HttpServletResponse response,String UserShow) throws IOException{

		JSONObject page = JSONObject.parseObject(UserShow);
		int pageNumber = Integer.parseInt(page.get("pageNum").toString());
		int pageSize = Integer.parseInt(page.get("pageSize").toString());
		//查询记录总条数
		String sql = "select count(*) as count from tb_liantong_user";
		List<Map<String,Object>> list = cd.executeQuery(sql);
		//获取数据
		String sql1 = "select * from tb_liantong_user LIMIT ?,?";
		List<Map<String,Object>> list1 = cd.executeQuery(sql1,(pageNumber-1) * pageSize, pageSize);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("total", list.get(0).get("count"));
		jsonObject.put("data",list1);
		String json = "[" +JSONObject.toJSONString(jsonObject) + "]";
		response.getWriter().print(json);
	}
}



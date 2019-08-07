<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="en">
	<head>
		<meta charset="utf-8">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1">  
	    <title>管理员 注册界面</title>
        <meta name="description" content="">
        <meta name="author" content="templatemo">
         <script type="text/javascript" src="js/jquery.min.js"></script>
	    <link href="css/font-awesome.min.css" rel="stylesheet">
	    <link href="css/bootstrap.min.css" rel="stylesheet">
	    <link href="css/templatemo-style.css" rel="stylesheet">
	   
	</head>
	<script type="text/javascript">
 $(function(){
	 var cont=document.getElementById("p1");
	 if(cont.value=="null"){
		 $("#p1").hide();//隐藏
	 }else{
		 $("#p1").show();//显示
	 }
	 });

 function validate_required(field,alerttxt)
 {
 with (field)
   {
   if (value==null||value=="")
     {alert(alerttxt);return false}
   else {return true}
   }
 }

 function validate_form(thisform)
 {
 with (thisform)
   {
   if (validate_required(SetName,"账号必须填写")==false)
     {SetName.focus();return false}
   if (validate_required(SetPass,"密码必须填写")==false)
   {SetPass.focus();return false}
   if (validate_required(SetR_name,"真实姓名必须填写")==false)
   {SetR_name.focus();return false}
   if (validate_required(dep,"岗位必须填写")==false)
   {dep.focus();return false}
   }
 
 }
</script>
	<body class="light-gray-bg">
		<div class="templatemo-content-widget templatemo-login-widget white-bg">
			<header class="text-center">
	          <div class="square"></div>
	          <h1>管理员注册</h1>
	        </header>
	        <form onsubmit="return validate_form(this)" action="/lt/WRlServlet?setUser=1" class="templatemo-login-form" method="post">
	        	<div class="form-group">
	        		<div class="input-group">
		        		<div class="input-group-addon"><i class="fa fa-user fa-fw"></i></div>	        		
		              	<input id="SetName" name="SetName"type="text" class="form-control" placeholder="请设置您的账号">           
		          	</div>	
	        	</div>
	        	<div class="form-group">
	        		<div class="input-group">
		        		<div class="input-group-addon"><i class="fa fa-key fa-fw"></i></div>	        		
		              	<input id="SetPass" name="SetPass" type="text" class="form-control" placeholder="请设置密码">           
		          	</div>	
	        	</div>
	        	<div class="form-group">
	        		<div class="input-group">
		        		<div class="input-group-addon"><i class="fa fa-key fa-fw"></i></div>	        		
		              	<input id="SetR_name" name="SetR_name" type="text" class="form-control" placeholder="请填写姓名">           
		          	</div>	
	        	</div>
	        	<div class="form-group">
	        		<div class="input-group">
		        		<div class="input-group-addon"><i class="fa fa-key fa-fw"></i></div>	        		
		              	<input id="dep" name="dep" type="text" class="form-control" placeholder="请填写岗位">           
		          	</div>	
	        	</div> 	          	
	          	<div class="form-group">
				    <div class="checkbox squaredTwo">
		
				    </div>				    
				</div>
				<div class="form-group">

				<input  style="border-style:none" id="p1" type="text" value="<%=request.getAttribute("registered_error") %>" >  
					<button type="submit" class="templatemo-blue-button width-100">注册</button>
				</div>
	        </form>
		</div>
		<div class="templatemo-content-widget templatemo-login-widget templatemo-register-widget white-bg">
			<p>已经注册过了吗？ <strong>	<a  href="/lt/login.html"  class="templatemo-blue-button width-100">重新登录</a></strong></p>
		</div>
	</body>
</html>
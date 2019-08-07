<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
	<head>
		<meta charset="utf-8">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1">  
	    <title>管理员登陆</title>
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
</script>

	<body class="light-gray-bg">
	<br>
		<br>
			<br>
		<div class="templatemo-content-widget templatemo-login-widget white-bg">
			<header class="text-center">
	          <div class="square"></div>
	         	<h1>管理员登陆</h1>
	        </header>
	        <form action="/lt/WRlServlet?getUser=1"  class="templatemo-login-form" method="post">
	        	<div class="form-group">
	        		<div class="input-group">
		        		<div class="input-group-addon"><i class="fa fa-user fa-fw"></i></div>	        		
		              	<input name="name"type="text" class="form-control" placeholder="请输入账号">           
		          	</div>	
	        	</div>
	        	<div class="form-group">
	        		<div class="input-group">
		        		<div class="input-group-addon"><i class="fa fa-key fa-fw"></i></div>	        		
		              	<input name="pass" type="password" class="form-control" placeholder="请输入密码">           
		          	</div>	
	        	</div>	          	
	          	<div class="form-group">
				    <div class="checkbox squaredTwo">
				        <input type="checkbox" id="c1" name="cc" />
				    </div>				    
				</div>
				<div class="form-group">
				<input  style="border-style:none" id="p1" type="text" value="<%=request.getAttribute("error") %>" >  
				<br>
				<br>
					<button  type="submit" class="templatemo-blue-button width-100">登陆</button>
				</div>
	        </form>
		</div>
		<div class="templatemo-content-widget templatemo-login-widget templatemo-register-widget white-bg">
			<p>没有注册账号吗？<strong><a href="/lt/registered.jsp" class="blue-text">点击我注册账号</a></strong></p>
		</div>
	</body>
</html>
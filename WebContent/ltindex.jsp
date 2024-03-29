<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<meta charset="utf-8" />
		<title>EasyUI Demo</title>
		<link rel="stylesheet" type="text/css" href="css/themes/default/easyui.css" />
	    <link rel="stylesheet" type="text/css" href="css/themes/icon.css" />
	    <link rel="stylesheet" type="text/css" href="css/common.css" />
	    <script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
		<script type="text/javascript" src="js/json2.js"></script>
		<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="js/easyUI-common.js"></script>	
	</head>
	<body class="easyui-layout" id="layout" style="visibility:hidden;">
		
		<div region="north" id="header">
			<img src="img/logo.png" class="logo" />
			<div class="top-btns">
				<span>欢迎您，管理员</span>
				<a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-lock'">修改密码</a>
				<a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-clear'">退出系统</a>
				<select class="easyui-combobox" data-options="editable:false">
					<option value="0" selected="selected">中文</option>
					<option value="1">English</option>
				</select>
			</div>
		</div>
		
		<div region="west" split="true" title="导航菜单" id="naver">
			<div class="easyui-accordion" fit="true" id="navmenu">
				<div title="指标体系">
					<ul class="navmenu">
						<li class="active"><a href="#">首页</a></li>	
						<li><a href="#" data-url="dataShow/userShow.jsp">用户管理</a></li>
						<li><a href="#" data-url="dataShow/product.jsp">产品列表</a></li>
						<li><a href="#" data-url="dataShow/logShow.jsp">日志列表</a></li>
					</ul>
				</div>
				<div title="绩效考核"></div>
				<div title="报表管理"></div>
				<div title="系统管理"></div>
				<div title="组件示例">
					<ul class="navmenu">
						<li><a href="#" data-url="html/demo01.html">锁定行和列</a></li>
					</ul>
				</div>
			</div>
		</div>
		
		<div region="center" id="content">
			<div class="easyui-tabs" fit="true" id="tt">
				
				<div title="首页" iconCls="icon-ok">
					<div class="easyui-accordion" data-options="fit:true">
						<div title="待办事项">
							<div class="flow-panel">
								<div class="flow-todo">
									<ul class="todo-list">
										<li>
											<span>代办事项 A</span>
											<a href="#" class="num">5</a>
										</li>
										<li>
											<span>代办事项 B</span>
											<a href="#" class="num">5</a>
										</li>
										<li>
											<span>代办事项 C</span>
											<a href="#" class="num">5</a>
										</li>
										<li>
											<span>代办事项 D</span>
											<a href="#" class="num">5</a>
										</li>
										<li>
											<span>代办事项 E</span>
											<a href="#" class="num">5</a>
										</li>
										<li>
											<span>代办事项 F</span>
											<a href="#" class="num">5</a>
										</li>
									</ul>
								</div>
							</div>
						</div>
						<div title="系统公告">
							<ul class="notice-list">
								<li>
									<span>这是一条系统公告系统公告系统公告系统公告系统公告系统公告系统公告系统公告系统公告</span>
									<span class="date">2015-10-30</span>
								</li>
								<li>
									<span>这是一条系统公告系统公告系统公告系统公告系统公告系统公告系统公告系统公告系统公告</span>
									<span class="date">2015-10-30</span>
								</li>
								<li>
									<span>这是一条很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长的系统公告</span>
									<span class="date">2015-10-30</span>
								</li>
								<li>
									<span>这是一条系统公告系统公告系统公告系统公告系统公告系统公告系统公告系统公告系统公告</span>
									<span class="date">2015-10-30</span>
								</li>
								<li>
									<span>这是一条系统公告系统公告系统公告系统公告系统公告系统公告系统公告系统公告系统公告</span>
									<span class="date">2015-10-30</span>
								</li>
							</ul>
						</div>
					</div>
				</div>
				
			</div>
		</div>
		
		<div region="south" id="footer">某某后台管理系统 V1.0</div>
		
		<script type="text/javascript">
			$(function() {
				//添加新的Tab页
				$("#navmenu").on("click", "a[data-url]", function(e) {
					e.preventDefault();
					var tabTitle = $(this).text();
					var tabUrl = $(this).data("url");
					if($("#tt").tabs("exists", tabTitle)) { //判断该Tab页是否已经存在
						$("#tt").tabs("select", tabTitle);
					}else {
						var content="<iframe frameborder='0' scrolling='auto' "
						 + "style='width:100%;height:100%;' src="+tabUrl+ "></iframe>" ;
						$("#tt").tabs("add", {
							title: tabTitle,
							//href: tabUrl,
							closable: true,
							content:content
						});
					}
					$("#navmenu .active").removeClass("active");
					$(this).parent().addClass("active");
				});
				
				//解决闪屏的问题
				window.setTimeout(function() {
					$("#layout").css("visibility", "visible");
				}, 800);
			});
		</script>
		
	</body>
</html>

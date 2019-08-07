<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Frozen Columns in DataGrid - jQuery EasyUI Demo</title>
	<link rel="stylesheet" type="text/css" href="css/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="css/themes/icon.css">
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/json2.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
</head>
<body>
	<table id="datagrid" title="商品厂家报价表" style="width:1000px;height:400px"
	data-options="toolbar:'#toolbar',fitColumns:true,border:true,remoteSort:true,rownumbers:true,showFooter: true,singleSelect:true,collapsible:true,pagination:true,"></table>

	<!-- 数据表工具栏 -->
<div class="toolbar" id="toolbar">
	<div class="search-div">
		<label>按名查找：</label>
		<input type="text" class="easyui-textbox"  />	
		<a href="#" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
    </div>
	<div class="ctrl-div">
		<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" id="addProductBtn">新增产品</a>
   		<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" id="editBtn">编辑</a>
    	<a href="#" class="easyui-linkbutton" iconCls="icon-back" plain="true">导入</a>
    	<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true">导出</a>
	</div>
</div>
<!-- /数据表工具栏 -->
<!-- 弹出框 -->
<div class="easyui-dialog" title="新增/编辑" iconCls="icon-save" modal="true"
	closed="true" buttons="#dlg-btns" style="width:400px;height:200px;padding:10px" id="dlg">
	<form id="fm" method="post">
		<div class="fitem">
			<label>产品名称：</label>
			<input class="easyui-textbox" id="product_name"/>
		</div>
		<div class="fitem">
			<label>产品规格：</label>
			<input class="easyui-textbox" id="product_standard"/>
		</div>
		<div class="fitem">
			<label>产品单位：</label>
			<input class="easyui-textbox" id="product_unit"/>
		</div>
	</form>
</div>
<div id="dlg-btns">
	<a href="#" class="easyui-linkbutton" iconCls="icon-ok" id="insertPorductBtn">保存</a>
	<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" id="cancelBtn">取消</a>
</div>
<!-- /弹出框 -->

<script type="text/javascript">
	$(function(){
		var jsonArray = new Array();
		var jsonList = new Array();
		var columns = new Array();
		
		jsonArray = getData(1,10);//获取后端数据并转换为Array
		var jsonTotal = jsonArray[0].total;//json记录总条数
		var jsonData = jsonArray[0].data;//json数据域
		jsonList = getRow(jsonData,jsonData.length - 1);//获取数据域
		
		var j = jsonData[jsonData.length - 1];//获取厂家数量最大值
		columns = getColumn(j.length);//动态拼接表头
		$("#datagrid").datagrid({
	        columns:[
	        	columns
	        ]
	    });
		$("#datagrid").datagrid('loadData',jsonList);
		var pager = $("#datagrid").datagrid("getPager"); 
		pager.pagination({ 
			total:jsonTotal, 
		  	displayMsg:'当前显示从第{from}条到{to}条 共{total}条记录',
		    onSelectPage:function (pageNo, pageSize) { 
	          	var jsonArray = getData(pageNo,pageSize);
				var jsonData = jsonArray[0].data;//json数据域
				var jsonList = getRow(jsonData,jsonData.length - 1);
				var jsonTotal = jsonArray[0].total;	
				$("#datagrid").datagrid('loadData',jsonList);
				var pager = $("#datagrid").datagrid("getPager"); 
				pager.pagination('refresh', { 
    				total:jsonTotal, 
        			pageNumber:pageNo
    			});
		    }
		});
		//打开弹出框
		$("#addProductBtn, #editBtn").click(function(e) {
			e.preventDefault();
			$("#dlg").dialog("open");
		});
		//关闭弹出框
		$("#saveBtn, #cancelBtn").click(function(e) {
			e.preventDefault();
			$("#dlg").dialog("close");
		});
		$("#insertPorductBtn").click(function(e){
			var product_name = $("#product_name").val();
			var product_standard = $("#product_standard").val();
			var product_unit = $("#product_unit").val();
			if(product_name == "" || product_standard == "" || product_unit == ""){
				center("错误","请输入内容");
				return;
			}
			var obj = {};
			obj["product_name"] = product_name;
			obj["product_standard"] = product_standard;
			obj["product_unit"] = product_unit;
			
			$.ajax({
				url:"LMqServlet",
				type:"post",
				async:false,
				data:{
					insertProduct:JSON.stringify(obj)
				},
				success:function(data){
					var flag = JSON.parse(data);
					if(flag[0].flag == "success"){
						$("#dlg").dialog("close");
						center("成功","添加产品已成功");
					} else if(flag[0].flag == "repeat"){
						center("失败","请不要添加已有产品");
						console.log("重复");
					}
					
				}
			});
		});
	})
	
	
	//拼接表头
	function getColumn(length){
		var columns = new Array();
		var product_id = {
				field:"product_id",
				title:"序号",
				width:"50"
		}
		columns.push(product_id);
		var product_name = {
				field:'product_name',
				title:"产品名称",
				width:"120"
		}
		columns.push(product_name);
		
		var product_standard = {
				field:'product_standard',
				title:"产品规格",
				width:"120"
		}
		columns.push(product_standard);
		
		var product_unit = {
				field:'product_unit',
				title:"产品单位",
				width:"100"
		}
		columns.push(product_unit);
		for(var i = 0;i < length;i++){
			var column = {
				field:"manufacturer_name_" + i,
				width:"120",
				title:"厂家" + (i+1) + "名称"
			};
			columns.push(column);
			column = {
					field:"manufacturer_price_" + i,
					width:"100",
					title:"厂家" + (i+1) + "报价"
			};
			columns.push(column);
		}
		return columns
	}
	//ajax获取数据
	function getData(page,size){
		var jsonArray = new Array();
		var obj = {};
		obj["pageNum"] = page;
		obj["pageSize"] = size;
		$.ajax({
			url:"LMqServlet",
			type:"post",
			async:false,
			data:{
				getProduct:JSON.stringify(obj)
			},
			success:function(data){
				jsonArray = JSON.parse(data);
			}
		});
		return jsonArray; 
	}
	//获取显示页面的数据
	function getRow(data,length){
		var jsonList = new Array();
		//获取数据域
		for(var i = 0;i < length;i++){
			jsonList.push(data[i]);
		}
		return jsonList;
	}
	function center(title,msg){
		$.messager.show({
			title:title,
			msg:msg,
			showType:'fade',
			style:{
				right:'',
				bottom:''
			}
		});
	}
  
</script>
</body>
</html>
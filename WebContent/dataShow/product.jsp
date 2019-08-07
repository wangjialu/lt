<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" type="text/css" href="../css/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="../css/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="../css/common.css">
	<script type="text/javascript" src="../js/jquery.min.js"></script>
	<script type="text/javascript" src="../js/json2.js"></script>
	<script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../js/easyUI-common.js"></script>
</head>
<body>
	<table>
		<tr>
			<td>
			<table id="pdata" class="easyui-datagrid" title="产品目录表" style="width:400px;height:550px"
			data-options="rownumbers:'true',toolbar:'#toolbar',singleSelect:true,collapsible:true,pagination:true,method:'post'">
			<thead>
				<tr>
					<th data-options="field:'product_name',width:100,align:'center'">产品名称</th>
					<th data-options="field:'product_standard',width:150,align:'center'">产品规格</th>
					<th data-options="field:'product_unit',width:50,align:'center'">单位</th>
				</tr>
			</thead>
			</table>
			</td>
			<td>
			<table id="mdata" class="easyui-datagrid" title="厂家价格表" style="width:500px;height:550px"
			data-options="rownumbers:'true',toolbar:'#toolbar1',singleSelect:true,collapsible:true,pagination:true">
			<thead>
				<tr>
					<th data-options="field:'manufacturer_name',width:100,align:'right'">厂家名称</th>
					<th data-options="field:'manufacturer_price',width:100,align:'right'">厂家价格</th>
				</tr>
			</thead>
			</table>
			</td>
		</tr>
	</table>
	<!-- 数据表工具栏 -->
	<div class="toolbar" id="toolbar">
		<div class="search-div">
			<label>按名查找：</label>
			<input type="text" class="easyui-textbox"  />	
			<a href="#" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
   		</div>
		<div class="ctrl-div">
			<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" id="addProductBtn">新增产品</a>
   			<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" id="editProductBtn">编辑产品</a>
    		<a href="#" class="easyui-linkbutton" iconCls="icon-back" plain="true" id="deleteProductBtn">删除产品</a>
		</div>
	</div>
	<div class="toolbar" id="toolbar1">
		<div class="ctrl-div">
			<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" id="addManuBtn">新增厂家</a>
   			<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" id="editManuBtn">编辑厂家</a>
    		<a href="#" class="easyui-linkbutton" iconCls="icon-back" plain="true" id="deleteManuBtn">删除厂家</a>
		</div>
	</div>
	<!-- /数据表工具栏 -->
	<!-- 弹出框 -->
	<div class="easyui-dialog" title="新增" iconCls="icon-save" modal="true"
	closed="true" buttons="#dlg1-btns" style="width:400px;height:200px;padding:10px" id="dlg-add">
		<form id="fm" method="post">
			<div class="fitem">
				<label>产品名称：</label>
				<input class="easyui-textbox" id="product_name-add"/>
			</div>
			<div class="fitem">
				<label>产品规格：</label>
				<input class="easyui-textbox" id="product_standard-add"/>
			</div>
			<div class="fitem">
				<label>产品单位：</label>
				<input class="easyui-textbox" id="product_unit-add"/>
			</div>
		</form>
	</div>
	<div class="easyui-dialog" title="编辑" iconCls="icon-save" modal="true"
	closed="true" buttons="#dlg2-btns" style="width:400px;height:200px;padding:10px" id="dlg-edit">
		<form id="fm" method="post">
			<div class="fitem">
				<label>产品名称：</label>
				<input class="easyui-textbox" id="product_name-edit"/>
			</div>
			<div class="fitem">
				<label>产品规格：</label>
				<input class="easyui-textbox" id="product_standard-edit"/>
			</div>
			<div class="fitem">
				<label>产品单位：</label>
				<input class="easyui-textbox" id="product_unit-edit"/>
			</div>
		</form>
	</div>
	<div class="easyui-dialog" title="新增" iconCls="icon-save" modal="true"
	closed="true" buttons="#dlg3-btns" style="width:400px;height:200px;padding:10px" id="dlg1-add">
		<form id="fm" method="post">
			<div class="fitem">
				<label>厂家名称：</label>
				<input class="easyui-textbox" id="manufacturer_name-add"/>
			</div>
			<div class="fitem">
				<label>厂家价格：</label>
				<input class="easyui-textbox" id="manufacturer_price-add"/>
			</div>
		</form>
	</div>
	<div class="easyui-dialog" title="编辑" iconCls="icon-save" modal="true"
	closed="true" buttons="#dlg4-btns" style="width:400px;height:200px;padding:10px" id="dlg1-edit">
		<form id="fm" method="post">
			<div class="fitem">
				<label>厂家名称：</label>
				<input class="easyui-textbox" id="manufacturer_name-edit"/>
			</div>
			<div class="fitem">
				<label>厂家价格：</label>
				<input class="easyui-textbox" id="manufacturer_price-edit"/>
			</div>
		</form>
	</div>
	<div id="dlg1-btns">
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok" id="insertPorductBtn">保存</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" id="cancelBtn">取消</a>
	</div>
	<div id="dlg2-btns">
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok" id="updataPorductBtn">保存</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" id="cancelBtn1">取消</a>
	</div>
	<div id="dlg3-btns">
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok" id="insertManuBtn">保存</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" id="cancelBtn2">取消</a>
	</div>
	<div id="dlg4-btns">
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok" id="updataManuBtn">保存</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" id="cancelBtn3">取消</a>
	</div>
	<script type="text/javascript">
		$(function(){//自动加载产品表
			reloadProduct();
		});
		$("#pdata").datagrid({//点击行后显示相应的厂家信息
			onClickRow:function(rowIndex,rowData){
				reloadManufacturer(rowData);
			}
		});
		
		//产品表格工具栏=========开始======================
		$("#addProductBtn").click(function(e) {
			e.preventDefault();
			$("#dlg-add").dialog("open");
		});
		$("#editProductBtn").click(function(e){
			var row = $('#pdata').datagrid('getSelected');
			if(row != null){
				$("#dlg-edit").dialog("open");	
				$("#product_name-edit").textbox("setValue",row.product_name);
				$("#product_standard-edit").textbox("setValue",row.product_standard);
				$("#product_unit-edit").textbox("setValue",row.product_unit);
			}else{
				center("错误","请选中要编辑的行");
			}
		});
		$("#deleteProductBtn").click(function(e){
			var row = $("#pdata").datagrid("getSelected");
			var obj = {};
			obj["product_id"] = row.product_id;
			if(row != null){
				$.messager.confirm("错误", "真的要删除吗", function(r){
					if(r){
						var json = getJsonDataByAjax("../LMqServlet","deleteProduct",obj);
						center("成功","删除成功");
						reloadProduct();
					}
					
				});
			}else{
				center("错误","请选中要删除的行");
			}
		});
		//产品表格工具栏=========结束======================
			
		//厂家表格工具栏=========开始======================
		$("#addManuBtn").click(function(e){
			var row = $("#pdata").datagrid("getSelected");
			if(row != null){
				$("#dlg1-add").dialog("open");	
			}else{
				center("错误","请选中要增加厂商的产品");
			}
		});
		$("#editManuBtn").click(function(e){
			var row = $('#mdata').datagrid('getSelected');
			if(row != null){
				$("#dlg1-edit").dialog("open");	
				$("#manufacturer_name-edit").textbox("setValue",row.manufacturer_name);
				$("#manufacturer_price-edit").textbox("setValue",row.manufacturer_price);
			}else{
				center("错误","请选中要编辑的行");
			}
		});
		$("#deleteManuBtn").click(function(e){
			var row = $("#mdata").datagrid("getSelected");
			if(row != null){
				var obj = {};
				obj["manufacturer_id"] = row.manufacturer_id;
				$.messager.confirm("错误", "真的要删除吗", function(r){
					if(r){
						var json = getJsonDataByAjax("../LMqServlet","deleteManufacturer",obj);
						center("成功","删除成功");
						reloadManufacturer(row);
					}
				});
			}else{
				center("错误","请选中删除的行");
			}
		});
		//厂家表格工具栏=========结束======================
		//产品插入及更新方法================开始============
		$("#insertPorductBtn").click(function(e){
			var product_name = $("#product_name-add").val();
			var product_standard = $("#product_standard-add").val();
			var product_unit = $("#product_unit-add").val();
			if(product_name == "" || product_standard == "" || product_unit == ""){
				center("错误","请输入内容");
				return;
			}
			var obj = {};
			obj["product_name"] = product_name;
			obj["product_standard"] = product_standard;
			obj["product_unit"] = product_unit;
			var flag = JSON.parse(getJsonDataByAjax("../LMqServlet","insertProduct",obj));
			if(flag[0].flag == "success"){
				$("#dlg-add").dialog("close");
				center("成功","添加产品已成功");
				$("#fm").form("clear");
			} else if(flag[0].flag == "repeat"){
				center("失败","请不要添加已有产品");
				console.log("重复");
			}	
			reloadProduct();
		});	
		$("#updataPorductBtn").click(function(e){
			var row = $('#pdata').datagrid('getSelected');
			var obj = {};
			obj["product_id"] = row.product_id;
			obj["product_name"] = $("#product_name-edit").val();
			obj["product_standard"] = $("#product_standard-edit").val();
			obj["product_unit"] = $("#product_unit-edit").val();
			var jsonData = JSON.parse(getJsonDataByAjax("../LMqServlet","updateProduct",obj));
			if(jsonData[0].flag == 'repeat'){
				center("错误","输入产品信息重复");
			}else if(jsonData[0].flag == 'success'){
				center("成功","操作成功");
				$("#dlg-edit").dialog("close");
			}
			reloadProduct();
		});
		//产品插入及更新方法================结束============
		$("#insertManuBtn").click(function(e){
			var row = $("#pdata").datagrid("getSelected");
			var manufacturer_name = $("#manufacturer_name-add").val();
			var manufacturer_price = $("#manufacturer_price-add").val();
			if(manufacturer_name == "" || manufacturer_price == ""){
				center("错误","请输入内容");
				return;
			}
			var obj = {};
			obj["product_id"] = row.product_id;
			obj["manufacturer_name"] = manufacturer_name;
			obj["manufacturer_price"] = manufacturer_price;
			var flag = JSON.parse(getJsonDataByAjax("../LMqServlet","insertManufacturer",obj));
			if(flag[0].flag == "success"){
				$("#dlg1-add").dialog("close");
				center("成功","添加厂家已成功");
				$("#fm").form("clear");
			} else if(flag[0].flag == "repeat"){
				center("失败","请不要添加已有厂家");
			}	
			reloadManufacturer(row);
		});
		$("#updataManuBtn").click(function(e){
			var row = $("#mdata").datagrid("getSelected");
			var obj = {};
			obj["manufacturer_id"] = row.manufacturer_id;
			obj["manufacturer_name"] = $("#manufacturer_name-edit").val();
			obj["manufacturer_price"] = $("#manufacturer_price-edit").val();
			obj["product_id"] = row.product_id;
			var jsonData = JSON.parse(getJsonDataByAjax("../LMqServlet","updataManufacturer",obj));
			if(jsonData[0].flag == 'success'){
				center("成功","操作成功");
				$("#dlg1-edit").dialog("close");
			}
			reloadManufacturer($("#pdata").datagrid("getSelected"));
		});
		//关闭弹出框
		$("#cancelBtn, #cancelBtn1, #cancelBtn2, #cancelBtn3").click(function(e) {
			e.preventDefault();
			$("#dlg-add").dialog("close");
			$("#dlg-edit").dialog("close");
			$("#dlg1-edit").dialog("close");
			$("#dlg1-add").dialog("close");
		});
		
		function reloadProduct(){
			var obj = {};
			obj["pageNumber"] = 1;
			obj["pageSize"] = 10;
			var json = getJsonDataByAjax("../LMqServlet","getProduct",obj);	
			$("#pdata").datagrid("loadData",JSON.parse(json)[0].data);
			var object = {};	
			paging("#pdata",JSON.parse(json)[0].total,"../LMqServlet","getProduct",object);
		}	
		function reloadManufacturer(rowData){
			var obj={};
			obj["product_id"] = rowData.product_id;
			obj["pageNumber"] =  1;
			obj["pageSize"] = 10;
			var json = JSON.parse(getJsonDataByAjax("../LMqServlet","getmanufacturer",obj));
			$("#mdata").datagrid('loadData',JSON.parse(json)[0].data);
			var object = {};
			object["product_id"] = rowData.product_id;
			paging("#mdata",JSON.parse(json)[0].total,"../LMqServlet","getmanufacturer",object);
		}
	</script>
</body>
</html>
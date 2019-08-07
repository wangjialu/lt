<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Frozen Columns in DataGrid - jQuery EasyUI Demo</title>
	<link rel="stylesheet" type="text/css" href="/lt/css/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="/lt/css/themes/icon.css">
	<script type="text/javascript" src="/lt/js/jquery.min.js"></script>
	<script type="text/javascript" src="/lt/js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="/lt/js/easyUI-common.js"></script>
	<style type="text/css">
.easyui-datebox{
display:inline;
}
.c{
display:inline;
}
.easyui-linkbutton{
display:inline;
}
</style>
</head>

<body>
	<div class="toolbar" id="toolbar">
    <div class="search-div">
      <label>按ID查找：</label>
      <input  id="myID" type="text" class="easyui-textbox"  />  
      <button onclick="getIDshow(1,10)"class="easyui-linkbutton" iconCls="icon-search">搜索</button>
       </div>
          <div class="search-div">
      <label>按IP查找：</label>
      <input  id="myIP" type="text" class="easyui-textbox"  />  
      <button onclick="getIPshow(1,10)"class="easyui-linkbutton" iconCls="icon-search">搜索</button>
       </div>
     <div class="c">开始时间：</div>
	<input   name="sTime" id="sTime" class="easyui-datebox" style="width:210px;height:30px"/>
	<div class="c">结束时间:</div>
	<input   name="eTime" id="eTime" class="easyui-datebox" style="width:210px;height:30px"/>
		 <button class="easyui-linkbutton" onclick="getDataShow(1,10)" name="button" >查询 </button>
  </div>

	<table id="datagrid" class="easyui-datagrid"  style="width:100%;height:400px"
			data-options="rownumbers:true,singleSelect:true,method:'post',pagination:'true'">
		<thead data-options="frozen:true">
			<tr>
				<th data-options="field:'log_user_ip',width:150">IP地址</th>
				<th data-options="field:'log_user_time',width:120">操作时间</th>
				<th data-options="field:'log_user_option',width:120">操作行为</th>
				<th data-options="field:'log_user_id',width:120">操作人员</th>
			</tr>
		</thead>
	</table>
 	<script type="text/javascript">
 	
	 function test() {
			var a =$("#myIP").val;
			alert(a);
		}
	$(function(){
		jsonArray = getData(1,10);//获取后端数据并转换为Array
		var jsonTotal = jsonArray[0].total;//json记录总条数
		var jsonData = jsonArray[0].data;//json数据域
		$("#datagrid").datagrid({
	        title: '日志表',
	        remoteSort: true,
	        showFooter: true,
	        singleSelect: true,
	        rownumbers:true,
	        heigth:140,
	        showFooter:true,
	        border: true,
	       	pagination:"true",
	        toolbar:"#toolbar",
	        fitColumns: true,
	    });
		$("#datagrid").datagrid('loadData',jsonData);
		var pager = $("#datagrid").datagrid("getPager"); 
		pager.pagination({ 
			total:jsonTotal, 
		  	displayMsg:'当前显示从第{from}条到{to}条 共{total}条记录',
		    onSelectPage:function (pageNo, pageSize) { 
	          	var jsonArray = getData(pageNo,pageSize);
				var jsonData = jsonArray[0].data;//json数据域
				var jsonTotal = jsonArray[0].total;	
				$("#datagrid").datagrid('loadData',jsonData);
				var pager = $("#datagrid").datagrid("getPager"); 
				pager.pagination('refresh', { 
    				total:jsonTotal, 
        			pageNumber:pageNo
    			});
		    }
		});
	})
	

	function getData(page,size){
		var jsonArray = new Array();
		var obj = {};
		obj["pageNum"] = page;
		obj["pageSize"] = size;
		$.ajax({
			url:"/lt/WRlServlet",
			type:"post",
			async:false,
			data:{
				getlogShow:JSON.stringify(obj)
			},
			success:function(data){
				console.log(data);
				jsonArray = JSON.parse(data);
				
			}
		});
		return jsonArray; 
	}


	function getDataShow(page,size){
		var obj = {};
		obj["sTime"]=$("#sTime").datebox('getValue');
		obj["eTime"]=$("#eTime").datebox('getValue');
	
		obj["pageNumber"] = page;
		obj["pageSize"] = size;
		var json = getJsonDataByAjax("/lt/WRlServlet","getTimeShow",obj);
		var jsonArray = JSON.parse(json);
		$("#datagrid").datagrid('loadData',jsonArray[0].data);
		var obj1 = {};
		obj1["sTime"]=$("#sTime").datebox('getValue');
		obj1["eTime"]=$("#eTime").datebox('getValue');
		paging("#datagrid",jsonArray[0].total,"/lt/WRlServlet","getTimeShow",obj1)
	}
	function getIPshow(page,size) {
		var obj = {};
		obj["myIP"]=$("#myIP").val();
		obj["pageNumber"] = page;
		obj["pageSize"] = size;
		var json = getJsonDataByAjax("/lt/WRlServlet","getIPshow",obj);
		var jsonArray = JSON.parse(json);
		$("#datagrid").datagrid('loadData',jsonArray[0].data);
		var obj1 = {};
		obj1["myIP"]=$("#myIP").val;
		paging("#datagrid",jsonArray[0].total,"/lt/WRlServlet","getIPshow",obj1)
	}
	function getIDshow(page,size) {
		var obj = {};
		obj["myIP"]=$("#myID").val();
		obj["pageNumber"] = page;
		obj["pageSize"] = size;
		var json = getJsonDataByAjax("/lt/WRlServlet","getIDshow",obj);
		var jsonArray = JSON.parse(json);
		$("#datagrid").datagrid('loadData',jsonArray[0].data);
		var obj1 = {};
		obj1["myIP"]=$("#myID").val;
		paging("#datagrid",jsonArray[0].total,"/lt/WRlServlet","getIPshow",obj1)
	}
	$.fn.datebox.defaults.formatter = function(date) {
	var y = date.getFullYear();
	var m = date.getMonth() + 1;
	var d = date.getDate();
	return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d);
	};
	//
	$.fn.datebox.defaults.parser = function(s) {
	if (s) {
	var a = s.split('-');
	var d = new Date(parseInt(a[0]), parseInt(a[1]) - 1, parseInt(a[2]));
	return d;
	} else {
	return new Date();
	}
	 
	};
	
	
	</script>
	 
</body>
</html>
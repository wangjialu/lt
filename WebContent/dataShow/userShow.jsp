<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Frozen Columns in DataGrid - jQuery EasyUI Demo</title>
	<link rel="stylesheet" type="text/css" href="/lt/css/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="/lt/css/themes/icon.css">
	<script type="text/javascript" src="/lt/js/json2.js"></script>
	<script type="text/javascript" src="/lt/js/jquery.min.js"></script>
	<script type="text/javascript" src="/lt/js/jquery.easyui.min.js"></script>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <style type="text/css">
    	body{
    		font-size:14px;
    	}
    </style>
    <link rel="stylesheet" type="text/css" href="/lt/css/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="/lt/css/themes/icon.css">
	<script type="text/javascript">
		//重写时间框
		$.fn.datebox.defaults.formatter = function(date){
			var y = date.getFullYear();
			var m = date.getMonth()+1;
			var d = date.getDate();
			return y+'-'+m+'-'+d;
		}
		function dataFormatter(value,row,index){
			    var da = value;
			    da = new Date(da);
			    var year = da.getFullYear()+'年';
			    var month = da.getMonth()+1+'月';
			    var date = da.getDate()+'日';
			    return ([year,month,date].join('-'));  
		}
		function clearUpdateForm(){
			$('#ff').form('clear');
		}
		function clearinsertForm(){
			$('#zz').form('clear');
		}
		//查询触发的函数
		/* function queryForm(){
		//$("input[name='empname']").val(); 获取的是jQuery对象  要是用jQuery的方法获取值 
			//使用easyUI的方法获取值
			var empname= $("#empid").textbox('getValue');
			
			//解决后台获取数据乱码问题
			var name1 = encodeURI(empname);
				//这个查询方式=====通过#dg===queryEmp?ename=empname
				$('#datagrid').datagrid('load',{
				//======easyui所有的方法调用   控件对象.控件名称('方法名','方法参数')
				ename:name1
				
			});
		} */
		//修改的方法
		function submitUpdateForm(){
                 //获取选中行的所有信息 以便下面发起请求获取数据id
			var selectedRow=$("#datagrid").datagrid("getSelected");
            var obj = {};
            obj["user_id"] = selectedRow.user_id;
            obj["user_password"] =$("#user_password").val();
            obj["user_name"] =$("#user_name").val();
            obj["user_department"] =$("#user_department").val();
            obj["user_realname"] =$("#user_realname").val();
            
          console.log(JSON.stringify(obj));
                 //表单提交 会获取表单的所有信息
			$.ajax({
				url:"/lt/WRlServlet",
				type:"post",
				async:false,
				data:{
					userUpdate:JSON.stringify(obj)
				},
				success: function(data){
							$.messager.alert('提示消息','修改成功');
							$("#w").window('close');
				}
			})
		}
		//添加toolbar工具栏
		$(function(){
			$("#datagrid").datagrid({
				toolbar:[{
					iconCls:'icon-edit',
					text:'修改',
					onClick:function(){
						var selectedRow=$("#datagrid").datagrid("getSelected");
							if(selectedRow==null){
								$.messager.alert('提示消息','请选择数据');
								return;
							}
						$("#w").window('open');
						//带上原数据
						$("#ff").form('load',selectedRow)
					}
				},{
					iconCls:'icon-remove',
					text:'删除',
					onClick:function(){
						var selectedRow=$("#datagrid").datagrid("getSelected");
			            var obj = {};
			            obj["user_id"] = selectedRow.user_id;
						if(selectedRow==null){
							$.messager.alert('提示消息','请选择数据');
							return;
						}
						var falg;
						$.ajax({
							url:"/lt/WRlServlet",
							type:"post",
							async:false,
							data:{
								deleteUser:JSON.stringify(obj)
							},
							success:function(msg){
								if(msg!=null){
									$.messager.alert('提示消息','删除成功');
									//window.location.reload();
								}else{
									$.messager.alert('错误消息',msg.message);
								}
							}
						});
					}
				}]
			})
		})
	</script>

</head>

<body>
	 <body>
  <!-- 	员工姓名：<input id="empid" class="easyui-textbox" type="text" name="empname" data-options="required:true"></input>
    <a href="javascript:void(0)" style="width:50px" class="easyui-linkbutton" οnclick="queryForm()">查询</a> -->
    <div style="height:5px"></div>
    <table id="datagrid" class="easyui-datagrid"  style="width:600px;height:700px"
				data-options="fitColumns:'true',singleSelect:false,collapsible:true,
				pagination:true,rownumbers:true">
		<thead>
			<tr>
				<th field="ck" checkbox="true"></th>
				<th data-options="field:'user_name',width:100">账号</th>
				<th data-options="field:'user_password',width:120">密码</th>
				<th data-options="field:'user_realname',width:120">姓名</th>
				<th data-options="field:'user_department',width:120">岗位</th>
			</tr>
		</thead>
	</table>
	
	<!-- 修改的div -->
	<div id="w" class="easyui-window" title="修改员工信息" data-options="iconCls:'icon-save',closed:true" 
				style="width:250px;height:300px;padding:5px;">
		<form id="ff" method="post">
		<input type="hidden" name="_method" value="put">
	    		<tr>
	    			<td>账号：</td>
	    			<td><input id="user_name" class="easyui-textbox" type="text" name="user_name" data-options="required:true" ></input></td>
	    		</tr>
	    		<tr>
	    			<td>密码：</td>
	    			<td><input id="user_password" class="easyui-textbox" type="text" name="user_password" data-options="required:true" ></input></td>
	    		</tr>
	    		<tr>
	    			<td>姓名：</td>
	    			<td><input id="user_realname" class="easyui-textbox" type="text" name="user_realname" data-options="required:true"></input></td>
	    		</tr>
	    		<tr>
	    			<td>岗位：</td>
	    			<td><input id="user_department" class="easyui-textbox" type="text" name="user_department" data-options="required:true"></input></td>
	    		</tr>
	    	</table>
	    </form>
	    <div style="text-align:center;padding:5px">
	    	<a id="saveBtn" href="javascript:void(0)" class="easyui-linkbutton">保存</a>
	    	<a id="aBtn" href="javascript:void(0)" class="easyui-linkbutton" οnclick="clearUpdateForm()">重置</a>
	    </div>
	</div>
  </body>
  	<script type="text/javascript">
  	$(function() {
		//打开弹出框
		$("#saveBtn").click(function(e) {
			submitUpdateForm();
		});
		//关闭弹出框
		$("#aBtn").click(function(e) {
			 clearUpdateForm();
		});
	});
	$(function(){
		jsonArray = getData(1,10);//获取后端数据并转换为Array
		
		var jsonTotal = jsonArray[0].total;//json记录总条数
		var jsonData = jsonArray[0].data;//json数据域
		$("#datagrid").datagrid({
	        title: '用户表',
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
				getUserShow:JSON.stringify(obj)
			},
			success:function(data){
				console.log(data);
				jsonArray = JSON.parse(data);
				
			}
		});
		return jsonArray; 
	}
	</script>
</html>